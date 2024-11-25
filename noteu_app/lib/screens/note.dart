import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetalleNotaScreen extends StatefulWidget {
  final String titulo;
  final String contenido;
  final String docId;

  const DetalleNotaScreen({
    super.key,
    required this.titulo,
    required this.contenido,
    required this.docId,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DetalleNotaScreenState createState() => _DetalleNotaScreenState();
}

class _DetalleNotaScreenState extends State<DetalleNotaScreen> {
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.contenido);
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _guardarCambios() async {
    try {
      // Actualizar el contenido en Firestore
      await FirebaseFirestore.instance.collection('notas').doc(widget.docId).update({
        'contenido': _contentController.text,
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nota guardada exitosamente')),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al guardar la nota')),
      );
    }
  }

  void _terminarNota() async {
    await _guardarCambios(); // Guarda los cambios
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(); // Regresar a la pantalla anterior
          },
        ),
      
        actions: [
  IconButton(
            icon: const Icon(Icons.calendar_month, color: Colors.black),
            onPressed: _guardarCambios, // Guarda los cambios
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: _guardarCambios, // Guarda los cambios
          ),
         
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.titulo,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null, // Permite múltiples líneas
                keyboardType: TextInputType.multiline, // Habilita escritura multilineal
                decoration: const InputDecoration(
                  hintText: 'Escribe el contenido de la nota aquí...',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 16), // Ajusta el tamaño del texto
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _terminarNota, // Guarda los cambios
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Terminar Nota',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}