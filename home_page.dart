import 'package:flutter/material.dart';
import '../services/coingecko_service.dart';
import '../models/status_update.dart';
import 'details_page.dart';
import 'settings_page.dart';
import '../services/local_db.dart';

class HomePage extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  const HomePage({super.key, required this.onLocaleChange});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<StatusUpdate> updates = [];
  bool loading = true;
  String filterCoinId = '';

  @override
  void initState() {
    super.initState();
    LocalDB.init();
    loadUpdates();
  }

  Future<void> loadUpdates() async {
    setState(() => loading = true);
    try {
      if (filterCoinId.trim().isEmpty) {
        updates = await CoinGeckoService.getStatusUpdates();
      } else {
        updates = await CoinGeckoService.getCoinStatusUpdates(filterCoinId.trim().toLowerCase());
      }
    } catch (e) {
      updates = [];
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto_Awad'),
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, '/settings'), icon: const Icon(Icons.settings)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Filter by coin id (e.g. bitcoin)'),
                    onChanged: (v) => filterCoinId = v,
                    onSubmitted: (_) => loadUpdates(),
                  ),
                ),
                IconButton(onPressed: loadUpdates, icon: const Icon(Icons.search))
              ],
            ),
          ),
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: updates.length,
                    itemBuilder: (context, i) {
                      final u = updates[i];
                      return ListTile(
                        title: Text(u.project.isNotEmpty ? u.project : u.category),
                        subtitle: Text(u.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(u.createdAt.split('T').first),
                          IconButton(
                            icon: const Icon(Icons.star_border),
                            onPressed: () async {
                              await LocalDB.addFavorite(u);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to favorites')));
                            },
                          )
                        ]),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsPage(update: u))),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
