import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/business_logic/cubit/character_cubit.dart';
import 'package:test_bloc/constant/color.dart';
import 'package:test_bloc/data/model/character.dart';
import 'package:test_bloc/presentations/widget/character_item.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool isSearching = false;
  final searchTextController = TextEditingController();
  Widget _buildSearchField() {
    return TextField(
        controller: searchTextController,
        cursorColor: MyColors.myGrey,
        decoration: const InputDecoration(
          hintText: 'Find a character...',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
        ),
        style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
        onChanged: (searchedCharacter) {
          addSearcheedForCharacterList(searchedCharacter);
        });
  }

  void addSearcheedForCharacterList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarAction() {
    if (isSearching) {
      return [
        IconButton(
            onPressed: () {
              _cleaeSearch();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear, color: MyColors.myGrey))
      ];
    } else {
      return [
        IconButton(
            onPressed: () {
              _startSearch;
            },
            icon: const Icon(Icons.search, color: MyColors.myGrey))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearching = false;
    });
  }

  void _stopSearching() {
    _cleaeSearch();
    setState(() {
      isSearching = false;
    });
  }

  void _cleaeSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  initState() {
    super.initState();
    BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }

  Widget buildBolcWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: MyColors.myYellow),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
        child: Container(
            color: MyColors.myGrey,
            child: Column(
              children: [
                buildCharacterList(),
              ],
            )));
  }

  Widget buildCharacterList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: searchTextController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacters.length,
        itemBuilder: (ctx, index) {
          return CharacterItem(
              character: searchTextController.text.isEmpty
                  ? allCharacters[index]
                  : allCharacters[index]);
        });
  }

  Widget _buildAppBarTitle() {
    return const Text('Character', style: TextStyle(color: MyColors.myGrey));
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: MyColors.myWhite,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Can\'t connect .. check internet',
              style: TextStyle(fontSize: 22, color: MyColors.myGrey),
            ),
            Image.asset('assets/image/')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.myYellow,
          leading: isSearching
              ? const BackButton(color: MyColors.myGrey)
              : Container(),
          title: isSearching ? _buildSearchField() : _buildAppBarTitle(),
          actions: _buildAppBarAction(),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return buildBolcWidget();
            } else {
              return buildNoInternetWidget();
            }
          },
          child: showLoadingIndicator()
        )

        // buildBolcWidget(),
        );
  }
}
