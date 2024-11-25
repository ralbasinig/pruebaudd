import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteu_app/components/appbar.dart'; // Modular estilos
import 'package:noteu_app/components/formulario.dart';

class Mantenedor extends StatefulWidget {
  const Mantenedor({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MantenedorState createState() => _MantenedorState();
}

class _MantenedorState extends State<Mantenedor> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController; // Controlador para las tabs
  String searchQuery = ''; // Para la barra de búsqueda

  // Controladores para las tarjetas de colores
  final TextEditingController _ideasController = TextEditingController(text: 'Thing 1\nThing 2\nThing 3\nThing 4');
  final TextEditingController _doTodayController = TextEditingController(text: 'Clean\nRead\nSend mail\nidk');
  final TextEditingController _emailController = TextEditingController(text: 'juan@gmail.com');

  // Estados para la edición
  bool _isEditingIdeas = false;
  bool _isEditingDoToday = false;
  bool _isEditingEmail = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // 4 pestañas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase(); // Actualiza el query
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Notes',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),

          // Fila de días (ya existente)
          const SizedBox(height: 12.0),
          Row(
            children: [
              const SizedBox(width: 12.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Mon",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    Text(
                      "27",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "May",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0),

          // Título "All Notes"
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              "All Notes",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 8.0),

          // Tarjetas de colores editables con márgenes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaciado uniforme entre tarjetas
            children: [
              // Tarjeta 1: Ideas
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditingIdeas = true; // Activa el modo de edición
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0), // Márgenes laterales
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _isEditingIdeas
                        ? TextField(
                            controller: _ideasController,
                            maxLines: null,
                            style: const TextStyle(fontSize: 14), // Ajuste del tamaño de texto
                            onSubmitted: (_) {
                              setState(() {
                                _isEditingIdeas = false; // Finaliza la edición
                              });
                            },
                          )
                        : Text(
                            _ideasController.text,
                            style: const TextStyle(fontSize: 14), // Ajuste del tamaño de texto
                          ),
                  ),
                ),
              ),
              // Tarjeta 2: Do Today
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditingDoToday = true; // Activa el modo de edición
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0), // Márgenes laterales
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _isEditingDoToday
                        ? TextField(
                            controller: _doTodayController,
                            maxLines: null,
                            style: const TextStyle(fontSize: 14), // Ajuste del tamaño de texto
                            onSubmitted: (_) {
                              setState(() {
                                _isEditingDoToday = false; // Finaliza la edición
                              });
                            },
                          )
                        : Text(
                            _doTodayController.text,
                            style: const TextStyle(fontSize: 14), // Ajuste del tamaño de texto
                          ),
                  ),
                ),
              ),
              // Tarjeta 3: Email
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditingEmail = true; // Activa el modo de edición
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0), // Márgenes laterales
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _isEditingEmail
                        ? TextField(
                            controller: _emailController,
                            maxLines: null,
                            style: const TextStyle(fontSize: 14), // Ajuste del tamaño de texto
                            onSubmitted: (_) {
                              setState(() {
                                _isEditingEmail = false; // Finaliza la edición
                              });
                            },
                          )
                        : Text(
                            _emailController.text,
                            style: const TextStyle(fontSize: 14), // Ajuste del tamaño de texto
                          ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8.0),

          // TabBar debajo del título "All Notes"
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            indicatorWeight: 3.0,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'All Notes'),
              Tab(text: 'Recents'),
              Tab(text: 'Favorites'),
              Tab(text: 'Unfiled'),
            ],
          ),
          const SizedBox(height: 8.0),

          // TabBarView que cambia el contenido según la pestaña seleccionada
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNotesList(searchQuery), // Contenido de "All Notes"
                const Center(child: Text('Recents')), // Placeholder para "Recents"
                const Center(child: Text('Favorites')), // Placeholder para "Favorites"
                const Center(child: Text('Unfiled')), // Placeholder para "Unfiled"
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => FractionallySizedBox(
              heightFactor: 0.9,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: FormularioScreen(),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
      ),
    );
  }

  // Método para construir la lista de notas
  Widget _buildNotesList(String query) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('notas').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No hay registros disponibles.'));
        }

        final notas = snapshot.data!.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final titulo = data['titulo']?.toString().toLowerCase() ?? '';
          return titulo.contains(query); // Filtra por el query
        }).toList();

        return ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: notas.length,
          separatorBuilder: (context, index) => const Divider(
            color: Color.fromARGB(255, 143, 143, 143),
            thickness: 1,
          ),
          itemBuilder: (context, index) {
            final nota = notas[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(
                nota['titulo'] ?? 'Sin título',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
        );
      },
    );
  }
}