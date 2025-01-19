import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_bloc/data/model/character.dart';
import 'package:test_bloc/data/model/quote.dart';
import 'package:test_bloc/data/repository/character_repository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository characterRepository;
  List<Character> characters = [];

  CharacterCubit(this.characterRepository) : super(CharacterInitial());
  List<Character> getAllCharacters() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharacterLoaded(characters: characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuote(String charName) {
    characterRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuoteLoaded(quotes));
    });
  }
}
