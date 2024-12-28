import 'package:flutter/material.dart';
import 'package:test_bloc/constant/string.dart';
import 'package:test_bloc/presentations/secreen/character_screen.dart';
import 'package:test_bloc/presentations/secreen/character_details.dart';


class AppRouter {
  Route? gererateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(builder: (_) => CharacterScreen());



      case characterDetailsScreen:
        return MaterialPageRoute(builder: (_) => CharacterDetailsScreen());
    }
  }
}
