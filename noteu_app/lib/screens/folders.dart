// ignore_for_file: unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Para convertir listas a cadenas JSON y viceversa

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});

  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {
  List<Map<String, dynamic>> _folders = []; // Lista de carpetas

  @override
  void initState() {
    super.initState();
    _loadFolders(); // Cargar carpetas guardadas al iniciar
  }

  // Cargar carpetas de SharedPreferences
  Future<void> _loadFolders() async {
    final prefs = await SharedPreferences.getInstance();
    final storedFolders = prefs.getString('folders'); // Obtener las carpetas guardadas

    if (storedFolders != null) {
      setState(() {
        _folders = List<Map<String, dynamic>>.from(
          json.decode(storedFolders),
        );
      });
    }
  }

  // Guardar carpetas en SharedPreferences
  Future<void> _saveFolders() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('folders', json.encode(_folders)); // Guardar carpetas en formato JSON
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Folders',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            ),
            onPressed: () {
              _showFolderOptions(); // Muestra las opciones para crear carpetas
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _folders.isEmpty
            ? const Center(
                child: Text('No folders available. Tap + to create one.'),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dos columnas
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.5, // Ajustar la relación de aspecto
                ),
                itemCount: _folders.length, // Número de carpetas
                itemBuilder: (context, index) {
                  final folder = _folders[index];
                  return GestureDetector(
                    onLongPress: () {
                      _showFolderActions(index); // Muestra opciones para editar o eliminar
                    },
                    child: FolderCard(
                      color: Color(folder['color']),
                      emoji: folder['emoji'],
                      name: folder['name'],
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _showFolderOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.folder_open),
              title: const Text('New Folder'),
              onTap: () {
                Navigator.pop(context);
                _createFolder(false); // Crear carpeta normal
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder_shared),
              title: const Text('New Shared Folder'),
              onTap: () {
                Navigator.pop(context);
                _createFolder(true); // Crear carpeta compartida
              },
            ),
          ],
        );
      },
    );
  }

  void _createFolder(bool isShared) {
    final colorOptions = [
      Colors.orange.shade100,
      Colors.blue.shade200,
      Colors.purple.shade200,
      Colors.green.shade200,
      Colors.blue.shade300,
    ];
    final emojiOptions = ["💻", "📚", "🐶", "🎯", "🥑"];

    setState(() {
      _folders.add({
        'color': colorOptions[_folders.length % colorOptions.length].value,
        'emoji': isShared ? "🤝" : emojiOptions[_folders.length % emojiOptions.length],
        'name': isShared ? "Shared Folder" : "New Folder",
      });
    });

    _saveFolders(); // Guardar carpetas después de crearlas
  }

  void _showFolderActions(int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Folder'),
              onTap: () {
                Navigator.pop(context);
                _editFolder(index); // Editar carpeta
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete Folder'),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(index); // Confirmación de eliminación
              },
            ),
          ],
        );
      },
    );
  }

  void _editFolder(int index) {
    final folder = _folders[index];
    final TextEditingController nameController =
        TextEditingController(text: folder['name']);
    String selectedEmoji = folder['emoji'];
    Color selectedColor = Color(folder['color']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Folder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Folder Name'),
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                value: selectedEmoji,
                items: ["💻", "📚", "🐶", "🎯", "🥑", "🤝"].map((emoji) {
                  return DropdownMenuItem(
                    value: emoji,
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedEmoji = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...[Colors.orange.shade100, Colors.blue.shade200, Colors.purple.shade200, Colors.green.shade200, Colors.blue.shade300]
                      .map((color) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: color,
                        radius: 16,
                        child: selectedColor == color
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _folders[index] = {
                    'name': nameController.text,
                    'emoji': selectedEmoji,
                    'color': selectedColor.value,
                  };
                });
                _saveFolders(); // Guardar cambios
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Folder'),
          content: const Text('Are you sure you want to delete this folder?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _folders.removeAt(index); // Elimina la carpeta
                });
                _saveFolders(); // Guardar carpetas después de eliminar
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

class FolderCard extends StatelessWidget {
  final Color color;
  final String emoji;
  final String name;

  const FolderCard({
    super.key,
    required this.color,
    required this.emoji,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              child: Center(
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}