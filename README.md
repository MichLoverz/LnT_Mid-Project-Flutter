# Fitness Tracker

Flutter mobile app for tracking daily steps and water intake.
LnT Mid Project - Mobile Application Development.

## Try it

**Web demo:** deployed on Vercel - the app is shown inside a phone frame on desktop browsers.

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

[vercel.json](vercel.json) installs the Flutter SDK during the install step and runs
`flutter build web`; the output directory is `build/web`.
