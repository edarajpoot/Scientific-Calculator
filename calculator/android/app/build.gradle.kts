plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.calculator"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
    jvmTarget = "11"
    }


   defaultConfig {
    applicationId = "com.example.calculator"
    minSdk = flutter.minSdkVersion        
    targetSdk = 34       
    versionCode = 1
    versionName = "1.0.0"
}

   buildTypes {
    getByName("release") {
        signingConfig = signingConfigs.getByName("debug")
        isMinifyEnabled = false
        isShrinkResources = false
    }
}


}

flutter {
    source = "../.."
}
