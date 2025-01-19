import 'package:dio/dio.dart';
import 'package:test_bloc/constant/string.dart';

class CharacterWebServer {
  late Dio dio;

  CharacterWebServer() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 30),
    );

    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      return response.data;
    } catch (e) {
      // ignore: avoid_print
      print((e.toString()));
      return [];
    }
  }
  Future<List<dynamic>> getCharacterQuotes(String charName) async {
    try {
      Response response = await dio.get('quote',queryParameters: {'auther' :charName});
      return response.data;
    } catch (e) {
      // ignore: avoid_print
      print((e.toString()));
      return [];
    }
  }
}
