# Android KeePassDX

[English](README.md) | 中文

> ## 关于本分支
>
> 本分支基于原版 **KeePassDX 4.5.8** 修改，包含以下变更：
>
> - **强制调用安卓原生 DocumentsUI 文件选择器**：在小米 HyperOS 上，标准的
>   `ACTION_OPEN_DOCUMENT` 请求会被系统静默重定向到小米文件管理器的"安全访问"流程。
>   本分支改为向原生 `com.android.documentsui` / `com.google.android.documentsui`
>   选择器发送**显式 Intent**（见 `ExternalFileHelper.kt` 与 `AndroidManifest.xml` 中的
>   `<queries>` 声明），当设备上没有原生 DocumentsUI 时会优雅回退到隐式 Intent。
> - **网盘访问**：通过原生 DocumentsUI 选择器，托管在 **OneDrive** 及其他
>   云存储/存储提供方上的数据库文件可以照常访问。
> - **与原版共存**：应用包名增加了 `.hyperos` 后缀
>   （`com.kunzisoft.keepass.hyperos.*`），启动器名称为 `KeePassDX-HyperOS`，
>   可与原版 KeePassDX 并排安装而不会相互覆盖。

<img alt="KeePassDX Icon" src="https://raw.githubusercontent.com/Kunzisoft/KeePassDX/master/art/icon.png"> **轻量的 Android 密码保险箱与管理器**，KeePassDX 以 KeePass 格式在单个加密文件中编辑数据，并以安全的方式自动填充表单。

<img alt="KeePassDX Screenshot" src="https://raw.githubusercontent.com/Kunzisoft/KeePassDX/master/art/screen.jpg" width="220">

### 功能特性

 - 支持 **Passkeys（通行密钥）** 认证与**私钥本地存储**。
 - **生物识别**快速解锁（指纹 / 面容 / ……）。
 - 一次性密码（HOTP / TOTP）管理，用于**两步验证（2FA）**。
 - **自动填充**，轻松填写密码表单。
 - **Magikeyboard** 键盘，高效填写任意字段。
 - 创建**加密的数据库文件**。
 - 按**条目（entry）**和**分组（group）**树状结构整理凭据。
 - 支持**快速打开和复制 URI / URL 字段**。
 - 每种条目类型支持动态**模板**。
 - 每个条目均有**历史记录**。
 - 精细的**设置**管理。
 - Material 设计与**主题**。
 - 支持 **.kdb 和 .kdbx** 文件（版本 1 至 4），采用 AES - Twofish - ChaCha20 - Argon2 算法。
 - 与大多数替代程序**兼容**（KeePass、KeePassXC、KeeWeb 等）。
 - 代码由**原生语言**编写（Kotlin / Java / JNI / C）。

KeePassDX **开源**且**无广告**。

## KeePassDX 是什么？

它是"手动记忆无穷无尽的密码"的一种替代方案。**每个账户使用不同的密码**会让手动记忆难上加难。如果你在所有地方都用同一个密码，而其中某一处的安全失守，攻击者就能访问你的邮箱、网站等——而且你可能毫无察觉。

KeePassDX 是一款 **Android 本地密码与通行密钥管理器**，帮助你**以安全的方式管理密码**。你可以把所有密码放进一个数据库，用**主密钥**和/或**密钥文件**加密锁定。你**只需记住一个主密码和/或选择密钥文件**即可解锁整个数据库。数据库使用当前已知**最安全**的加密算法加密。

## 细则？

KeePassDX 采用**开源 GPL3 许可证**，你可以自由使用、研究、修改和分享。Copyleft 保证这一点永远不变。
任何人都可以基于完整源码构建、分叉，并验证例如加密算法的实现是否正确。
**没有任何广告**。

请放心，**主要功能完全免费**，没有任何安全特性被保留给特定版本；所有用户的加密与数据保护完全一致。

KeePassDX 由志愿者开发和维护，如果你觉得这款应用好用并希望支持它的开发，有多种方式可选。

## 参与贡献

