import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/business_logic/cubit/character_cubit.dart';
import 'package:test_bloc/constant/color.dart';
import 'package:test_bloc/data/model/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({super.key, required this.character});
  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 680,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickName,
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.image,
          child: Image.network(character.image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          TextSpan(
            text: title,
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharacterState state) {
    if (state is QuoteLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator(state);
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.lenght != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.lenght - 1);

      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(repeatForever: true, animatedText: [
            FlickAnimatedText(quotes[randomQuoteIndex].quotes)
          ]),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator(state) {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getQuote(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('job', character.jobs.join('/')),
                      buildDivider(312),
                      characterInfo(
                          'Appeard In', character.categoryForTwoSerson),
                      buildDivider(250),
                      characterInfo(
                          'Season', character.appearanceOfSeason.join('/')),
                      buildDivider(280),
                      characterInfo('Status', character.statusOfDeadOrAlive),
                      buildDivider(300),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo('Batter call saul season',
                              character.betterCallSaulAppearance.join('/')),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : buildDivider(180),
                      characterInfo('Actor,Actress', character.actorName),
                      buildDivider(280),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharacterCubit, CharacterState>(
                        builder: (context, state) {
                          return CheckIfQuotesAreLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
