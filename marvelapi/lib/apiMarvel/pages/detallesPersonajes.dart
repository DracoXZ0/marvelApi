// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:marvelapi/apiMarvel/controlers/personajes.dart';

class detallesPersonajes extends StatelessWidget {
  final Character character;
  const detallesPersonajes({Key? key, required this.character})
      : super(key: key);

  Widget butt({
    required String text,
    required int value,
  }) =>
      MaterialButton(
        onPressed: () {},
        padding: const EdgeInsets.symmetric(vertical: 6),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '$value',
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              character.image,
              height: 300,
              width: 100,
              
            ),

            //Tres primeras
            Padding(
              
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Tres primeras series' , 
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  for (final seriesName in character.firstThreeSeriesNames)
                    Text(
                      seriesName,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                    ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                border: Border.all(width: 10, color: Colors.transparent),
              ),
              child: Column(
                children: [
                  Column(
                    //Mostrar numero de elementos
                    
                    children: 
                    <Widget>[
                      
                      butt(value: character.comicsCount, text: "Comics"), 
                      butt(text: "Series", value: character.seriesCount),
                      butt(
                          text: "Stories", value: character.storiesCount),
                      butt(text: "Events", value: character.eventsCount),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          border:
                              Border.all(width: 5, color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        child: const Text(

                          "Descripcion del personaje:"),
                      ),

                      // Descripcion
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(
                              width: 0, color: Color.fromARGB(0, 0, 0, 0)),
                        ),

                        
                        child: Text(
                          character.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        height: 17,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          border:
                              Border.all(width: 0, color: Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
