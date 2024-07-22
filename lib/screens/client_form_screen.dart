import 'package:bok2/screens/client_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../db/firebase_helper.dart';
import '../models/client_model.dart';

class ClientFormScreen extends StatefulWidget {
  final Client? client;

  const ClientFormScreen({super.key, this.client});

  @override
  // ignore: library_private_types_in_public_api
  _ClientFormScreenState createState() => _ClientFormScreenState();
}

class _ClientFormScreenState extends State<ClientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _cedula;

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      _name = widget.client!.name;
      _cedula = widget.client!.cedula;
    } else {
      _name = '';
      _cedula = '';
    }
  }

  Future<void> _saveClient() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Client client = Client(
        id: widget.client?.id ??
            FirebaseFirestore.instance.collection('clients').doc().id,
        name: _name,
        cedula: _cedula,
        registrationDate: DateTime.now(),
      );
      if (widget.client == null) {
        await FirebaseHelper().createClient(client);
      } else {
        await FirebaseHelper().updateClient(client);
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.client == null ? 'Crear Cliente' : 'Actualizar Cliente'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ClientListScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _cedula,
                decoration: const InputDecoration(labelText: 'Cédula'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la cédula';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cedula = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveClient,
                child: Text(widget.client == null ? 'Crear' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
