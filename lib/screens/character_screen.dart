import 'package:appvalorantfinal/models/character_mode.dart';
import 'package:flutter/material.dart';

class CharacterScreen extends StatelessWidget {
  final Character character;
  const CharacterScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //calcula el espacio del cel
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(character.displayName!),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.70,
              width: double.infinity,
              child: Hero(
                  tag: character.uuid!,
                  child: Image.network(
                    character.fullPortrait!,
                    fit: BoxFit.fitHeight,
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: size.height * 0.14,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardData("Role:", character.role!.displayName!),
                  cardData("", character.role!.displayIcon!),
                  cardData("Role:", character.role!.displayName!)
                ],
              ),
            ),
            const Text(
              'Descripcion',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: size.height * 0.14,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardData("", character.description!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardData(String text1, String text2) {
    return Expanded(
        child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(text1),
          Text(
            text2,
            style: TextStyle(overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    ));
  }
}
