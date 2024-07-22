import 'package:flutter/material.dart';
import '../db/firebase_helper.dart';
import '../models/client_model.dart';
import 'client_form_screen.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ClientListScreenState createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  List<Client> _clients = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchClients();
  }

  Future<void> _fetchClients() async {
    List<Client> clients = await FirebaseHelper().getClientsByRegistrationDate(
        DateTime.now().subtract(const Duration(days: 30)));
    setState(() {
      _clients = clients;
    });
  }

  Future<void> _deleteClient(String id) async {
    await FirebaseHelper().deleteClient(id);
    _fetchClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              String cedula = _searchController.text;
              Client? client = await FirebaseHelper().getClientByCedula(cedula);
              if (client != null) {
                setState(() {
                  _clients = [client];
                });
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cliente no encontrado')));
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(labelText: 'Buscar por Cédula'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _clients.length,
              itemBuilder: (context, index) {
                Client client = _clients[index];
                return ListTile(
                  title: Text(client.name),
                  subtitle: Text('Cédula: ${client.cedula}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ClientFormScreen(client: client),
                            ),
                          ).then((_) => _fetchClients());
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await _deleteClient(client.id);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Cliente eliminado')));
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ClientFormScreen(),
            ),
          ).then((_) => _fetchClients());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
