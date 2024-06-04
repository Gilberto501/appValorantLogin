import 'package:appvalorantfinal/models/character_mode.dart';
import 'package:appvalorantfinal/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchCharacter extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    //las acciones que van a estar a la derecha de la barra
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //lo que este en la izquierda
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final characterProvider = Provider.of<ApiProvider>(context);

    Widget circleLoading() {
      return const Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/images/RcwxNh.gif'),
        ),
      );
    }

    if (query.isEmpty) {
      return circleLoading();
    }
    return FutureBuilder(
      future: characterProvider.getCharacters(query),
      builder: (context, AsyncSnapshot<List<Character>> snapshot) {
        if (!snapshot.hasData) {
          return circleLoading();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final character = snapshot.data![index];
            return ListTile(
              onTap: () {
                context.go("/character", extra: character);
              },
              title: Text(character.displayName!),
              leading: Hero(
                  tag: character.uuid!,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(character.killfeedPortrait!),
                  )),
            );
          },
        );
      },
    );
  }
}
