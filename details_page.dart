import 'package:flutter/material.dart';
import '../models/status_update.dart';
import '../services/local_db.dart';

class DetailsPage extends StatelessWidget {
  final StatusUpdate update;
  const DetailsPage({super.key, required this.update});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(update.project, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(update.createdAt),
          const SizedBox(height: 12),
          Expanded(child: SingleChildScrollView(child: Text(update.description))),
          ElevatedButton(
            onPressed: () async {
              await LocalDB.addFavorite(update);
            },
            child: const Text('Add to favorites'))
        ]),
      ),
    );
  }
}
