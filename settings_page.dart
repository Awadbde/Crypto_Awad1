import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final Function(Locale) onLocaleChange;
  const SettingsPage({super.key, required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(children: [
        ListTile(
          title: const Text('Language'),
          subtitle: const Text('Switch between Arabic and English'),
          trailing: DropdownButton<String>(
            value: Localizations.localeOf(context).languageCode,
            items: const [DropdownMenuItem(value: 'en', child: Text('English')), DropdownMenuItem(value: 'ar', child: Text('العربية'))],
            onChanged: (v) { if (v != null) onLocaleChange(Locale(v)); },
          ),
        )
      ]),
    );
  }
}
