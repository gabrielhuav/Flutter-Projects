<p align="center">
  <a href="README.md"><img src="https://img.shields.io/badge/%F0%9F%87%AC%F0%9F%87%A7-English-1f6feb?style=for-the-badge" alt="English"></a>
  <a href="README.es.md"><img src="https://img.shields.io/badge/%F0%9F%87%AA%F0%9F%87%B8-Espa%C3%B1ol-d73a49?style=for-the-badge" alt="Español"></a>
</p>

# HolaMundoFlutter — your first cross-platform app with Flutter

A **Hello World written once in Dart**, using **Flutter** to share the screen and logic between **Android and iOS**. The app displays a system greeting, counts taps and follows the phone's light or dark theme.

This is a **step-by-step beginner tutorial**, starting from an empty folder: it explains what Flutter generates, what each file does and how to test it. First we run Android; then we prepare iOS on a Mac. To simply try the app, start with the quick commands in the contents.

The app and some identifiers are in Spanish: **¡Hola, Mundo!** = Hello, World; **Tócame** = Tap me; **saludar** = greet; **veces** = times.

| Android (HolaMundo_Phone emulator) | iOS (simulator) | Real iPhone |
|:---:|:---:|:---:|
| <img src="docs/capturas/android-hola-mundo.png" width="240" alt="The Flutter app running on Android"> | <img src="docs/capturas/ios-hola-mundo.png" width="240" alt="iOS greeting and initial counter on iPhone 17 Pro"> | Captura pendiente (iPhone físico) |

Both platforms use `lib/main.dart`; the greeting consults `nombrePlataforma()`. **Android is verified on Windows; iOS is verified on the iPhone 17 Pro simulator (iOS 26.5), on 2026-10-08. Physical iPhone testing remains pending.** Generic iPhone settings images later in the tutorial do not prove this app has run on iOS.

**Starting without VS Code or Flutter?** Follow [the Windows setup guide](INICIO-WINDOWS.md) or [the Mac one](INICIO-MAC.md) (both in Spanish); this app lives inside the `Flutter-Projects` repository.

---

## Contents

