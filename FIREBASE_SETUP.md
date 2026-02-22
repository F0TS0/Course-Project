# Firebase Setup

To enable cloud-synced translation history, configure Firebase:

1. Install Firebase CLI and FlutterFire CLI:
   ```bash
   npm install -g firebase-tools
   firebase login
   dart pub global activate flutterfire_cli
   ```

2. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).

3. Enable Firestore Database in your Firebase project (Build > Firestore Database > Create database).

4. Run configuration from the project root:
   ```bash
   dart run flutterfire configure
   ```

   This will replace `lib/firebase_options.dart` with your project's configuration.

5. Without configuration, the app runs in offline mode (history stored locally only).
