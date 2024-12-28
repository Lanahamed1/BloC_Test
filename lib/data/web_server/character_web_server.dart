import 'package:dio/dio.dart';
import 'package:test_bloc/constant/string.dart';

class CharacterWebServer {
  late Dio dio;

  CharacterWebServer() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 30),
    );

    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print((e.toString()));
      return [];
    }
  }
}