* 通过提交 **[Pull Request](https://help.github.com/articles/about-pull-requests/)** 添加新功能。
* 在 [Weblate](https://hosted.weblate.org/projects/keepass-dx/) 上帮助**[翻译](https://hosted.weblate.org/projects/keepass-dx/strings/)** KeePassDX。
* **[捐赠](https://www.keepassdx.com/#donation)**，为设计、部署、工单跟踪、缺陷修复、新功能开发与维护提供资金支持。之后你将获得支持版 KeePassDX Pro。(づ•ᴗ•)づ♡

*注：支持版提供捐赠后（并附上一句感谢 ≽^•⩊•^≼）可解锁的附加视觉样式，以鼓励这个开源项目的工作！
它不会提升安全性，也没有任何功能上的优势。
如果你贡献了代码却无法使用这些样式，欢迎联系作者 [contact@keepassdx.com](contact@keepassdx.com)。*

## 下载

*[F-Droid](https://f-droid.org/packages/com.kunzisoft.keepass.libre/) 是推荐的安装方式，这是一个 libre 软件项目，会验证所有库和应用代码均为自由软件。*

| 来源 | 状态 | [版本](https://github.com/Kunzisoft/KeePassDX/wiki/FAQ#why-a-libre-and-free-version) |
|--------|--------|---------|
| [Google Play](https://play.google.com/store/apps/details?id=com.kunzisoft.keepass.free) | ![Google Play Release](https://img.shields.io/endpoint?color=blue&logo=google-play&logoColor=green&url=https%3A%2F%2Fplay.cuzi.workers.dev%2Fplay%3Fi%3Dcom.kunzisoft.keepass.free%26gl%3DUS%26hl%3Den%26l%3DGoogle%2520Play%26m%3D%24version) | Free + [Pro](https://play.google.com/store/apps/details?id=com.kunzisoft.keepass.pro) |
| [F-Droid](https://f-droid.org/en/packages/com.kunzisoft.keepass.libre/) | ![F-Droid Version](https://img.shields.io/f-droid/v/com.kunzisoft.keepass.libre?logo=F-Droid&label=F-Droid) | Libre |
| [IzzyOnDroid](https://apt.izzysoft.de/fdroid/index/apk/com.kunzisoft.keepass.free) | ![IzzyOnDroid Version](https://img.shields.io/endpoint?&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAMAAABg3Am1AAADAFBMVEUA0////wAA0v8A0v8A0////wD//wAFz/QA0/8A0/8A0/8A0/8A0v///wAA0/8A0/8A0/8A0/8A0//8/gEA0/8A0/8B0/4A0/8A0/8A0/+j5QGAwwIA0//C9yEA0/8A0/8A0/8A0/8A0/8A0/+n4SAA0/8A0/8A0/+o6gCw3lKt7QCv5SC+422b3wC19AC36zAA0/+d1yMA0/8A0/+W2gEA0/+w8ACz8gCKzgG7+QC+9CFLfwkA0/8A0////wAA0/8A0/8A0/8A0/+f2xym3iuHxCGq5BoA1P+m2joI0vONyiCz3mLO7oYA0/8M1Piq3Ei78CbB8EPe8LLj9Ly751G77zWQ1AC96UYC0fi37CL//wAA0/8A0////wD//wCp3jcA0/+j3SGj2i/I72Sx4zHE8FLB8zak1kYeycDI6nRl3qEA0/7V7psA0v6WzTa95mGi2RvB5XkPy9zH5YJ3uwGV1yxVihRLiwdxtQ1ZkAf//wD//wD//wD//wD//wCn5gf//wD//wD//wD//wD//wAA0/+h4A3R6p8A0/+X1w565OD6/ARg237n9csz2vPz+gNt37V/vifO8HW68B/L6ZOCwxXY8KRQsWRzhExAtG/E612a1Rd/pTBpmR9qjysduKVhmxF9mTY51aUozK+CsDSA52T//wD//wAA0////wD//wBJ1JRRxFWjzlxDyXRc0pGT1wCG0CWB3VGUzSTh8h6c0TSr5CCJ5FFxvl6s4H3m8xML0/DA5CvK51EX1N+Y2gSt4Dag3ChE3fax2ki68yO57NF10FRZnUPl88eJxhuCxgCz5EOLwEGf1DFutmahzGW98x0W1PGk3R154MHE6bOn69qv3gy92oG90o+Hn07B7rhCmiyMwECv1nO+0pQfwrCo57xF2daXsVhKrEdenQAduaee1Bsjr42z5D9RoCXy+QNovXpy2Z5MtWDO/TiSukaF3UtE1K6j3B4YwLc5wXlzpyIK0u5zy3uJqg4pu5RTpkZmpVKyAP8A0wBHcExHcEyBUSeEAAABAHRSTlP///9F9wjAAxD7FCEGzBjd08QyEL39abMd6///8P/ZWAnipIv/cC6B//7////////L/1Dz/0D///////86/vYnquY3/v///5T//v///17///////////////84S3QNB/8L/////////////7r/////NP////9l/////wPD4yis/x7Ym2lWSP+em////0n////////v///////////////////7//7pdGN3Urr6/+v/6aT////+//H/o2P/1v+7r7jp4PM/3p4g////g///K///481LxO///v////9w////8v/////9/p3J///a+P9v/5KR/+n///+p/xf//8P//wAAe7FyaAAABCZJREFUSMdj+E8iYKBUgwIHnwQ3N7cEHxcH+///VayoAE0Dh41qR7aBnCIQ8MsJKHH9/99czYYMWlA0cIkJGjMgAKfq//9RNYzIgLcBWYOTiCgDMhDn+B9bh6LebiWyH6L5UZQzONoAHWSHoqEpDkkDsyKqelv1//9rG1HUN9YihZK9AKp6BkG+/6xNqA5ajhSsCkrIipmYGGRa//9vQXVQXSySBnkWJOUMfn5Myuz/G3hR1NdEIUUchwiy+bkTsg4dbW/fu6W/e1c3XMMy5JiOZkFxUFZo74mgKTqaKXu0+2HqVwkja3BH9kFu361JwcHTfPJD4mdfe8ULAdVRyGlJAcVFfg+CQOozZ4XrJ85+JgwBsVXIGriQw5Tp4ZScez...) | Free |
| [GitHub](https://github.com/Kunzisoft/KeePassDX/releases) / [Obtainium](https://github.com/ImranR98/Obtainium) | ![GitHub Release](https://img.shields.io/github/v/release/Kunzisoft/KeePassDX?include_prereleases&logo=GitHub&label=GitHub) | Free & Libre |

## 从 GitHub 验证安装包真实性
- 从 [GitHub releases](https://github.com/Kunzisoft/KeePassDX/releases/latest) 下载应用
- 从 [Android Studio](https://developer.android.com/studio) 安装 [`apksigner`](https://developer.android.com/tools/apksigner)
- 在终端中打开保存下载文件的目录
- 运行以下命令确认已安装 `apksigner`：
```shell
apksigner --version
```
- 根据你下载的 APK 文件，运行：

```shell
apksigner verify --verbose --print-certs -min-sdk-version 24 KeePassDX-*.apk
```

你应当看到类似输出：
```shell
Verified using v2 scheme (APK Signature Scheme v2): true
...
Number of signers: 1
Signer #1 certificate SHA-256 digest: 7d55b8af210381aabf960f07e17cf7857b6d2a642ca2da6bf0bdf1b200362f04
...
Signer #1 public key SHA-256 digest: 5d261d3176db1e077b80112824d9390167f3be0561827e42112ed6b71192db81
```
如果一致，说明该 APK 确实由 KeePassDX 作者构建。

## 常见问题

还有其他问题？可以阅读 [FAQ](https://github.com/Kunzisoft/KeePassDX/wiki/FAQ)。

## 其他平台

- [KeePass](https://keepass.info/)（https://keepass.info/）是桌面端的官方原版项目，附有标准化数据库文件的技术文档，更新频繁且维护活跃（C# 编写）。

- [KeePassXC](https://keepassxc.org/)（https://keepassxc.org/）是用 C++ 编写的 KeePass 替代实现。

- [KeeWeb](https://keeweb.info/)（https://keeweb.info/）是同样兼容 KeePass 文件的网页版。

## 许可证

  Copyright © 2026 Jeremy Jamet / [Kunzisoft](https://www.kunzisoft.com).

  本文件是 KeePassDX 的一部分。

  [KeePassDX](https://www.keepassdx.com) 是自由软件：你可以根据自由软件基金会发布的
  GNU 通用公共许可证（第 3 版或更高版本）对其进行再分发和/或修改。

  分发 KeePassDX 的目的是希望它有用，
  但不提供任何担保；甚至不提供适销性或特定用途适用性的默示担保。
  有关详情请参阅 GNU 通用公共许可证。

  你应当已随 KeePassDX 收到一份 GNU 通用公共许可证的副本；
  如果没有，请访问 <http://www.gnu.org/licenses/> 查看。

  *本项目是 bpellin 的 [KeePassDroid](https://github.com/bpellin/keepassdroid) 的分支。*
