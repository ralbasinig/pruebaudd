import 'package:flutter/material.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Ocultar banda debug
      home: Scaffold(
        appBar: AppBar(
          title: const Text("uber"), // Título AppBar
          actions: const [
            Icon(Icons.add_box),
            Icon(Icons.favorite),
            Icon(Icons.chat),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Rectángulo
              Container(
                height: 60.0,
                width: double.infinity,
                color: Colors.grey,
                child: const Center(
                  child: Text("¿Dónde vas?"),
                ),
              ),
              const SizedBox(height: 12.0),

              // Lista de ubicaciones
              const Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      Text("UDD"),
                    ],
                  ),
                  SizedBox(height: 8.0), // Espaciado entre elementos
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      Text("CASA"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12.0),

              // Título
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Sugerencias", // Texto a mostrar
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),

              // Contenedor con filas
              Container(
                height: 80.0,
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.pink, // Primer contenedor
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Container(
                        color: Colors.pink, // Segundo contenedor
                      ),
                    ),
                     const SizedBox(width: 12.0),
                    Expanded(
                      child: Container(
                        color: Colors.pink, // Segundo contenedor
                      ),
                    ),
                     const SizedBox(width: 12.0),
                    Expanded(
                      child: Container(
                        color: Colors.pink, // Segundo contenedor
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12.0),

               
               Container(
height: 100.0, //altura
width: double.infinity, //ocupa todo el ancho disponible
color: Colors.grey, //color de fondo
child: const Text('Tamaño card'), //texto dentro del primer container
         ),

          const SizedBox(height: 12.0),
 Container(
height: 200.0, //altura
width: double.infinity, //ocupa todo el ancho disponible
color: Colors.grey, //color de fondo
child: const Text('Tamaño card'), //texto dentro del primer container
         ),
const SizedBox(height: 12.0),
          Container(
height: 200.0, //altura
width: double.infinity, //ocupa todo el ancho disponible
color: Colors.grey, //color de fondo
child: const Text('Tamaño card'), //texto dentro del primer container
         ),
              const SizedBox(height: 12.0),
            ],
            



          ),
        ),
      ),
    );
  }
}

