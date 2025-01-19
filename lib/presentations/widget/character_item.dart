import 'package:flutter/material.dart';
import 'package:test_bloc/constant/color.dart';
import 'package:test_bloc/constant/string.dart';
import 'package:test_bloc/data/model/character.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        padding: const EdgeInsetsDirectional.all(4),
        decoration: BoxDecoration(
            color: MyColors.myWhite, borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, characterDetailsScreen,
              arguments: character),
          child: GridTile(
              // ignore: sort_child_properties_last
              child:Hero(
                tag:character.charId, 
                child: Container(
                    color: MyColors.myGrey,
                    child: character.image.isNotEmpty
                        ? FadeInImage.assetNetwork(
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: 'assets/images/loading',
                            image: character.image,
                            fit: BoxFit.cover)
                        : Image.asset('assets/images/loading')),
              ),
              footer: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  color: Colors.black54,
                  child: Text(
                    '${character.name}',
                    style: const TextStyle(
                        height: 1.3,
                        fontSize: 16,
                        color: MyColors.myWhite,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ))),
        ));
  }
}
