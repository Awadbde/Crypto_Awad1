import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/status_update.dart';

class CoinGeckoService {
  static const String base = 'https://api.coingecko.com/api/v3';

  static Future<List<StatusUpdate>> getStatusUpdates({int page = 1, int perPage = 20}) async {
    final url = Uri.parse('\$base/status_updates?per_page=\$perPage&page=\$page');
    final resp = await http.get(url);
    if (resp.statusCode != 200) throw Exception('Failed to load status updates');
    final Map<String, dynamic> data = jsonDecode(resp.body);
    final List<dynamic> list = data['status_updates'] ?? [];
    return list.map((e) => StatusUpdate.fromJson(e)).toList();
  }

  static Future<List<StatusUpdate>> getCoinStatusUpdates(String coinId, {int page = 1, int perPage = 20}) async {
    final url = Uri.parse('\$base/coins/\$coinId/status_updates?per_page=\$perPage&page=\$page');
    final resp = await http.get(url);
    if (resp.statusCode != 200) throw Exception('Failed to load coin status updates');
    final Map<String, dynamic> data = jsonDecode(resp.body);
    final List<dynamic> list = data['status_updates'] ?? [];
    return list.map((e) => StatusUpdate.fromJson(e)).toList();
  }
}
