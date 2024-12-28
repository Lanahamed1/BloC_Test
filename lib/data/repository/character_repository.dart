import 'package:test_bloc/data/model/character.dart';
import 'package:test_bloc/data/web_server/character_web_server.dart';

class CharacterRepository{  
    late CharacterWebServer characterWebServer;



    CharacterRepository(this.characterWebServer);
    Future<List<dynamic>> getAllCharacters() async {
      final characters =await characterWebServer.getAllCharacters();
      return characters.map((character)=>Character.fromJson(character)).toList();
    }


}