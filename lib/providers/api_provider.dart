import 'package:appvalorantfinal/models/character_mode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiProvider with ChangeNotifier {
  final url = 'valorant-api.com';
  List<Character> characters = [];

  Future<void> getCharacter(int page) async {
    final result = await http.get(Uri.https(url, 'v1/agents', {
      'page': page.toString(),
    }));
    final response = characterResponseFromJson(result.body);
    characters.addAll(response.data!);
    notifyListeners();
  }

//para el buscador
  Future<List<Character>> getCharacters(String displayName) async {
    final result = await http
        .get(Uri.https(url, 'v1/agents/', {'displayName': displayName}));
    final response = characterResponseFromJson(result.body);
    return response.data!;
  }
}
