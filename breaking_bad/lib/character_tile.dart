import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models.dart';
import 'dart:convert';
import 'dart:async';


class CharacterTile extends StatelessWidget {
  final Character character;
  const CharacterTile({
    Key? key,
    required this.character,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15, ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(character.imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(alignment: Alignment.bottomLeft, child: Text(character.name, style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ));
  }
}