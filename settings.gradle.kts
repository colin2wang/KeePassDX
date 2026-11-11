pluginManagement {
    repositories {
        // Chinese mirrors (Aliyun), faster in mainland China
        maven { url = uri("https://maven.aliyun.com/repository/google") }
        maven { url = uri("https://maven.aliyun.com/repository/gradle-plugin") }
        maven { url = uri("https://maven.aliyun.com/repository/central") }
    }
}
@Suppress("UnstableApiUsage")
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        // Chinese mirrors (Aliyun), faster in mainland China
        maven { url = uri("https://maven.aliyun.com/repository/google") }
        maven { url = uri("https://maven.aliyun.com/repository/central") }
        // JitPack has no reliable Aliyun mirror; keep the original source
        maven { url = uri("https://jitpack.io") }
    }
}

rootProject.name = "KeePassDX"
include(":app")
include(":database")
include(":crypto")
include(":icon-pack")
include(":icon-pack:classic")
include(":icon-pack:material")
