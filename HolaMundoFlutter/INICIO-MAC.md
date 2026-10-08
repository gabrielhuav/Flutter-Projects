# Inicio en Mac — sin VS Code ni Flutter instalados

Este material prepara la Mac del profesor para probar **HolaMundoFlutter**, antes de publicar la Práctica 1 del curso. La Tarea 1 ya entregada no se modifica. El proyecto está dentro del repositorio `gabrielhuav/Flutter-Projects`, en la carpeta `HolaMundoFlutter/`.

Antes de pasar a la Mac, el profesor debe hacer el **commit y push desde GitHub Desktop en Windows**. Mientras estos archivos no estén publicados, un clon nuevo en la Mac no incluirá esta carpeta. Codex dejó preparados los archivos locales; no hizo commit ni push.

## 1. Instalar el editor y Flutter

1. Comprueba el chip de la Mac (**Acerca de esta Mac**) y el macOS instalado. Revisa si ya hay Xcode y Git; no reinstales herramientas que ya funcionan.
2. Descarga [Visual Studio Code para macOS](https://code.visualstudio.com/download), elige Apple Silicon o Intel según el equipo y coloca la app en Aplicaciones. Se usa **VS Code**, distinto de Visual Studio.
3. Instala la extensión **Flutter**, publicada por **Dart Code**, que incorpora también soporte de Dart.
4. Instala el SDK Flutter para macOS. Para reproducir el entorno del tutorial, usa **Flutter 3.47.6 stable** desde el [archivo oficial de SDK](https://docs.flutter.dev/install/archive), seleccionando la arquitectura correcta, y descomprímelo en `~/dev/flutter`. Si esa versión no es compatible con la Mac o no está disponible, registra la situación antes de elegir otra.
5. Añade `~/dev/flutter/bin` al PATH de la shell de la Mac; conserva sus ajustes existentes y evita duplicar entradas. No basta instalar la extensión: el SDK es independiente.
6. En VS Code, selecciona ese SDK si la extensión no lo detecta. Abre una terminal nueva y comprueba:

```bash
flutter --version
```

```bash
flutter doctor -v
```

Si prefieres instalar el SDK mediante **Flutter: New Project → Download SDK → Add SDK to PATH**, sigue la [guía oficial para VS Code](https://docs.flutter.dev/install/with-vs-code). Ese flujo puede descargar una versión estable distinta: comprueba el resultado y documenta la versión antes de usarla en el curso.

Si faltan Git o las herramientas de línea de comandos de Xcode, revisa la preparación oficial. Cuando corresponda, este comando solicita instalar las Command Line Tools:

```bash
xcode-select --install
```

## 2. Preparar los destinos

| Qué quieres probar | Necesitas |
|---|---|
| Esta app en un simulador iPhone o iPhone físico | Flutter + Xcode completo, runtime iOS y firma para el teléfono físico. |
| Esta app en un emulador o teléfono Android | Flutter + Android SDK y JDK compatible. Android Studio facilita administrar SDK y AVD. |
| Android e iOS | Ambos conjuntos de herramientas. Puedes editar el Dart en VS Code. |

**iOS:** aprovecha Xcode si ya está instalado. Revisa su selección de herramientas, primera ejecución, licencias y runtime; sigue la [preparación oficial](https://docs.flutter.dev/platform-integration/ios/setup). Los comandos siguientes solo corresponden si necesitas completar esa configuración:

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

```bash
sudo xcodebuild -runFirstLaunch
```

Abre el simulador disponible en tu instalación. En Xcode 26 o anterior:

```bash
open -a Simulator
```

En Xcode 27, si la app instalada se llama Device Hub:

```bash
open -a DeviceHub
```

**Android:** usa Android Studio para instalar SDK Platform, Build-Tools, Platform-Tools, Command-line Tools y, si quieres un dispositivo virtual, Android Emulator. En una Mac con chip Apple elige una imagen **arm64-v8a**. También puedes usar un teléfono Android físico, con Depuración USB. Un teléfono reemplaza al emulador, no al SDK. Sigue la [guía oficial de Android](https://docs.flutter.dev/platform-integration/android/setup).

No necesitas Android Studio si solo vas a probar iOS. No necesitas aprender Kotlin para esta app Dart/Flutter. CocoaPods solo se instala si la integración de plugins nativos lo requiere; revisa primero qué utiliza el proyecto.

## 3. Descargar el proyecto publicado y comprobarlo

Clona el repositorio bajo `~/dev`, o reutiliza una copia existente si corresponde. No sobrescribas ni elimines una copia con cambios pendientes. Estos comandos asumen que estás en la carpeta donde quieres crear el clon:

```bash
git clone https://github.com/gabrielhuav/Flutter-Projects.git
```

```bash
cd Flutter-Projects/HolaMundoFlutter
```

Si la carpeta no existe, comprueba que el commit y push de Windows ya se hicieron y que estás usando el repositorio y la rama correctos. No inventes una app de reemplazo ni regeneres el proyecto completo para resolverlo.

Abre **esa carpeta** en VS Code mediante File → Open Folder. Si habilitaste el comando `code` para la terminal:

```bash
code .
```

Descarga dependencias, analiza y prueba:

```bash
flutter pub get
```

```bash
flutter analyze
```

```bash
flutter test
```

Comprueba dispositivos y selecciona explícitamente el destino iOS para validar esa plataforma:

```bash
flutter devices
```

```bash
flutter run
```

Si hay varios destinos, elige el ID real del simulador o del teléfono usando `flutter run -d ID_REAL`. `flutter run` es interactivo: deja la sesión activa mientras pruebas; no la confundas con un comando que siempre termina solo.

## 4. Qué debes comprobar y capturar

La app debe mostrar **¡Hola desde iOS!** en un iPhone o simulador, y **¡Hola desde Android!** en Android. Comprueba el contador inicial, tres toques y el tema oscuro conservando el contador. El hot restart debe devolverlo a cero. La app actual no incluye el botón Reiniciar del ejercicio opcional.

El proyecto genera solo anfitriones Android e iOS. **No hay carpeta `web/` ni una aplicación macOS de escritorio**; no confundas probar iOS desde una Mac con seleccionar `macos` como destino. Esta app introductoria tampoco es todavía la versión web de la futura práctica REST.

| Archivo en `docs/capturas/` | Evidencia |
|---|---|
| `ios-hola-mundo.png` | Esta app Flutter ejecutándose en el simulador iPhone. |
| `iphone-hola-mundo.png` | Esta app en un iPhone físico, si está disponible. |
| `xcode-signing.png` | Firma de Runner, ocultando cuenta, Team y otros datos personales visibles. |
| `xcode-ejecutar.png` | Xcode ejecutando Runner en el simulador. |
| `as-proyecto.png` | Captura pendiente de Android Studio, si puedes obtener una ventana limpia; ancho 1600 px. |

No copies capturas de la app KMP. Las tres imágenes genéricas de ajustes del iPhone ya incluidas no prueban ejecución Flutter. Para un iPhone físico, configura Team, Bundle ID propio, Modo de desarrollador y confianza del certificado siguiendo el tutorial. No cambies el identificador del simulador por rutina ni publiques credenciales. La ejecución `flutter run --release` corresponde al teléfono físico para probar apertura desde su ícono, no al simulador.

Cuando tengas evidencia real, actualiza ambos README con las imágenes disponibles y registra versión de Flutter, Xcode, macOS y dispositivo probado. Conserva como pendientes los destinos que no pudiste ejecutar.

## 5. Prompt para pegar en Codex en la Mac

Copia el bloque siguiente después de publicar los cambios desde Windows. El prompt autoriza preparar el entorno de esta Mac y comprobar el proyecto; no autoriza commit ni push.

```text
Vamos a preparar esta Mac para probar HolaMundoFlutter como material previo a la Práctica 1 de Administración de Proyectos de Software. No tengo instalados VS Code ni Flutter. No des por hecho que ya existe el SDK, ni que el comando flutter funciona.

El repositorio es https://github.com/gabrielhuav/Flutter-Projects.git, y el proyecto está en HolaMundoFlutter/. Los archivos ya deben estar publicados desde Windows; si esa carpeta no aparece, comprueba el estado del repositorio y explícame qué falta antes de crear archivos de reemplazo.

Primero identifica chip y macOS, y revisa Git, Xcode, sus herramientas de línea de comandos, runtimes iOS y cualquier instalación Android existente. Instala y configura VS Code para macOS, su extensión Flutter de Dart Code y el SDK Flutter adecuado a la arquitectura. Usa Flutter 3.47.6 stable para reproducir el tutorial, salvo incompatibilidad comprobada; en ese caso explícala antes de cambiar de versión. Instala el SDK en ~/dev/flutter y añade su bin al PATH conservando los ajustes existentes. Usa fuentes oficiales, sin instalaciones duplicadas ni actualizaciones generales innecesarias. Si no puedes completar una instalación automáticamente, dame el paso manual concreto y continúa con lo que puedas verificar.

Clona Flutter-Projects bajo ~/dev o reutiliza una copia existente sin sobrescribir cambios. Lee los AGENTS.md aplicables, HolaMundoFlutter/INICIO-MAC.md, README.md y README.es.md. Trabaja desde ~/dev/Flutter-Projects/HolaMundoFlutter, ajustando la ruta si reutilizas otro clon. Conserva screens_and_widgets_flutter y no modifiques ningún repo HolaMundoKMP.

Prioriza probar iOS: aprovecha Xcode existente, prepara un simulador compatible y verifica flutter doctor -v. Android Studio/SDK solo hace falta si vamos a probar también Android; no lo instales para resolver un requisito exclusivo de iOS. CocoaPods solo si la integración nativa lo requiere. No uses Docker como entorno de desarrollo de esta primera app.

Ejecuta flutter pub get, flutter analyze y flutter test. Identifica el simulador con flutter devices y ejecuta la app en ese destino iOS, sin seleccionar por error macos o web. Verifica saludo iOS, contador 0, tres toques y tema oscuro conservando el contador. No apliques el ejercicio opcional Reiniciar ni cambies el comportamiento de la app. Si una configuración nativa impide compilar, documenta el error y propón el cambio mínimo antes de modificar código de la app.

Obtén las capturas iOS y Xcode que realmente puedas producir, con los nombres de la guía, sin cuentas, correos, avatares, notificaciones ni otras apps. Actualiza las imágenes y el estado de verificación en ambos README manteniendo sus encabezados equivalentes y comprobando todos los enlaces locales. No inventes salidas ni capturas, y deja pendiente lo que no se ejecutó. Si hay iPhone físico disponible, documenta aparte su firma y prueba; no supongas que el simulador demuestra ejecución en el teléfono.

No hagas commit ni push: yo me encargo con GitHub Desktop. Al terminar informa instalaciones y versiones, rutas, resultados reales de las pruebas y compilación, capturas obtenidas, cambios realizados y pendientes. La Práctica 1 sigue en preparación; no modifiques documentos del curso ni la Tarea 1.
```

## Nota para esta copia en Windows

El repositorio local de GitHub Desktop está bajo una ruta con `Imágenes`. Para compilar Android en Windows conserva por ahora la copia verificada de `C:\Users\gabri\OneDrive\Escritorio\FlutterProjects\HolaMundoFlutter`, sin acentos. La carpeta nueva del repositorio contiene la copia preparada para publicar y clonar en Mac bajo `~/dev`; no incluye `build/`, `.dart_tool/`, `.idea/`, `local.properties` ni archivos efímeros de iOS.

Comprobaciones del 2026-10-08: en la carpeta nueva, `flutter pub get` finalizó y las **3 pruebas pasaron**. `flutter analyze` falló con `FormatException: Unexpected end of input` y salida 255 del servidor de análisis. El mismo código en la carpeta original sin acentos pasó análisis y las 3 pruebas. Se compararon los 76 archivos copiados que no son README: son idénticos a sus originales. No se cambió el código para intentar resolver el problema de la ruta. La guía y los dos README tienen sus enlaces locales verificados; iOS sigue pendiente de la Mac.
