part of 'character_cubit.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> characters;

  CharacterLoaded({required this.characters});
}

class QuoteLoaded extends CharacterState {
  final List<Quote> quotes;

  QuoteLoaded(this.quotes);
}
