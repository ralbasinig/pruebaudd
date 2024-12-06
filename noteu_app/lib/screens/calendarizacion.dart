// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, use_super_parameters

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarScreen extends StatefulWidget {
  final String noteId; // ID de la nota a calendarizar
  const CalendarScreen({Key? key, required this.noteId}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _descriptionController = TextEditingController();

  // Función para guardar la calendarización en la colección "calendarizaciones"
  Future<void> _createCalendarization() async {
    try {
      await FirebaseFirestore.instance.collection('calendarizaciones').add({
        'noteId': widget.noteId, // Vincula esta calendarización con la nota correspondiente
        'fecha': _selectedDate.toIso8601String(), // Fecha seleccionada
        'descripcion': _descriptionController.text, // Descripción opcional
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Calendarización guardada exitosamente')),
      );
      Navigator.pop(context); // Regresa a la pantalla anterior
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar la calendarización: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendarizar Nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecciona una fecha para calendarizar tu nota:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Calendario
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, // Días de la semana
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day,
                itemBuilder: (context, index) {
                  final date = DateTime(DateTime.now().year, DateTime.now().month, index + 1);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectedDate.day == date.day &&
                                _selectedDate.month == date.month &&
                                _selectedDate.year == date.year
                            ? Colors.blue
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            color: _selectedDate.day == date.day &&
                                    _selectedDate.month == date.month &&
                                    _selectedDate.year == date.year
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Campo para descripción opcional
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción (opcional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Botón para guardar la fecha seleccionada
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _createCalendarization,
                child: const Text('Guardar Calendarización'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}