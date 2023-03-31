import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marvelapi/apiMarvel/pages/detallesPersonajes.dart';
import 'package:marvelapi/apiMarvel/widget/character_tile.dart';

import '../controlers/personajes.dart';

class listaPersonajes extends StatefulWidget {
  @override
  estadoListaPersonajes createState() => estadoListaPersonajes();
}

class estadoListaPersonajes extends State<listaPersonajes> {
  List<dynamic> characters = [];

  Future<void> getCharacters() async {
    final ts = '07';
    final apiKey = 'a752a4dfe2b6df0ff585bf8af2db7415';
    final hash = '944b28b6e085073b3373f7fc4eab1d16';

    final url =
        'https://gateway.marvel.com:443/v1/public/characters?ts=$ts&apikey=$apiKey&hash=$hash';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        characters = jsonData['data']['results'];
      });
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  void initState() {
    super.initState();
    getCharacters();
  }

  void _showCharacterDetail(int index) {
    final character = characters[index];
    final name = character['name'];
    final thumbnail = character['thumbnail']['path'] +
        '.' +
        character['thumbnail']['extension'];
    final description = character['description'];
    // Validación para cuando description sea nulo o esté vacío
    final defaultDescription = 'Este personaje no tiene descripción.';
    final validDescription = (description == null || description.isEmpty)
        ? defaultDescription
        : description;
    final comics = character['comics']['available'];
    final series = character['series']['available'];
    final stories = character['stories']['available'];
    final events = character['events']['available'];
    final List<dynamic> seriesList = character['series']['items'];
    final seriesCount = min(seriesList.length, 3); // Validación para seriesList
    final List<String> seriesNames = seriesList
        .sublist(0, seriesCount)
        .map((item) => item['name'].toString())
        .toList();
    final Character selectedCharacter = Character(
        name: name,
        image: thumbnail,
        thumbnail: thumbnail,
        description: validDescription,
        comicsCount: comics,
        seriesCount: series,
        storiesCount: stories,
        eventsCount: events,
        firstThreeSeriesNames: seriesNames);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => detallesPersonajes(
                character: selectedCharacter,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: characters.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final character = characters[index];
                  final thumbnail = character['thumbnail']['path'] +
                      '.' +
                      character['thumbnail']['extension'];
                  final name = character['name'];
                  return GestureDetector(
                    onTap: () {
                      _showCharacterDetail(index);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(thumbnail),
                      ),
                      title: Text(name),
                      onTap: () {
                        _showCharacterDetail(index);
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
