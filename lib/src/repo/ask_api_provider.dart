import 'dart:convert';
import 'package:ask/src/core/constants.dart';
import 'package:ask/src/models/item_model.dart';
import 'package:ask/src/repo/sources.dart';
import 'package:http/http.dart';


class AskApiProvider implements Source{
  Client client = Client();
  /// 1. fetch top ids
  @override
  Future<List<int>> fetchTopIds () async{
    try {
      final response = await client.get(
          Uri.parse("$BASE_URL/askstories.json"));
      final body = jsonDecode(response.body);
      return body.cast<int>();
    }catch(e){
      print("Fetch id error $e");
      throw e;
    }}

  /// 2. fetch item with the given id
  @override
  Future<ItemModel?> fetchItem(int id) async{
    final response = await client
        .get(Uri.parse("$BASE_URL/item/$id.json"));
    final body = jsonDecode(response.body);
    print("Data from repo is $body");

    final item = ItemModel.fromJson(body);
    return item;
  }
}