- [Concepts in 3 minutes](#concepts-in-3-minutes)
- [What you need to install](#what-you-need-to-install)
- [If you just want to run it](#if-you-just-want-to-run-it)
- [Part 1 — Android](#part-1--android)
- [1.1 Create the project from an empty folder](#11-create-the-project-from-an-empty-folder)
- [1.2 pubspec.yaml: the project metadata](#12-pubspecyaml-the-project-metadata)
- [1.3 analysis_options.yaml and flutter analyze](#13-analysis_optionsyaml-and-flutter-analyze)
- [1.4 lib/saludo.dart: pure logic](#14-libsaludodart-pure-logic)
- [1.5 lib/plataforma.dart: detect the system](#15-libplataformadart-detect-the-system)
- [1.6 lib/main.dart: the app and screen](#16-libmaindart-the-app-and-screen)
- [1.7 The android/ folder: the native host](#17-the-android-folder-the-native-host)
- [1.8 Open in VS Code and Android Studio](#18-open-in-vs-code-and-android-studio)
- [1.9 Create the emulator](#19-create-the-emulator)
- [1.10 Run it on Android!](#110-run-it-on-android)
- [1.11 Hot reload versus hot restart](#111-hot-reload-versus-hot-restart)
- [1.12 Tests: flutter test](#112-tests-flutter-test)
- [Part 2 — iOS (Mac only)](#part-2--ios-mac-only)
- [2.1 Prepare Xcode and Flutter](#21-prepare-xcode-and-flutter)
- [2.2 The ios/ folder: AppDelegate and scenes](#22-the-ios-folder-appdelegate-and-scenes)
- [2.3 Run on the simulator](#23-run-on-the-simulator)
- [2.4 Run on a real iPhone](#24-run-on-a-real-iphone)
- [2.5 Android and iOS equivalents](#25-android-and-ios-equivalents)
- [Part 3 — What's next?](#part-3--whats-next)
- [3.1 The same change on both platforms](#31-the-same-change-on-both-platforms)
- [3.2 Exercise: a Reiniciar button and its test](#32-exercise-a-reiniciar-button-and-its-test)
- [3.3 Recommended next steps](#33-recommended-next-steps)
- [Part 4 — Use this repo as the base for your app](#part-4--use-this-repo-as-the-base-for-your-app)
- [4.1 What you need for it to run](#41-what-you-need-for-it-to-run)
- [4.2 What to change to make it YOUR app](#42-what-to-change-to-make-it-your-app)
- [4.3 What is best left unchanged](#43-what-is-best-left-unchanged)
- [4.4 Icons and checking the old name](#44-icons-and-checking-the-old-name)
- [Troubleshooting](#troubleshooting)
- [Versions used](#versions-used)
- [Final structure](#final-structure)
- [Pending screenshots](#pending-screenshots)

## Concepts in 3 minutes

**Flutter** is Google's toolkit for building interfaces and compiling applications from one project. **Dart** is the language used by this app. Flutter includes the Dart SDK, so you do not install Dart separately. Here we share the greeting, counter and screen between Android and iOS.

A **widget** describes a piece of the interface: text, a button, spacing or an entire screen. Widgets compose: a `Column` contains `Text` widgets and a button; `Center` centers that column. The `build()` method returns this description and may run many times. Keep long operations and downloads out of `build()`.

| Concept | In this app |
|---|---|
| `StatelessWidget` | `HolaMundoApp` receives `plataforma` and configures the theme; it has no counter of its own. It can rebuild when its inputs change. |
| `StatefulWidget` | `PantallaInicio` has a separate `State` object containing `_veces`. The widget describes configuration; the `State` keeps changing data. |
| `setState` | Changes `_veces` and requests a rebuild to show the new text. Its callback must be synchronous. |
| Hot reload | Loads Dart changes during a debug session while preserving state. It does not run `main()` again. |
| Native folders | `android/` and `ios/` start Flutter and contain permissions, identifiers, icons and build settings. |

The flow is `main()` → `HolaMundoApp` → `MaterialApp` → `PantallaInicio`. A pure function supplies the greeting, and `nombrePlataforma()` supplies the system name.

| | Flutter (this repo) | [Kotlin Multiplatform (HolaMundoKMP)](https://github.com/gabrielhuav/HolaMundoKMP) |
|---|---|---|
| Shared language | Dart | Kotlin |
| Interface in these examples | Flutter widgets | Compose Multiplatform |
| Shared code | `lib/` | `shared/src/commonMain/` |
| System differences | `Platform`, plugins or platform channels | Source sets and `expect` / `actual` |
| Android / iOS project | `android/` / `ios/` | `androidApp/` / `iosApp/` |

KMP can share logic alone while keeping native interfaces; the reference example uses Compose to share the interface too. You do not translate the KMP tutorial's Kotlin files into this project: Flutter generates its native hosts.

## What you need to install

| Tool | Windows: Android | Mac: Android + iOS | Purpose |
|---|---|---|---|
| Flutter SDK | Yes | Yes, macOS distribution | Includes Dart, Flutter tools and engine. |
| Android Studio | Yes | Yes for Android | Includes SDK, Device Manager, emulator and a JDK. |
| VS Code + Dart Code's Flutter extension | Recommended | Recommended | Adds Dart support, debugging and device selection. |
| Xcode | Unavailable | Yes for iOS | Builds, signs and runs iPhone simulators. |
| CocoaPods | Not for Android | Only if native plugins require it | Native iOS dependencies; this example adds no camera, GPS or similar plugins. |
| Git or GitHub Desktop | Yes | Yes | Download the repository and review changes. |

1. Follow the [official Flutter installation guide](https://docs.flutter.dev/install) for your system; put the SDK in a simple path and add its `bin` folder to PATH as that guide explains.
2. Finish Android Studio's setup wizard and check **SDK Manager**: SDK Platform, Platform-Tools, Android SDK Command-line Tools and Android Emulator.
3. In VS Code, open Extensions and find **Flutter**, published by **Dart Code**; it also installs Dart support. Android Studio is an alternative editor if you already have the Flutter/Dart plugins.
4. Open a new terminal and check the installation:
```bash
flutter --version
```

```bash
flutter doctor
```


### How to read flutter doctor

For Android, check Flutter, **Android toolchain**, Android Studio and a connected device. For iOS, also check Xcode on the Mac. Visual Studio warnings concern Windows desktop applications and do not block this Android/iOS tutorial. Initial package and emulator image downloads need internet and free disk space.

If SDK licenses are missing, read and accept the applicable licenses:
```bash
flutter doctor --android-licenses
```


## If you just want to run it

**1. Clone the repository.** In GitHub Desktop: **File → Clone repository… → URL**, paste `https://github.com/gabrielhuav/Flutter-Projects.git` and choose a folder. On Windows, use a path without accents, such as `C:\dev`. From a terminal:
```bash
git clone https://github.com/gabrielhuav/Flutter-Projects.git
```

```bash
cd Flutter-Projects/HolaMundoFlutter
```

```bash
flutter pub get
```


### Choose the device and run

**2. Start an Android emulator** in Device Manager or connect a phone with USB debugging enabled. On a Mac, you can also open an iPhone simulator (Part 2). **3. Run from the root**, the folder containing `pubspec.yaml`:
```bash
flutter devices
```

```bash
flutter run
```


# Part 1 — Android

We will build it in file order: project metadata, logic, platform detection and screen, followed by the Android host. If you cloned this repo, its files are ready: read and compare them; do not run `flutter create` over your clone to follow the tutorial.

Run commands from a VS Code terminal, Android Studio terminal or PowerShell. Each block contains **one command**. Copy it without the block delimiters; do not add a `$` prompt.

## 1.1 Create the project from an empty folder

Open a terminal in an empty working folder, such as `C:\dev` on Windows. The command creates **a new HolaMundoFlutter folder** inside it. `--org` sets the identifier prefix, `--project-name` sets the Dart name (lowercase with underscores), and `--platforms` generates just the Android and iOS hosts.
```bash
flutter create --org com.example --project-name hola_mundo_flutter --platforms android,ios HolaMundoFlutter
```

```bash
cd HolaMundoFlutter
```


### What Flutter generates and what you will replace

| File or folder | Generated content / what we will do |
|---|---|
| `pubspec.yaml`, `pubspec.lock` | Dependencies and resolved versions. Keep the lock to reproduce the app. |
| `analysis_options.yaml` | Analysis rules. |
| `lib/main.dart` | Template counter; replace it with the complete file in 1.6. |
| `lib/saludo.dart`, `lib/plataforma.dart` | Not generated: create them in 1.4 and 1.5. |
| `test/widget_test.dart` | Template counter test; replace it with 1.12. Add `saludo_test.dart`. |
| `android/`, `ios/` | Native projects and initial resources. Compare their configuration in 1.7 and 2.2. |
| `.gitignore`, `.metadata` | Exclusions and metadata used by Flutter. |

This tutorial documents **this repository's actual code**, created with Flutter 3.47.6. A different Flutter version may generate different files. The creation command does not automatically produce our greetings or custom display name. Linked file excerpts are copied from those files; exercise proposals are explicitly marked as optional changes.

Do not copy `build/`, `.dart_tool/` or personal paths such as `android/local.properties` from another computer. Flutter regenerates those values on each machine.

## 1.2 pubspec.yaml: the project metadata

This is the actual file's content **with template comments and empty lines omitted**. Keep these entries and indentation in your new project (YAML uses spaces, not tabs):
[`pubspec.yaml`](pubspec.yaml):

```yaml
name: hola_mundo_flutter
description: "Hola Mundo multiplataforma con Flutter (Android + iOS)"
publish_to: 'none' # Remove this line if you wish to publish to pub.dev
version: 1.0.0+1
environment:
  sdk: ^3.8.0
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
flutter:
  uses-material-design: true
```


### How to read the dependencies

| Entry | Meaning |
|---|---|
| `name` | Dart package name. Test imports start with `package:hola_mundo_flutter/`. |
| `publish_to: 'none'` | Prevents accidentally publishing this package to pub.dev. |
| `version: 1.0.0+1` | Display version `1.0.0` and build number `1`. Android and iOS receive these values. |
| `environment.sdk: ^3.8.0` | Allowed Dart constraint; **not** the installed version, which is 3.13.5 here. |
| `flutter` with `sdk: flutter` | Framework supplied by the installed SDK. |
| `cupertino_icons` | iOS-style icon font, not a native plugin requiring CocoaPods. |
| `flutter_test` | Testing tools, only for development. |
| `flutter_lints: ^6.0.0` | Recommended rules enabled by `analysis_options.yaml`. |
| `uses-material-design: true` | Includes the Material icon font. |

After changing dependencies, fetch the packages. `pubspec.lock` records resolved versions; do not edit it manually.
```bash
flutter pub get
```


## 1.3 analysis_options.yaml and flutter analyze

The analyzer finds Dart errors and style recommendations without starting a phone. `include` enables flutter_lints; `exclude` skips the listed directories during Dart analysis. This **does not** disable Gradle or Xcode checks. Literal excerpt from the actual file:
[`analysis_options.yaml`](analysis_options.yaml):

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - build/**
    - android/**
    - ios/**
```

```bash
flutter analyze
```


### Actual analysis result

Output from this tutorial's Windows verification (result line only; timing depends on the machine):
```text
No issues found! (ran in 17.6s)
```


## 1.4 lib/saludo.dart: pure logic

Create this file inside `lib/`. It imports no Flutter code: it turns data into text. `=>` defines a single-expression function. The `switch` returns one text for 0, another for 1, and uses `_` for all remaining cases. `$plataforma` and `$veces` insert values into a string.
[`lib/saludo.dart`](lib/saludo.dart):

```dart
/// Lógica pura: no sabe nada de pantallas, ni de Android, ni de iOS.
/// Por eso se puede probar con pruebas unitarias (ver test/saludo_test.dart).
library;

/// Saludo que se muestra en la tarjeta, por ejemplo "¡Hola desde Android!".
String saludar(String plataforma) => '¡Hola desde $plataforma!';

/// Texto del contador con la palabra en singular o plural.
String textoContador(int veces) => switch (veces) {
      0 => 'Todavía no has tocado el botón',
      1 => 'Has tocado el botón 1 vez',
      _ => 'Has tocado el botón $veces veces',
    };
```


## 1.5 lib/plataforma.dart: detect the system

Create this second file. `show` imports just the named symbol. `Platform.isAndroid` and `Platform.isIOS` answer at runtime; there is no need for two greeting files. The function returns `Android` or `iOS`, which then goes into `saludar()`.
[`lib/plataforma.dart`](lib/plataforma.dart):

```dart
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

/// Nombre del sistema operativo en el que corre la app.
///
/// El mismo código Dart se compila para Android y para iOS; `Platform` nos
/// dice en cuál estamos en tiempo de ejecución.
String nombrePlataforma() {
  if (kIsWeb) return 'la Web'; // dart:io no existe en la Web: se revisa antes.
  if (Platform.isAndroid) return 'Android';
  if (Platform.isIOS) return 'iOS';
  return Platform.operatingSystem; // windows, macos, linux…
}
```


### Scope of platform detection

The `kIsWeb` check comes before accessing `Platform`, but this project was created for **Android and iOS**: it has no `web/` host and has not been validated for the web. The direct `dart:io` import requires checking web compatibility and, where appropriate, conditional imports when adding targets. The fallback returns the system name for other environments, without guaranteeing a native host exists.

The `plataforma` parameter also lets tests pass `'Pruebas'`: they do not depend on whether the testing computer runs Windows, Linux or macOS.

## 1.6 lib/main.dart: the app and screen

Replace **the entire** template counter with this actual file. Relative imports find the two previous files in `lib/`. `main()` calls `runApp`, which places the first widget on screen. The interface remains in Spanish when following the English README too.
[`lib/main.dart`](lib/main.dart):

```dart
import 'package:flutter/material.dart';

import 'plataforma.dart';
import 'saludo.dart';

/// Punto de entrada: Android e iOS arrancan AQUÍ, con el mismo código.
void main() {
  runApp(HolaMundoApp(plataforma: nombrePlataforma()));
}

/// La app completa. Recibe el nombre de la plataforma como parámetro para
/// que las pruebas puedan pasarle uno "de mentira" (ver test/widget_test.dart).
class HolaMundoApp extends StatelessWidget {
  const HolaMundoApp({super.key, required this.plataforma});

  final String plataforma;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hola Mundo Flutter',
      debugShowCheckedModeBanner: false,
      // Tema claro u oscuro según el sistema del teléfono.
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      home: PantallaInicio(plataforma: plataforma),
    );
  }
}

/// La pantalla. Es `StatefulWidget` porque guarda un dato que cambia: el contador.
class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key, required this.plataforma});

  final String plataforma;

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  int _veces = 0;

  void _tocar() {
    // setState avisa a Flutter que el estado cambió y que debe redibujar.
    setState(() => _veces++);
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '¡Hola, Mundo!',
                  style: tema.textTheme.displaySmall?.copyWith(
                    color: tema.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Flutter · Android + iOS',
                  style: tema.textTheme.titleMedium,
                ),
                const SizedBox(height: 32),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Text(
                      saludar(widget.plataforma),
                      style: tema.textTheme.titleLarge,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: _tocar,
                  child: const Text('Tócame'),
                ),
                const SizedBox(height: 16),
                Text(
                  textoContador(_veces),
                  style: tema.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```


### Read the widget tree and state

`HolaMundoApp` configures `MaterialApp`: `title` is an internal title and **does not** change the name beneath the system icon. `debugShowCheckedModeBanner: false` hides the DEBUG ribbon. `ThemeMode.system` chooses `theme` or `darkTheme` based on the phone; both build colors from `Colors.deepPurple`.

`PantallaInicio` receives `plataforma` as immutable data (`final`). Its `createState()` creates `_PantallaInicioState`; the underscore makes the name private within the Dart library. `_veces` starts at 0. A tap calls `_tocar()`, which calls `setState(() => _veces++)`; Flutter runs `build()` again and `textoContador()` receives the new value.

| Widget / API used | What it does here |
|---|---|
| `MaterialApp` | Theme and initial screen. |
| `Scaffold` | Material screen structure and background. |
| `SafeArea` | Keeps content clear of system bars and cutouts. |
| `Center` | Centers its child. |
| `Padding`, `EdgeInsets` | Inner margins: 24 around the content and space inside the card. |
| `Column` | Stacks children; `mainAxisSize.min` uses just their content height. |
| `Text` | Title, description, greeting and counter. |
| `Card` | Greeting card background and shape. |
| `FilledButton` | Calls `_tocar` through `onPressed`; passing the function does not execute it during `build()`. |
| `SizedBox` | Gaps of 8, 16 and 32 logical pixels. |
| `Theme.of(context)` | Reads current theme colors and text styles. |

`const` describes widgets whose arguments do not change; `super.key` supports widget identity. `widget.plataforma` accesses configuration from the `State`. Without `setState`, the number would change in memory, but you would not request a text update. The counter lives **in memory**: rebuilding for a theme change preserves it, but closing the app or a hot restart does not. Persisting data is a separate learning step.

## 1.7 The android/ folder: the native host

Flutter generates the Gradle project, resources and Wrapper (`gradlew`, `gradlew.bat` and `gradle/wrapper/`). You do not install Gradle separately. Flutter compiles Dart and calls Gradle to package the Android app.

**MainActivity** is all the Kotlin written for this screen. Its package matches the `namespace` and the `com/example/hola_mundo_flutter` folder:
[`android/app/src/main/kotlin/com/example/hola_mundo_flutter/MainActivity.kt`](android/app/src/main/kotlin/com/example/hola_mundo_flutter/MainActivity.kt):

```kotlin
package com.example.hola_mundo_flutter

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity()
```


### Manifest: display name and Activity

To reproduce the app, set the new template's `android:label` to the value in this actual file. `android:name="${applicationName}"` is a placeholder resolved by Flutter, not a name to replace with your app's name. `android:icon` points to a resource. The `.MainActivity` activity opens Flutter; `configChanges` includes `uiMode`, allowing theme changes without recreating the Activity for that reason. Keep Flutter's metadata.
[`android/app/src/main/AndroidManifest.xml`](android/app/src/main/AndroidManifest.xml):

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="Hola Mundo Flutter"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <!-- Required to query activities that can process text, see:
         https://developer.android.com/training/package-visibility and
         https://developer.android.com/reference/android/content/Intent#ACTION_PROCESS_TEXT.

         In particular, this is used by the Flutter engine in io.flutter.plugin.text.ProcessTextPlugin. -->
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>
```


### App Gradle: identifier and Java 17

`applicationId` identifies the installed application; `namespace` is the Android code namespace. They are equal here. SDK, NDK and version values come from Flutter or `pubspec.yaml`, rather than hard-coded numbers that could become outdated. The actual file:
[`android/app/build.gradle.kts`](android/app/build.gradle.kts):

```kotlin
plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.hola_mundo_flutter"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.hola_mundo_flutter"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
```


### Plugin and Wrapper versions

`settings.gradle.kts` locates the Flutter SDK using `local.properties`, adds its Gradle tools and declares AGP **9.1.0** and Kotlin **2.4.0**. Although it declares the Kotlin plugin with `apply false`, the app file does not explicitly apply it. Do not change plugins to match the KMP recipe: this template has its own Flutter integration.
[`android/settings.gradle.kts`](android/settings.gradle.kts):

```kotlin
pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.1.0" apply false
    id("org.jetbrains.kotlin.android") version "2.4.0" apply false
}

include(":app")
```

[`android/gradle/wrapper/gradle-wrapper.properties`](android/gradle/wrapper/gradle-wrapper.properties):

```properties
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-9.3.1-all.zip
```

[`android/gradle.properties`](android/gradle.properties):

```properties
org.gradle.jvmargs=-Xmx8G -XX:MaxMetaspaceSize=4G -XX:ReservedCodeCacheSize=512m -XX:+HeapDumpOnOutOfMemoryError
android.useAndroidX=true
# This newDsl flag was added by the Flutter template
android.newDsl=false
# This builtInKotlin flag was added by the Flutter template
android.builtInKotlin=false
```


### Which Java each part uses

The Wrapper downloads **Gradle 9.3.1**. In `app/build.gradle.kts`, `sourceCompatibility`, `targetCompatibility` and `jvmTarget` set **Java/JVM 17** as the code target. This differs from the JDK that **runs Gradle**: this project builds with Android Studio's Java 25. There is no `android/gradle/gradle-daemon-jvm.properties` here, and the old documentation's workaround is unnecessary.

`android/gradle.properties` keeps the template's `android.newDsl=false` and `android.builtInKotlin=false`. Do not remove them just because a different project's tutorial uses AGP differently. The root [`android/build.gradle.kts`](android/build.gradle.kts) sets repositories and puts outputs under the root `build/` directory. `local.properties` is machine-specific: let Flutter generate it.

## 1.8 Open in VS Code and Android Studio

**VS Code:** open **File → Open Folder…** and select the `HolaMundoFlutter` root containing `pubspec.yaml`, `lib/` and `android/`. Check that Dart Code's Flutter extension is installed. Use **Terminal → New Terminal** to run commands inside that folder. You can also open it from a terminal:
```bash
code .
```


### Restricted Mode: trust the folder

The preserved screenshot from the previous documentation shows **Restricted Mode**. VS Code limits project and extension features when the folder is untrusted. If you recognize the source of the code, choose **Manage → Trust**, or accept **Yes, I trust the authors** when opening your own project. You do not need to disable trust protection for all folders.

<img src="docs/capturas/vscode-modo-restringido.png" width="1000" alt="VS Code with the Flutter project and Restricted Mode banner">

**Android Studio:** **File → Open…** → `HolaMundoFlutter` root. With Flutter/Dart support already installed, open `lib/main.dart`, select that file's Flutter run configuration and the emulator, and click ▶. Wait for analysis and initial downloads. Select **Project** in the left panel to see all files. Opening only `android/` shows the native host, not all the Dart code.

If **Trust Project** appears, decide whether you trust the code before opening it. If the Flutter plugin is missing, you can follow the tutorial with VS Code and a terminal; Android Studio still supplies the SDK and Device Manager.

**Android Studio screenshot pending:** the project window opened, but both the capture script and the alternative window capture returned a black image. That PNG was not included in the tutorial.

## 1.9 Create the emulator

1. In Android Studio, open **Tools → Device Manager**; on the welcome screen it may be under **More Actions → Virtual Device Manager**.
2. Click **+ → Create Virtual Device** and choose a phone profile, such as Pixel.
3. Choose a recent Android image. On Windows Intel/AMD use **x86_64**; on Apple Silicon Macs use **arm64-v8a**. Download the image in the wizard if it is missing.
4. Name the AVD **HolaMundo_Phone** and click **Finish**.
5. Click ▶ next to that AVD. Wait for the Android home screen before installing.

This tutorial's screenshots use **HolaMundo_Phone**, but any emulator works. A physical phone with USB debugging also works; accept your computer's authorization on the phone.

To list AVDs and start the tutorial's emulator:
```bash
flutter emulators
```

```bash
flutter emulators --launch HolaMundo_Phone
```


## 1.10 Run it on Android!

With the emulator running, check what Flutter sees and launch:
```bash
flutter devices
```

```bash
flutter run
```


### Select a device and read the output

If multiple devices are connected, choose Android in the list. To pin this session's emulator (its number can differ on another computer):
```bash
flutter run -d emulator-5554
```


```text
Launching lib\main.dart on sdk gphone64 x86 64 in debug mode...
Running Gradle task 'assembleDebug'...
√ Built build\app\outputs\flutter-apk\app-debug.apk
Installing build\app\outputs\flutter-apk\app-debug.apk...
Syncing files to device sdk gphone64 x86 64...

Flutter run key commands.
r Hot reload.
R Hot restart.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).
```


### What appears on screen

The output above is the **actual emulator output supplied** in the tutorial instructions; it is not an iOS run. `flutter run` stays open waiting for keys: type `r` for hot reload, `R` for hot restart and `q` to quit. The first build may take longer because of downloads and initial compilation.

In **VS Code**, select the device in the bottom bar and press **F5**; output appears in **Debug Console** with debugging controls. In Android Studio with the Flutter plugin, use the `lib/main.dart` run configuration, device selector and ▶.

| Fresh launch | After three taps | Dark mode, same counter |
|:---:|:---:|:---:|
| <img src="docs/capturas/android-hola-mundo.png" width="240" alt="Android greeting and initial counter"> | <img src="docs/capturas/android-tres-toques.png" width="240" alt="Counter after three taps"> | <img src="docs/capturas/android-modo-oscuro.png" width="240" alt="Dark mode preserving three taps"> |

The card shows **¡Hola desde Android!** (Hello from Android). Tap **Tócame** three times: the text should read **Has tocado el botón 3 veces** (You tapped the button 3 times). Turn on the device's dark mode: colors change and the counter is preserved. These screenshots were captured from the actual tutorial app.

If you only want an installable debug APK, this command finishes on its own and places the file in `build/app/outputs/flutter-apk/app-debug.apk`:
```bash
flutter build apk --debug
```


## 1.11 Hot reload versus hot restart

With a **debug** `flutter run` session open, tap the button and change `'¡Hola, Mundo!'` to `'¡Hola, ESCOM!'` in `lib/main.dart`. Save and type `r` in that terminal. The title changes and the counter keeps its value. If your editor has hot reload on save enabled, saving is enough; do not assume every installation enables it.

| | Hot reload | Hot restart | Full restart |
|---|---|---|---|
| Terminal / editor | `r` / ⚡ | `R` / Hot Restart control | Stop and run again |
| Counter | Preserved | Resets to 0 | Resets to 0 |
| `main()` and initialization | Not run again | Run again | Run again |
| Use for | Text, colors, widget changes | Initial state or changes reload cannot apply | Kotlin, Swift, permissions, plugins and native settings |

There is no fixed timing promise: it depends on the machine and change. If reload rejects a change, read the error, fix Dart and retry; a restart may be required. Release does not support hot reload. See the [official hot reload guide](https://docs.flutter.dev/tools/hot-reload).

## 1.12 Tests: flutter test

Replace the template's original counter test and create `saludo_test.dart` with the following files. Keeping the old test makes it look for text and buttons that no longer exist. Run from the root:
```bash
flutter test
```


### Unit tests and the widget test

Unit tests call functions without drawing a screen. They check both systems and the counter's 0, 1 and plural cases. The widget test builds the app **in memory, without an emulator**, injects `'Pruebas'`, finds text, taps the `FilledButton` three times and calls `pump()` to process each rebuild.
[`test/saludo_test.dart`](test/saludo_test.dart):

```dart
import 'package:flutter_test/flutter_test.dart';

import 'package:hola_mundo_flutter/saludo.dart';

/// Pruebas unitarias: solo lógica, sin widgets. Son las más rápidas.
void main() {
  test('saluda con el nombre de la plataforma', () {
    expect(saludar('Android'), '¡Hola desde Android!');
    expect(saludar('iOS'), '¡Hola desde iOS!');
  });

  test('el contador usa singular y plural', () {
    expect(textoContador(0), 'Todavía no has tocado el botón');
    expect(textoContador(1), 'Has tocado el botón 1 vez');
    expect(textoContador(5), 'Has tocado el botón 5 veces');
  });
}
```

[`test/widget_test.dart`](test/widget_test.dart):

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hola_mundo_flutter/main.dart';

/// Prueba de widget: arma la pantalla en memoria (sin teléfono), la "toca"
/// y revisa lo que se ve. Se ejecuta con `flutter test`.
void main() {
  testWidgets('muestra el saludo y cuenta los toques', (WidgetTester tester) async {
    // Se pasa una plataforma "de mentira" para no depender del sistema real.
    await tester.pumpWidget(const HolaMundoApp(plataforma: 'Pruebas'));

    expect(find.text('¡Hola, Mundo!'), findsOneWidget);
    expect(find.text('¡Hola desde Pruebas!'), findsOneWidget);
    expect(find.text('Todavía no has tocado el botón'), findsOneWidget);

    // Tocar el botón 3 veces.
    for (var i = 0; i < 3; i++) {
      await tester.tap(find.widgetWithText(FilledButton, 'Tócame'));
      await tester.pump(); // redibuja después de cada setState
    }

    expect(find.text('Has tocado el botón 3 veces'), findsOneWidget);
  });
}
```


### Actual test result

Actual output from this verification, using the expanded reporter (personal paths are omitted in this result view):


```text
00:00 +0: loading C:/Users/gabri/OneDrive/Escritorio/FlutterProjects/HolaMundoFlutter/test/saludo_test.dart
00:00 +0: C:/Users/gabri/OneDrive/Escritorio/FlutterProjects/HolaMundoFlutter/test/saludo_test.dart: saluda con el nombre de la plataforma
00:00 +1: C:/Users/gabri/OneDrive/Escritorio/FlutterProjects/HolaMundoFlutter/test/saludo_test.dart: el contador usa singular y plural
00:00 +2: C:/Users/gabri/OneDrive/Escritorio/FlutterProjects/HolaMundoFlutter/test/widget_test.dart: muestra el saludo y cuenta los toques
00:01 +3: All tests passed!
```


These three tests cover logic and widgets. They do not demonstrate iOS signing, compilation or launch: those need verification on a Mac. Android is also checked separately with the APK and emulator.

# Part 2 — iOS (Mac only)

**Verified on the simulator on 2026-10-08 with Flutter 3.47.6 stable and the existing Xcode 26.6 tools.** The three iOS screenshots in 2.3 show this Flutter app. Generic iPhone settings screenshots copied from HolaMundoKMP do not prove execution on a physical phone. After updating to Xcode 27.0, execution from its interface was also verified and both Xcode screenshots were captured. Physical iPhone testing remains pending.

On Windows, you can edit shared Dart and run Android. Building and signing iOS requires macOS with Xcode. Do not apply the KMP tutorial's Gradle phases or Shared framework to Flutter: Flutter's host already includes its own integration.

## 2.1 Prepare Xcode and Flutter

1. Install Xcode compatible with your macOS and open it once to finish installation. Download an iOS runtime in **Settings → Components** (the name may vary with Xcode).
2. In the Mac terminal, select Xcode and complete its first launch; adjust the path if installed elsewhere. These commands **prepare your Mac** and were not run during this Windows task:
```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

```bash
sudo xcodebuild -runFirstLaunch
```

```bash
flutter doctor
```


### Dependencies and checks on the Mac

Read and accept Xcode's license if requested. `flutter doctor` should recognize Flutter and Xcode. Install a missing iOS runtime through Xcode before opening the simulator. Follow the [official iOS setup guide](https://docs.flutter.dev/platform-integration/ios/setup) for your version's details.

Clone the repo as described at the start, enter `HolaMundoFlutter` and run `flutter pub get`. **CocoaPods is involved only if native plugins or their integration need it**; `cupertino_icons` is a font, not a plugin. Recent templates can also use Swift Package Manager. Do not create a Podfile or add dependencies blindly. If a plugin requires CocoaPods, follow its guide and the [CocoaPods installation instructions](https://guides.cocoapods.org/using/getting-started.html).

### Actual Mac verification — 2026-10-08

The clean GitHub Desktop clone at `~/Documents/GitHub/Flutter-Projects/HolaMundoFlutter`, revision `15a8568`, was reused; it matches the published repository. No applicable `AGENTS.md` files were found. No duplicate clone was created and no changes were overwritten.

| Component | Observed result |
|---|---|
| Mac | Apple M1 Pro, arm64, 32 GB; macOS 27.0.1, build 26A434. |
| Git | Existing 2.50.1 (Apple Git-155). |
| Xcode and tools | 26.6, build 17F113 for the initial check; **currently 27.0, build 27A266a**; selected `/Applications/Xcode.app/Contents/Developer`; first launch complete. `clang` available; iOS 26.5 Simulator SDK for the initial check and 27.0 after the update. No separate Command Line Tools receipt; Xcode's included tools are used. |
| Existing runtimes | iOS 18.2 and iOS 26.5; only iOS 26.5 was tested. |
| Installed VS Code | 1.141.0 arm64, official Microsoft download; SHA-256 and signature verified. |
| Installed extensions | Dart Code Flutter and Dart, both 3.144.0. |
| Installed Flutter | 3.47.6 stable, revision `5fc346839b`; Dart 3.13.5; `~/dev/flutter`. |
| Configuration | Flutter and `code` PATH entries in `~/.zprofile`, without duplicates; `dart.flutterSdkPath` in VS Code user settings. This project folder is enabled and iPhone 17 Pro selected in the editor. |
| Existing Android tools | Android Studio 2026.2, doctor-reported SDK 36.0.0 and JDK 25.0.3. These were not reinstalled; Android was not tested on this Mac. |

The Flutter arm64 ZIP and release index returned HTTP 404. **The requested version was retained** by installing tag `3.47.6` from the [official Flutter repository](https://github.com/flutter/flutter/tree/3.47.6), on a local `stable` branch pinned to that revision; Flutter downloaded arm64 Dart. No replacement version was chosen and `flutter upgrade` was not run.

`flutter doctor -v` finished with issues in **2 categories**: missing CocoaPods and missing Chrome. Flutter, Android toolchain, devices and network passed. The app uses Swift Package Manager and has no native plugins; the iOS build succeeded **without installing CocoaPods**. Chrome was not installed because Web was not tested. Doctor also reported discovery warnings for other wireless phones; they do not block the simulator.

**Verified Xcode update:** the initial check used Xcode 26.6 tools, whose interface would not open on macOS 27.0.1. The user updated Xcode to **27.0 (27A266a)** and accepted its license. Only one installation was found, `/Applications/Xcode.app`; the previous copy at that path was replaced and the iOS 18.2 and 26.5 runtimes were preserved. `xcodebuild -checkFirstLaunchStatus` passed and `flutter doctor -v` recognizes Xcode 27.0, retaining the missing CocoaPods and Chrome warnings.

`ios/Runner.xcworkspace` was opened, the **Runner** scheme and **iPhone 17 Pro (iOS 26.5)** selected, and Run (⌘R) used. Xcode displayed **Running Runner on iPhone 17 Pro**, with an active process in the Debug navigator; Device Hub displayed **¡Hola desde iOS!** and the initial counter. `xcode-ejecutar.png` and `xcode-signing.png` are actual Xcode 27 windows, original 2800×1800 captures reviewed without personal information. No Team was selected and the Bundle ID was not changed. Xcode displayed 25 `Stale file … outside of the allowed root paths` warnings for generated outputs from the previous build and one settings recommendation; these did not prevent execution. Recommended settings were not applied. The automatic project format conversion (`objectVersion` 54 → 60) was reverted after closing Xcode; no native changes are included.

## 2.2 The ios/ folder: AppDelegate and scenes

The folder is already generated; you do not create another SwiftUI app or insert a KMP screen. **Runner** is the Xcode target that starts Flutter. The actual template uses `FlutterImplicitEngineDelegate`: plugins register when the implicit engine initializes, through `engineBridge.pluginRegistry`.
[`ios/Runner/AppDelegate.swift`](ios/Runner/AppDelegate.swift):

```swift
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
```

[`ios/Runner/SceneDelegate.swift`](ios/Runner/SceneDelegate.swift):

```swift
import Flutter
import UIKit

class SceneDelegate: FlutterSceneDelegate {

}
```


### Info.plist and lifecycle

`SceneDelegate` extends `FlutterSceneDelegate`. iOS separates application events from scene (window) events. `Info.plist` declares that scene and its storyboard. `$(PRODUCT_MODULE_NAME).SceneDelegate` resolves during compilation. **Do not replace this AppDelegate with the old one** registering plugins through `self` inside `didFinishLaunchingWithOptions`.

This is the repo's complete `Info.plist`. To reproduce the display name, `CFBundleDisplayName` must contain **Hola Mundo Flutter**. `CFBundleIdentifier` uses Xcode's value; do not hard-code it here. Version and build number come from Flutter:
[`ios/Runner/Info.plist`](ios/Runner/Info.plist):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CADisableMinimumFrameDurationOnPhone</key>
	<true/>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleDisplayName</key>
	<string>Hola Mundo Flutter</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>hola_mundo_flutter</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>$(FLUTTER_BUILD_NAME)</string>
	<key>CFBundleSignature</key>
	<string>????</string>
	<key>CFBundleVersion</key>
	<string>$(FLUTTER_BUILD_NUMBER)</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UIApplicationSceneManifest</key>
	<dict>
		<key>UIApplicationSupportsMultipleScenes</key>
		<false/>
		<key>UISceneConfigurations</key>
		<dict>
			<key>UIWindowSceneSessionRoleApplication</key>
			<array>
				<dict>
					<key>UISceneClassName</key>
					<string>UIWindowScene</string>
					<key>UISceneConfigurationName</key>
					<string>flutter</string>
					<key>UISceneDelegateClassName</key>
					<string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
					<key>UISceneStoryboardFile</key>
					<string>Main</string>
				</dict>
			</array>
		</dict>
	</dict>
	<key>UIApplicationSupportsIndirectInputEvents</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string>LaunchScreen</string>
	<key>UIMainStoryboardFile</key>
	<string>Main</string>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
</dict>
</plist>
```


### iOS workspace, project and resources

| Path | Contents |
|---|---|
| `ios/Runner.xcworkspace` | Workspace to open when working with Runner and integrated dependencies. |
| `ios/Runner.xcodeproj` | Project configuration, targets, Bundle ID, signing and build settings. Included in the workspace. |
| `ios/Runner/AppDelegate.swift`, `SceneDelegate.swift` | Flutter host startup and lifecycle. |
| `ios/Runner/Info.plist` | Display name, orientations and scene configuration. |
| `ios/Runner/Assets.xcassets` | Icons and launch resources. |
| `ios/Runner/Base.lproj` | `Main.storyboard` and `LaunchScreen.storyboard`. |
| `ios/Flutter` | Flutter configuration; do not copy generated file paths to another computer. |

Open the **workspace**, rather than just the `.xcodeproj`, especially with native dependencies. Do not edit `GeneratedPluginRegistrant` or ephemeral files to register packages manually. Consult the [official UIScene migration guide](https://docs.flutter.dev/release/breaking-changes/uiscenedelegate) when adapting an older app.
```bash
open ios/Runner.xcworkspace
```


## 2.3 Run on the simulator

1. Open the simulator on the Mac:
```bash
open -a Simulator
```

```bash
flutter devices
```

```bash
flutter run
```


### Select the simulated iPhone

2. In Simulator, choose an iPhone through **File → Open Simulator** if none is booted. Versions naming this app **Device Hub** should use the installed name; the [iOS guide](https://docs.flutter.dev/platform-integration/ios/setup) distinguishes `open -a Simulator` (Xcode 26 or earlier) from `open -a DeviceHub` (Xcode 27).
3. Find its ID in `flutter devices`. With multiple targets, select the simulator in the `flutter run` menu, or use `flutter run -d SIMULATOR_ID`, replacing the ID with the real one.
4. In VS Code, select the iPhone in the bottom bar and press F5. In Xcode, choose **Runner**, the simulator and ▶ (⌘R); to practice hot reload, use a Flutter terminal or editor session.
5. During the 2026-10-08 verification, the card displayed **¡Hola desde iOS!**. The initial counter displayed **Todavía no has tocado el botón**; three actual taps changed it to **Has tocado el botón 3 veces**. Switching the simulator to dark mode without restarting preserved the count of 3. Afterwards, hot restart (`R`) reset the counter to 0. App behavior was not changed and Reiniciar was not implemented.

The iPhone was identified using `flutter devices` and this iOS target was selected explicitly:

```bash
flutter run -d EA4C8D0F-B2B1-4330-AD6D-3B62A42F98F0
```

Actual results from `HolaMundoFlutter`:

| Check | Result |
|---|---|
| `flutter pub get` | Successful; lock preserved. Eight packages have newer versions outside the constraints; none were upgraded. |
| `flutter analyze` | `No issues found! (ran in 0.8s)` |
| `flutter test` | `00:00 +3: All tests passed!` — 3/3 tests. |
| Build and launch | `Launching lib/main.dart on iPhone 17 Pro in debug mode...`; `Xcode build done. 39.4s`; file sync and Dart VM Service active. |
| Target | iPhone 17 Pro, iOS 26.5, arm64 simulator. Neither `macos` nor Web was selected. |
| Hot restart | `Restarted application in 242ms.` and initial counter verified on screen. |

| Fresh launch | After three taps | Dark mode, same counter |
|:---:|:---:|:---:|
| <img src="docs/capturas/ios-hola-mundo.png" width="240" alt="iOS greeting and initial counter"> | <img src="docs/capturas/ios-tres-toques.png" width="240" alt="iOS counter after three taps"> | <img src="docs/capturas/ios-modo-oscuro.png" width="240" alt="iOS dark mode preserving three taps"> |

The three original 1206×2622 screenshots were captured with `simctl` and visually reviewed: they show only this app and the status bar, without accounts, notifications or other apps. The additional Xcode 27.0 execution is shown below; the Runner scheme and iPhone 17 Pro are visible alongside the active process. Native build warnings are detailed in 2.1.

<img src="docs/capturas/xcode-ejecutar.png" width="1000" alt="Xcode 27 running Runner on iPhone 17 Pro with an active debug process">

## 2.4 Run on a real iPhone

You need a Mac, Xcode supporting the phone's iOS version, a cable and an Apple ID. The project declares iOS **15.0** as its deployment target; Flutter, Xcode or plugin requirements can raise the effective minimum. iOS 26.5 was verified on the simulator; no physical iPhone was verified. `flutter devices` detected a wireless phone running iOS 26.7.1, but the app was not built, installed or checked on it; signing was not configured.

| Step | Android | iPhone |
|---|---|---|
| Development | Developer options and USB debugging | Developer Mode |
| Cable | Allow USB debugging | Trust This Computer |
| Local signing | Debug key | Apple ID and Team in Xcode |
| First launch | Normal installation | May require trusting the certificate |

**1. Account and signing.** In Xcode → **Settings → Apple Accounts**, add your Apple ID. Open `ios/Runner.xcworkspace`, select the **Runner** project → **Runner** target → **Signing & Capabilities**. Enable **Automatically manage signing** and choose your **Team** (Personal Team can be used for testing).

**2. Unique Bundle ID.** Change `com.example.holaMundoFlutter` to one of your own, such as `com.yourname.myapp`. Do not use another account's Bundle ID; keep Debug, Profile and Release consistent. If changing the test target, review its identifier too. This does not change the Dart greeting code.

**Signing & Capabilities (Xcode 27.0):** the screenshot shows the current configuration, with **Team: None** and the example identifier. The development-team warning concerns signing setup; it did not prevent simulator execution. **It does not prove physical iPhone signing or execution**, which remain pending. No accounts or personal information are visible.

<img src="docs/capturas/xcode-signing.png" width="1000" alt="Runner Signing & Capabilities in Xcode 27 showing Team None">

**3. Connect and trust.** Connect the iPhone, unlock it, accept **Trust This Computer?** and enter the passcode on the phone. Select your iPhone as Xcode's destination and wait if it is being prepared.

**4. Developer Mode.** On the iPhone: **Settings → Privacy & Security → Developer Mode** → enable → restart → unlock and confirm **Turn On**. If the option is missing, connect the iPhone to the Mac first and let Xcode detect it.

| Privacy & Security | Developer Mode |
|:---:|:---:|
| <img src="docs/capturas/iphone-privacidad.png" width="240" alt="Generic iPhone Privacy and Security settings, Spanish UI"> | <img src="docs/capturas/iphone-modo-desarrollador.png" width="240" alt="Developer Mode enabled on the iPhone, Spanish UI"> |

**5. Run.** Back in the project root in the Mac terminal, check `flutter devices` and run `flutter run`, choosing the iPhone. Xcode may request access to the signing key. If **Unlock iPhone to Continue** appears, unlock the phone; if it says **Developer Mode disabled**, review the previous step.

**6. Trust the developer.** If **Untrusted Developer** appears, go to **Settings → General → VPN & Device Management** → **Developer App** → your account → **Trust / Verify App**. The phone needs internet for verification. If the menu is missing, try installing/running the app once and check again.

| Device management | Flutter app on the iPhone |
|:---:|:---:|
| <img src="docs/capturas/iphone-admon-dispositivos.png" width="240" alt="Generic device management settings with anonymized account, Spanish UI"> | Captura pendiente (Mac) |

These three settings screenshots were copied from KMP **because they are generic**. The device management image anonymizes account details; do not use it to claim Flutter has been installed or verified.

**7. Launch from the icon.** On an iPhone, a **debug** Flutter app needs to start through Flutter, an editor or Xcode; it can close when launched from its icon without those tools. To leave a version that starts from the home screen, select the physical iPhone and run:
```bash
flutter run --release
```


### Check the iPhone installation

Release offers no hot reload and must be tested on a **physical device**, not used as a replacement for a simulator debug session. With multiple targets, use the real ID with `flutter run --release -d IPHONE_ID`. After installation, test launching from the icon, the greeting, three taps and dark mode. Save `iphone-hola-mundo.png` once verified.

A Personal Team account has limits and its test signing can expire; sign again from your Mac when that happens. Check Apple's current requirements for distribution. The debug launch issue is documented by the [Flutter project](https://github.com/flutter/flutter/issues/66491).

## 2.5 Android and iOS equivalents

| Android | iOS | Purpose |
|---|---|---|
| `MainActivity.kt` | `AppDelegate.swift` + `SceneDelegate.swift` | Flutter host startup and lifecycle. They are not line-by-line translations. |
| `AndroidManifest.xml` | `Info.plist` | Display name, configuration and permissions; iOS also requires permission explanation strings. |
| `applicationId` | Runner Bundle Identifier | Installed app identity. |
| `android:label` | `CFBundleDisplayName` | Name beneath the icon. |
| `res/mipmap-*/ic_launcher.png` | `Assets.xcassets/AppIcon.appiconset` | Launcher icons. |
| Gradle | Xcode and native dependencies (SPM/CocoaPods depending on integration) | Build and package the host. |
| AVD in Device Manager | Device in Simulator | Virtual development phone. |

Permissions and icons are native configuration; the greeting, counter and tests stay in Dart. Plugins are the usual way to access camera, location or other APIs; check that each package supports both platforms.

# Part 3 — What's next?

You already have a counter. Now practice a small change you can observe and test. The exercises below are **proposals for you**, not features currently implemented in this repo.

## 3.1 The same change on both platforms

On a **Mac** with an Android emulator and iOS simulator running, check `flutter devices` and start all compatible targets:
```bash
flutter run -d all
```


### Practice hot reload

1. Leave only the targets you want to test connected: `-d all` may include other available devices; it does not mean Android+iOS exclusively.
2. Tap the button on each screen: each process has its own counter.
3. Change the title in `lib/main.dart` to `'¡Hola, ESCOM!'`, save and type `r` in the Flutter session.
4. Check that both titles changed and **each app** kept its own counter. Then try `R` and see the counters return to 0.

On Windows, practice the same steps on Android alone. Simultaneous iOS execution remains pending on a Mac. Another exercise: replace `Colors.deepPurple` with `Colors.teal` in **both** themes and check light/dark mode. These UI exercises need no Swift or Kotlin edits.

| Change type | Where to work |
|---|---|
| Logic and text | `lib/saludo.dart` and unit tests. |
| Screen, buttons and state | `lib/main.dart` and widget test. |
| System / platform | `lib/plataforma.dart`, plugins or native integration where necessary. |
| Android permissions and identity | `android/`. |
| iOS signing, scenes and permissions | `ios/`. |

## 3.2 Exercise: a Reiniciar button and its test

Add an **OutlinedButton** labeled **Reiniciar** (Reset) below the counter's `Text`. Tapping it should reset the counter to 0 and show **Todavía no has tocado el botón**. **Tócame** should then count again from 1.

<details>
<summary>Show proposed solution (not in the current file)</summary>

Inside `children: [...]` in `_PantallaInicioState.build()`, immediately after `Text(textoContador(_veces), ...)`, add these widgets. This is an insertion, not a replacement for the complete file:

```dart
const SizedBox(height: 8),
OutlinedButton(
  onPressed: () => setState(() => _veces = 0),
  child: const Text('Reiniciar'),
),
```

</details>

Extend the existing test after checking the three taps. Do not only check that a button exists: check the changed text and the ability to count again.

<details>
<summary>Show proposed test (only after adding the button)</summary>

```dart
await tester.tap(find.widgetWithText(OutlinedButton, 'Reiniciar'));
await tester.pump();
expect(find.text('Todavía no has tocado el botón'), findsOneWidget);

await tester.tap(find.widgetWithText(FilledButton, 'Tócame'));
await tester.pump();
expect(find.text('Has tocado el botón 1 vez'), findsOneWidget);
```

</details>

This solution and test are provided as an exercise; **they were not applied to `lib/` or `test/`**. Afterwards run `flutter analyze` and `flutter test`. If finding Reiniciar fails, check that you added the button, saved the file and inserted the snippet inside `children`.

## 3.3 Recommended next steps

| Goal | First step |
|---|---|
| A second screen | Practice `Navigator.push` / `pop` and the [navigation cookbook](https://docs.flutter.dev/cookbook/navigation). |
| Add capabilities | Search [pub.dev](https://pub.dev), check platforms, maintenance and documentation. Follow the [package guide](https://docs.flutter.dev/packages-and-plugins/using-packages). |
| Shared state | Learn local state with `setState` first; then `ChangeNotifier` and other [state management options](https://docs.flutter.dev/data-and-backend/state-mgmt/options). |
| Data surviving app closure | Choose suitable storage and test reads/writes; `_veces` is not persisted yet. |
| More confidence | Test new cases and check real Android and iOS devices when using system APIs. |

Use `flutter pub add package_name` to add a package, replacing the name with a real one. Do not install multiple state managers for this counter: begin with a small goal you can verify.

# Part 4 — Use this repo as the base for your app

You can start from this project and change it gradually. First confirm that the original copy runs on your machine; then personalize identity and content. This lets you distinguish environment issues from renaming mistakes.

## 4.1 What you need for it to run

| Target | Requirements |
|---|---|
| Android emulator | Flutter, Android Studio/SDK and a running AVD; `flutter pub get`. |
| Android phone | The above plus USB debugging and computer authorization; no emulator is needed. |
| iOS simulator | Mac, Flutter, Xcode and an iOS runtime; native dependencies only if plugins require them. |
| Physical iPhone | The above plus Apple ID, Team, unique Bundle ID, Developer Mode and certificate trust. |

Do not copy the author's SDK paths. Android Studio is not required to build **iOS alone** when Flutter and Xcode are correctly installed. JDK/Gradle belong to the Android target.

## 4.2 What to change to make it YOUR app

| What | Where | Example |
|---|---|---|
| Dart package name | `pubspec.yaml` → `name` | `my_app`, lowercase with underscores. |
| Package imports | `test/*.dart` and any `package:hola_mundo_flutter/...` | `package:my_app/main.dart`. Relative imports in `lib/` can stay the same. |
| Android identifier | `android/app/build.gradle.kts` → `applicationId` | `com.yourname.myapp`. |
| Android namespace | Same file → `namespace` | `com.yourname.myapp`. |
| Kotlin package and folder | `android/app/src/main/kotlin/com/example/hola_mundo_flutter/MainActivity.kt` | Move to `com/yourname/myapp/MainActivity.kt` and change `package com.yourname.myapp`. |
| iOS Bundle ID | Xcode → Runner → General / Signing & Capabilities | `com.yourname.myapp`; review all configurations and RunnerTests. |
| iOS signing identity | Runner → Signing & Capabilities → Team | Your Personal Team or team. |
| Android name beneath icon | `AndroidManifest.xml` → `android:label` | `My App`. |
| iOS name beneath icon | `ios/Runner/Info.plist` → `CFBundleDisplayName` | `My App`. |
| iOS internal name | `Info.plist` → `CFBundleName` | Review `hola_mundo_flutter` if personalizing it. |
| Title and text | `lib/main.dart`, `lib/saludo.dart` and tests | Your title, description, greeting and updated expectations. |
| Icons | Android resources and `Assets.xcassets/AppIcon.appiconset` | Generate with flutter_launcher_icons, below. |
| Version | `pubspec.yaml` → `version` | `1.0.0+1` and your subsequent build numbers. |

**Renaming order:** change `name`, update imports, run `flutter pub get` and check tests. Then change native identifiers. Use Refactor → Rename in Android Studio, or carefully move `MainActivity.kt` and update its `package` line.

The manifest uses `.MainActivity`: keep its class package consistent with `namespace`. Changing only the folder or namespace can cause the app to fail to find the class on launch. The Dart name, applicationId and Bundle ID are different identifiers: changing one does not automatically update the others.

## 4.3 What is best left unchanged

Keep `lib/`, `android/`, `ios/`, `main.dart`, the Gradle `:app` module and the **Runner** target/workspace names unless you have a concrete reason to change them. Renaming Runner is unnecessary to change the user-visible name. Keep the Wrapper, template options and generated plugin registration; avoid editing ephemeral and build files.

Do not change Gradle, AGP and Kotlin versions independently without checking Flutter compatibility. Android's release template still signs with the **debug** key: suitable for testing, but distribution requires your own signing setup as described in the [official Android release guide](https://docs.flutter.dev/deployment/android). This tutorial does not publish or sign a store release.

## 4.4 Icons and checking the old name

For your future app, you can use [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons). These steps **are optional and were not run here**. Add the development dependency:
```bash
flutter pub add --dev flutter_launcher_icons
```


### Generate icons and verify your copy

First create your square image in `assets/icono.png` (for example 1024×1024), then add this **proposed configuration**, which is not part of the current `pubspec.yaml`, as a root-level entry in your `pubspec.yaml`:

```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icono.png"
  remove_alpha_ios: true
```

Generate native resources:
```bash
dart run flutter_launcher_icons
```

```bash
git grep -n "hola_mundo_flutter\|holaMundoFlutter"
```


### Check after personalization

`git grep` searches files **tracked by Git**; it can still find README examples and each match needs interpretation. In a downloaded folder without `.git`, the command will not work: search with your editor or work in a repository clone. A commit is unnecessary to check your app.

After renaming or changing icons, run the checks and launch on devices. Native changes require stopping and running again, not just hot reload:
```bash
flutter analyze
```

```bash
flutter test
```

```bash
flutter build apk --debug
```


## Troubleshooting

The following messages help recognize problems; **they are not invented new outputs from this run**. Old Gradle cases concern older projects, not this repo's current template.

| Message or symptom | Cause and fix |
|---|---|
| `Error: No pubspec.yaml file found.` | You are outside the Flutter root. Enter the folder containing `pubspec.yaml` and repeat the command. |
| `Your project's Gradle version (8.12.0) is lower than Flutter's minimum supported version of 8.14.0` | Project created with older Flutter. Compare with a fresh template from the same SDK and update Gradle/AGP compatibly. Regenerating `android/` requires preserving permissions, signing, icons and customizations. This repo already uses 9.3.1. |
| `What went wrong: 25.0.3` | Older Gradle with Java 25 from Android Studio 2026. Update compatible Gradle/plugins or, for that old project, point `flutter config --jdk-dir` at an installed JDK 21. **That setting is global**; unnecessary for this repo and not applied here. |
| `Your project path contains non-ASCII characters` / `ShaderCompilerException … Could not write file` | Accented Windows path, such as `OneDrive\Imágenes`. Move or clone into an accent-free path such as `C:\dev\HolaMundoFlutter`. |
| **Restricted Mode** banner in VS Code | Folder is untrusted. If you recognize its source, choose **Manage → Trust**. |
| `Requested internal only, but not enough space` | Emulator storage is full. Use a new AVD or **Wipe Data** (erases its data). |
| `Android license status unknown` | Install missing Command-line Tools and run `flutter doctor --android-licenses`; read and accept licenses. |
| `No supported devices connected` / `No devices found` | Start an AVD or connect/authorize the phone; check `flutter devices`. |
| Tests fail after replacing main.dart | The template counter test is still active. Replace it with the actual files from 1.12; update expectations if you personalized text. |
| Data changes but text does not | This counter must change inside `setState`; call `pump()` after taps in tests. |
| Counter returns to 0 | Hot restart, closure or a new process: there is no persistence. Hot reload preserves the existing `State`. |
| `WARNING: Use --enable-native-access=ALL-UNNAMED…` during builds | JDK warning at Gradle startup; this tutorial's build completed successfully with it. Check the final outcome before treating it as failure. |
| `Xcode installation is incomplete` | On the Mac, finish first launch, Xcode selection and runtimes in 2.1. |
| `No profiles for 'com.example.holaMundoFlutter'` | Missing Team/signing or unavailable Bundle ID. Configure Automatically manage signing, your Team and a unique Bundle ID in Runner; select the connected iPhone. |
| `Untrusted Developer` | On the iPhone, trust the certificate through General → VPN & Device Management. |
| App closes when launched from its icon in debug | Launch with Flutter/editor/Xcode, or install `flutter run --release` on the physical iPhone. |
| `CocoaPods not installed` | If a native plugin requires CocoaPods, install it on the Mac using its guide, then repeat `flutter pub get` / build. It does not affect Android or mean this app without native plugins needs it. |
| `Unable to boot the Simulator` | Check that Xcode has an iOS runtime installed and a virtual device available. |
| `Developer Mode disabled` / `Unlock iPhone to Continue` | Enable Developer Mode / unlock the iPhone and run again. |
| Developer Mode is missing | Connect, unlock and trust the Mac; let Xcode start setup and check Privacy & Security again. |
| Error after pasting AppDelegate from an old tutorial | Keep plugin registration inside `didInitializeImplicitFlutterEngine` and the repo's scene configuration; review 2.2. |

When a command fails, save its complete message and identify whether it happened during Dart analysis, Gradle compilation, Xcode compilation or installation. Do not change multiple versions or erase native configuration as your first attempt.

## Versions used

Verified on **Windows 11 on 2026-10-07 and 2026-10-08** with `flutter --version`, the Android files and this tutorial's checks. The pubspec Dart constraint is distinct from the running SDK.

| Component | Version / source |
|---|---|
| Flutter | **3.47.6**, stable, revision `5fc346839b`. |
| Dart | **3.13.5**; `pubspec.yaml` retains the `^3.8.0` constraint. |
| Gradle | **9.3.1**, `android/gradle/wrapper/gradle-wrapper.properties`. |
| Android Gradle Plugin | **9.1.0**, `android/settings.gradle.kts`. |
| Kotlin (declared) | **2.4.0**, `android/settings.gradle.kts`. |
| Java / JVM target | **17**, `compileOptions` and `kotlin.compilerOptions.jvmTarget`. |
| JDK running Gradle | Android Studio's Java 25 in this environment; distinct from target 17. |
| flutter_lints | **^6.0.0**, `pubspec.yaml`. |
| cupertino_icons | **^1.0.8**, `pubspec.yaml`. |
| Android SDK | `compileSdk`, `minSdk`, `targetSdk` delegated to Flutter in the actual file; no unrelated hard-coded numbers. |
| AVD | **HolaMundo_Phone**, 1080×2400 display; screenshots reduced to 540×1200. |
| applicationId / namespace | `com.example.hola_mundo_flutter`. |
| Runner Bundle ID | `com.example.holaMundoFlutter`, `ios/Runner.xcodeproj/project.pbxproj`. |
| Declared iOS deployment target | **15.0** in the Xcode project; tested on iOS 26.5 simulator, not iOS 15. |
| App version | **1.0.0+1**, `pubspec.yaml`. |

**Android validation:** analysis without issues, **3/3 tests** and successful debug APK build; screenshots from this app's emulator. **iOS validation (Mac, 2026-10-08):** analysis without issues, 3/3 tests, debug build and launch on iPhone 17 Pro running iOS 26.5; greeting, initial counter, three taps, dark mode retaining 3 and hot restart to 0 verified. Execution from Xcode 27.0 and Xcode screenshots obtained; environment and warnings documented in 2.1. Physical iPhone and Android on this Mac remain pending. Code, dependencies, signing and the optional exercise were not changed.

## Final structure

Abbreviated project tree, omitting caches, build outputs and personal files. `docs/` contains only `capturas/`. This review's working files remain in `.codex-tmp/`, excluded by `.gitignore`.
```text
HolaMundoFlutter/
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
├── .gitignore
├── .metadata
├── lib/
│   ├── main.dart
│   ├── saludo.dart
│   └── plataforma.dart
├── test/
│   ├── saludo_test.dart
│   └── widget_test.dart
├── android/
│   ├── build.gradle.kts
│   ├── settings.gradle.kts
│   ├── gradle.properties
│   ├── gradlew / gradlew.bat
│   ├── gradle/wrapper/
│   └── app/
│       ├── build.gradle.kts
│       └── src/main/
│           ├── AndroidManifest.xml
│           ├── kotlin/com/example/hola_mundo_flutter/MainActivity.kt
│           └── res/
├── ios/
│   ├── Runner.xcworkspace/
│   ├── Runner.xcodeproj/
│   ├── Flutter/
│   ├── RunnerTests/
│   └── Runner/
│       ├── AppDelegate.swift
│       ├── SceneDelegate.swift
│       ├── Info.plist
│       ├── Assets.xcassets/
│       └── Base.lproj/
├── docs/capturas/
│   ├── android-hola-mundo.png
│   ├── android-tres-toques.png
│   ├── android-modo-oscuro.png
│   ├── ios-hola-mundo.png
│   ├── ios-tres-toques.png
│   ├── ios-modo-oscuro.png
│   ├── xcode-signing.png
│   ├── xcode-ejecutar.png
│   ├── vscode-modo-restringido.png
│   ├── iphone-privacidad.png
│   ├── iphone-modo-desarrollador.png
│   └── iphone-admon-dispositivos.png
├── README.md
└── README.es.md
```


## Pending screenshots

`ios-hola-mundo.png`, `ios-tres-toques.png`, `ios-modo-oscuro.png`, `xcode-signing.png` and `xcode-ejecutar.png` are now available. Evidence that could not be verified remains pending:

| Pending file | Remaining work |
|---|---|
| `iphone-hola-mundo.png` | Run this app on a physical iPhone and verify signing; wireless discovery does not prove execution. |
| `as-proyecto.png` (Windows) | Android Studio showing the project root and tree, without dialogs or personal data; width 1600 px. Not obtained during this iOS session. |

Android execution on this Mac and simultaneous Android+iOS execution were not verified; the prior Windows evidence is retained. macOS and Web were not tested. Before adding any new screenshot, check accounts, emails, avatars, notifications and other apps; generic settings images do not replace physical phone testing.
