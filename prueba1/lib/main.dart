import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Espacios'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Primer Card
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 200, // Altura del contenedor dentro de la Card
                    color: const Color.fromARGB(255, 197, 197, 197), // Color sólido en lugar de imagen
                    width: double.infinity, // Ancho completo
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      'Título de la Card 1',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción cuando se presiona el botón
                      },
                      child: const Text('Ver más'),
                    ),
                  ),
                ],
              ),
            ),
            // Segundo Card con dos filas de Cards
            Row(

              
              children: [
                
                Expanded(
                  child: Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.only(right: 8.0, bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 150, // Altura del contenedor dentro de la Card
                          color: const Color.fromARGB(255, 197, 197, 197), // Color sólido en lugar de imagen
                          width: double.infinity, // Ancho completo dentro del Expanded
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: const Text(
                            'Título de la Card 5',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Acción cuando se presiona el botón
                            },
                            child: const Text('Ver más'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.only(left: 8.0, bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 150, // Altura del contenedor dentro de la Card
                          color: const Color.fromARGB(255, 197, 197, 197), // Color sólido en lugar de imagen
                          width: double.infinity, // Ancho completo dentro del Expanded
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: const Text(
                            'Título de la Card 6',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Acción cuando se presiona el botón
                            },
                            child: const Text('Ver más'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],

          
        ),

        
      ),
    );
  }
}