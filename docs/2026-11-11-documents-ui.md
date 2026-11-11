明白了，你的目标是**明确指定拉起 Android 原生的 `DocumentsUI`**，而不是让澎湃OS用小米文件管理器来“接管”标准的文件选择请求。这个问题的根源在于，在澎湃OS上，标准的 `ACTION_OPEN_DOCUMENT` 或 `ACTION_GET_CONTENT` Intent 会被系统重定向到小米的定制界面。

技术记录显示，标准的文件打开请求最终被 `com.android.fileexplorer/.picker.PickMainNavigatorActivity` 这个组件处理了，而不是原生的 `DocumentsUI`。因此，要绕过它，核心思路是**使用“显式 Intent”（Explicit Intent）**，直接指定目标组件的包名和 Activity 名称。

### 🎯 原生 DocumentsUI 的组件名称

在编写代码前，需要知道原生 `DocumentsUI` 的确切组件信息。不同版本的 Android 可能略有差异：
*   **包名**：通常是 `com.android.documentsui` 或 `com.google.android.documentsui`。
*   **Activity**：常见的有 `.files.FilesActivity`、`.DocumentsActivity` 或 `.files.LauncherActivity`。

在澎湃OS上，`com.google.android.documentsui` 是存在的，但被系统隐藏了。

### 💻 Flutter 端实现方案

你可以通过 `MethodChannel` 编写原生代码，或使用 `android_intent_plus` 插件，来发送显式 Intent。

#### 方案一：通过 MethodChannel 编写原生代码（最可靠）

这是最直接、兼容性最好的方式，能确保 Intent 被精确发送。

**Dart 侧 (`lib/main.dart`)**:
```dart
import 'package:flutter/services.dart';

static const platform = MethodChannel('com.example/native_file_picker');

Future<void> openNativeDocumentsUI() async {
  try {
    await platform.invokeMethod('openDocumentsUI');
  } on PlatformException catch (e) {
    print("调用原生文件选择器失败: '${e.message}'");
  }
}
```

**Android 侧 (`MainActivity.kt`)**:
在 `configureFlutterEngine` 方法中设置 `MethodChannel` 处理器。
```kotlin
import android.content.Intent
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example/native_file_picker"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openDocumentsUI") {
                try {
                    // 尝试构建显式 Intent 指向原生 DocumentsUI
                    val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
                        addCategory(Intent.CATEGORY_OPENABLE)
                        type = "*/*" // 或指定 MIME 类型，如 "image/*"
                        // 关键：直接指定原生 DocumentsUI 的包名和 Activity
                        setClassName(
                            "com.google.android.documentsui", // 或 "com.android.documentsui"
                            "com.android.documentsui.files.FilesActivity" // 尝试此 Activity
                        )
                    }
                    startActivityForResult(intent, 1001)
                    result.success(null)
                } catch (e: Exception) {
                    // 如果显式启动失败，可以回退到隐式 Intent（但可能仍被小米接管）
                    result.error("UNAVAILABLE", "无法直接启动 DocumentsUI: ${e.message}", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
```
**注意**：如果 `FilesActivity` 无法启动，可以尝试将 `setClassName` 中的 Activity 换成 `com.android.documentsui.DocumentsActivity` 或 `com.android.documentsui.files.LauncherActivity`。

#### 方案二：使用 `android_intent_plus` 插件（纯 Dart 实现）

这个插件允许你直接从 Dart 构造并发送 Android Intent，无需编写原生代码。

**1. 添加依赖**:
```bash
flutter pub add android_intent_plus
```

**2. 示例代码**:
```dart
import 'package:android_intent_plus/android_intent.dart';

void launchNativeDocumentsUI() async {
  final intent = AndroidIntent(
    action: 'android.intent.action.OPEN_DOCUMENT',
    category: 'android.intent.category.OPENABLE',
    type: '*/*',
    // 关键：指定目标包名和组件
    package: 'com.google.android.documentsui',
    componentName: 'com.android.documentsui.files.FilesActivity',
  );
  
  try {
    await intent.launch();
  } catch (e) {
    print('启动失败: $e');
    // 可以在这里尝试其他 Activity 名称或回退方案
  }
}
```
**注意**：`componentName` 的格式通常是 `完整类名`，有时也可能需要 `包名/类名` 的形式，具体取决于插件版本和 Android 版本。

### ⚠️ 在澎湃OS上的重要补充

即使你发送了显式 Intent，在部分澎湃OS版本上，系统仍可能进行拦截或提示“安全访问”。如果上述代码无效，说明系统层面的重定向优先级更高。

此时，更根本的解决方法需要**在设备上恢复 `DocumentsUI` 的默认处理地位**。这通常超出了 Flutter 应用的范畴，涉及用户层面的操作：

1.  **通过 ADB 移除/禁用小米文件管理器**：一份针对 HyperOS 4 的技术记录指出，通过 ADB 以当前用户身份移除 `com.android.fileexplorer` 包（非彻底删除系统分区文件），可以有效地让文件选择流程回归原生 `DocumentsUI`。此方法需要用户手动执行 ADB 命令，并了解其影响（小米文件管理器将不可用）。
2.  **使用“DocumentsUI Shortcut”类应用**：这类应用可以在桌面上为被隐藏的原生 `DocumentsUI` 创建一个快捷方式，方便用户直接打开它。但这主要解决的是“**浏览**文件”的需求，而非“**被应用调用**”的需求。

总结来说，**在 Flutter 代码中，最有效的路径是使用显式 Intent（通过 MethodChannel 或 `android_intent_plus`）来直接指定 `com.google.android.documentsui` 的 Activity**。如果系统层面的拦截过于强势，那么最终的解决方案可能需要用户配合进行设备级别的设置调整。