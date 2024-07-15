import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rickandmorty/business_logic_layer/characters_cubit.dart';
import 'package:flutter_rickandmorty/data_layer/reposatry/character_repository.dart';
import 'package:flutter_rickandmorty/data_layer/web_services/character_web_services.dart';
import 'package:flutter_rickandmorty/presentation_layer/screens/characterDetailsScreen.dart';
import 'package:flutter_rickandmorty/presentation_layer/screens/characters_screen.dart';

import 'constants/String.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterWebServices());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case charactersDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => CharactersDetailsScreen(),
        );
    }
  }
}
