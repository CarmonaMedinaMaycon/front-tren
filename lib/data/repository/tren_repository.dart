import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tren_model.dart';

class TrenRepository {
    final String apiUrl;

    TrenRepository({required this.apiUrl});

    Future<void> createTren(TrenModel tren) async {
        final response = await http.post(
            Uri.parse('$apiUrl'),
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(tren.toJson()..remove('id')),
        );

        if (response.statusCode != 200) {
            throw Exception('Failed to create tren');
        }
    }

    Future<TrenModel> getTren(String id) async {
        final response = await http.get(
            Uri.parse('$apiUrl/tren/$id'),
            headers: <String, String>{},
        );

        if (response.statusCode == 200) {
            return TrenModel.fromJson(jsonDecode(response.body));
        } else {
            throw Exception('Failed to load tren');
        }
    }

    Future<void> updateTren(TrenModel tren) async {
        final response = await http.put(
            Uri.parse('$apiUrl/update'),
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(tren.toJson()),
        );

        if (response.statusCode != 200) {
            throw Exception('Failed to update tren');
        }
    }

    Future<void> deleteTren(String id) async {
        final response = await http.delete(
            Uri.parse('$apiUrl/tren/$id'),
            headers: <String, String>{},
        );

        if (response.statusCode != 200) {
            throw Exception('Failed to delete tren');
        }
    }

    Future<List<TrenModel>> getAllTrenes() async {
        final response = await http.get(
            Uri.parse('$apiUrl'),
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
        );

        if (response.statusCode == 200) {
            Iterable l = json.decode(response.body);
            return List<TrenModel>.from(l.map((model) => TrenModel.fromJson(model)));
        } else {
            throw Exception('Failed to load trenes');
        }
    }
}