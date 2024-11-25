import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteu_app/screens/note.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override

  // ignore: library_private_types_in_public_api
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

                        // Validar si los datos son null o no contienen los campos "titulo" y "contenido"
                        final titulo = data != null && data.containsKey('titulo') ? data['titulo'] : 'Sin título';
                        final contenido = data != null && data.containsKey('contenido') ? data['contenido'] : '';

                        return ListTile(
                          title: Text(titulo),
                          onTap: () {
                            // Navegar a la pantalla de detalle de la nota
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetalleNotaScreen(
                                  titulo: titulo,
                                  contenido: contenido,
                                  docId: nota.id, // Pasar el ID del documento para actualizar
                                ),
                              ),
                            );
                          },
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