import 'package:flutter/material.dart';
import '../model/item.dart';
import '../service/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService api = ApiService();
  late Future<List<Item>> itemList;
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  int? editingId;

  @override
  void initState() {
    super.initState();
    itemList = api.fetchItems();
  }

  void refreshItems() {
    setState(() {
      itemList = api.fetchItems();
      editingId = null;
      _nameController.clear();
      _descController.clear();
    });
  }

  void saveItem() async {
    final name = _nameController.text;
    final desc = _descController.text;

    if (name.isEmpty || desc.isEmpty) return;

    if (editingId == null) {
      await api.createItem(Item(name: name, description: desc));
    } else {
      await api.updateItem(Item(id: editingId, name: name, description: desc));
    }

    refreshItems();
  }

  void deleteItem(int id) async {
    await api.deleteItem(id);
    refreshItems();
  }

  void editItem(Item item) {
    setState(() {
      editingId = item.id;
      _nameController.text = item.name;
      _descController.text = item.description;
    });
  }

  Widget buildItemCard(Item item) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(item.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: () => editItem(item),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteItem(item.id!),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: saveItem,
                icon: Icon(editingId == null ? Icons.add : Icons.update),
                label: Text(editingId == null ? 'Add Item' : 'Update Item'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      editingId == null ? Colors.blue : Colors.orange,
                  minimumSize: const Size.fromHeight(40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'REST API CRUD',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          buildForm(),
          Expanded(
            child: FutureBuilder<List<Item>>(
              future: itemList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Failed to load items"));
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(child: Text("No items available"));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder:
                        (_, index) => buildItemCard(snapshot.data![index]),
                  );
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
