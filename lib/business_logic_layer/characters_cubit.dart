import 'package:bloc/bloc.dart';
import 'package:flutter_rickandmorty/data_layer/models/Characters.dart';
import 'package:meta/meta.dart';

import '../data_layer/reposatry/character_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
  CharactersCubit(this.characterRepository) : super(CharactersInitial());

   List<Character> characters = [];
  List<Character>getAllCharacters(){

    characterRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    },);
    return characters;
  }
}
