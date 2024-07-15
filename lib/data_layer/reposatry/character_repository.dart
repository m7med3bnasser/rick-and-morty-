import '../models/Characters.dart';
import '../web_services/character_web_services.dart';

class CharacterRepository {
  final CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await characterWebServices.getAllCharacters();
    return characters.map((caracter) => Character.fromJson(caracter)).toList();
  }
}
