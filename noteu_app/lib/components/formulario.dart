// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteu_app/screens/note.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        // Guardar la nota en Firebase
        await FirebaseFirestore.instance.collection('notas').add({
          'titulo': _nombreController.text,
          'contenido': '', // Inicializa el contenido vacío
        });

        _nombreController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nota guardada exitosamente')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar la nota')),
        );
      }
    }
  }

  Future<void> _eliminarNota(String docId) async {
    try {
      // Eliminar la nota en Firestore
      await FirebaseFirestore.instance.collection('notas').doc(docId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nota eliminada exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al eliminar la nota')),
      );
    }
  }

  void _mostrarConfirmacionEliminacion(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Nota'),
          content: const Text('¿Estás seguro de que deseas eliminar esta nota?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancelar
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Cerrar el diálogo
                await _eliminarNota(docId); // Eliminar la nota
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Nota'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'Crear nueva nota',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Título de la Nota'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el título';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _submitForm(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Guardar Nota'),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Notas creadas:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('notas').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final notas = snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: notas.length,
                      itemBuilder: (context, index) {
                        final nota = notas[index];
                        final data = nota.data() as Map<String, dynamic>?;

                        final titulo = data != null && data.containsKey('titulo') ? data['titulo'] : 'Sin título';
                        final contenido = data != null && data.containsKey('contenido') ? data['contenido'] : '';

                        return Dismissible(
                          key: Key(nota.id), // Clave única para el swipe
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red, // Fondo rojo al hacer swipe
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: const Icon(
                              Icons.delete, // Icono de basura
                              color: Colors.white,
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            // Muestra confirmación antes de eliminar
                            _mostrarConfirmacionEliminacion(context, nota.id);
                            return false; // Evita eliminar automáticamente
                          },
                          child: ListTile(
                            title: Text(titulo),
                            onTap: () {
                              // Navegar a la pantalla de detalle de la nota
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetalleNotaScreen(
                                    titulo: titulo,
                                    contenido: contenido,
                                    docId: nota.id, // Pasar el ID del documento
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}