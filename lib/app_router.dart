import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/business_logic/cubit/character_cubit.dart';
import 'package:test_bloc/constant/string.dart';
import 'package:test_bloc/data/model/character.dart';
import 'package:test_bloc/data/repository/character_repository.dart';
import 'package:test_bloc/data/web_server/character_web_server.dart';
import 'package:test_bloc/presentations/secreen/character_screen.dart';
import 'package:test_bloc/presentations/secreen/character_details_screen.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharacterCubit characterCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterWebServer());
    characterCubit = CharacterCubit(characterRepository);
  }

  // ignore: body_might_complete_normally_nullable
  Route? gererateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => characterCubit,
                  child: CharacterScreen(),
                ));

      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharacterCubit(characterRepository),
                  child: CharacterDetailsScreen(character:character),
          ),
        );
    }
  }
}
