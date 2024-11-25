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
// por lo general van barras de navegacion
appBar: AppBar(
  leading: const Icon(Icons.menu),
title: const Text('Diagramación'),


),

        body: ListView( //lista
      
        children:[
      
const SizedBox(height:12.0),
Container(

child: Row(
children: [

Expanded(
child: Container(
height:150.0,


 color: Color.fromARGB(255, 196, 196, 196)
),
), 

const SizedBox(width:20.0),

Expanded(

child: Container(
height: 150.0,
 color:Color.fromARGB(255, 196, 196, 196)
),
),


],
)
),

const SizedBox(height:12.0),

Container(
height: 300.0,
color: Colors.transparent,
child: Row(
children: [
Expanded(

child: Container(
 

),
), 



Expanded(
child: Container(
  height:300.0,
 color: Color.fromARGB(255, 196, 196, 196)
),
),


],
)
),
const SizedBox(height:12.0),
Container(

child: Row(
children: [
  
Expanded(
child: Container(
height:150.0,
width: 100.0,

 color: Color.fromARGB(255, 196, 196, 196)
),
), 

const SizedBox(width:20.0),

Expanded(

child: Container(
height: 150.0,
 color:Color.fromARGB(255, 196, 196, 196)
),
),


],
)
),

const SizedBox(height:12.0),
Container(
                height: 100.0,
                width: double.infinity,
                color: Colors.grey,
               
              ),
        ],  
         ),
         
        ),
      );
    
  }
}
