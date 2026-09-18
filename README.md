# Fitness Tracker

Flutter mobile app for tracking daily steps and water intake.
LnT Mid Project - Mobile Application Development.

## Try it

- **Android APK:** [Download fitness_tracker.apk](https://github.com/MichLoverz/LnT_Mid-Project-Flutter/releases/latest/download/fitness_tracker.apk)
  (built automatically from `main`; allow "install from unknown sources" when prompted)
- **Web demo:** deployed on Vercel - the app is shown inside a phone frame on desktop browsers.

## Run locally

```sh
flutter pub get
flutter run
```

## Build

```sh
flutter build apk --release   # build/app/outputs/flutter-apk/app-release.apk
flutter build web --release   # build/web
```

## Deployment

- **Vercel:** [vercel.json](vercel.json) installs the Flutter SDK during the install step
  and runs `flutter build web`; the output directory is `build/web`.
- **APK:** [release-apk.yml](.github/workflows/release-apk.yml) builds a release APK on
  every push to `main` and uploads it to the `latest` GitHub Release.
