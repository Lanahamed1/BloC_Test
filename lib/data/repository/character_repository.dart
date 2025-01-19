import 'package:test_bloc/data/model/character.dart';
import 'package:test_bloc/data/model/quote.dart';
import 'package:test_bloc/data/web_server/character_web_server.dart';

class CharacterRepository{  
    late CharacterWebServer characterWebServer;



    CharacterRepository(this.characterWebServer);
    Future<List<Character>> getAllCharacters() async {
      final characters =await characterWebServer.getAllCharacters();
      return characters.map((character)=>Character.fromJson(character)).toList();
     }


      Future<List<Quote>> getCharacterQuotes(String charName) async {
      final quotes =await characterWebServer.getCharacterQuotes(charName);
      return quotes.map((charQuotes)=>Quote.fromJson(charQuotes)).toList();
     }


}