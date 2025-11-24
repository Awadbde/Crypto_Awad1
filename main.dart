import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_service.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseService.init();
  runApp(const CryptoAwadApp());
}

class CryptoAwadApp extends StatefulWidget {
  const CryptoAwadApp({super.key});

  @override
  State<CryptoAwadApp> createState() => _CryptoAwadAppState();
}

class _CryptoAwadAppState extends State<CryptoAwadApp> {
  Locale _locale = ui.window.locale.languageCode.startsWith('ar') ? const Locale('ar') : const Locale('en');

  void setLocale(Locale l) => setState(() => _locale = l);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto_Awad',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      home: HomePage(onLocaleChange: setLocale),
      routes: { '/settings': (_) => SettingsPage(onLocaleChange: setLocale) },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      locale: _locale,
    );
  }
}
