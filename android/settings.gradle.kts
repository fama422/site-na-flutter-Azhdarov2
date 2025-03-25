pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
    plugins {
        id("com.android.application") version "7.3.0"
        id("org.jetbrains.kotlin.android") version "1.7.10"
    }
}

include(":app")