Crypto_Awad - Build instructions

This archive contains a Flutter project scaffold for Crypto_Awad with:
- Arabic + English UI
- CoinGecko news
- Favorites using sqflite
- Firebase Messaging integration (requires google-services.json)

Steps:
1) Install Flutter: https://flutter.dev/docs/get-started/install
2) Unzip and open project folder
3) Put google-services.json into android/app/ if using Firebase
4) Run: flutter pub get
5) Run on device: flutter run
6) Build release APK: flutter build apk --release

See in-project code for details about localization, DB, and Firebase setup.
