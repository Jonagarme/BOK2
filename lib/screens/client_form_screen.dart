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
  late String _phoneNumber;
  late String _address;
  late String _city;
  late String _email;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      _name = widget.client!.name;
      _cedula = widget.client!.cedula;
      _phoneNumber = widget.client!.phoneNumber;
      _address = widget.client!.address;
      _city = widget.client!.city;
      _email = widget.client!.email;
      _isActive = widget.client!.isActive;
    } else {
      _name = '';
      _cedula = '';
      _phoneNumber = '';
      _address = '';
      _city = '';
      _email = '';
      _isActive = false;
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
        phoneNumber: _phoneNumber,
        address: _address,
        city: _city,
        email: _email,
        isActive: _isActive,
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
            widget.client == null ? 'Creacion Cliente' : 'Actualizar Cliente'),
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
          child: ListView(
            children: [
              const CircleAvatar(
                radius: 30,
                child: Icon(Icons.person, size: 40),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Nombres'),
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
                initialValue: _phoneNumber,
                decoration: const InputDecoration(labelText: 'Numero teléfono'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de teléfono';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value!;
                },
              ),
              TextFormField(
                initialValue: _address,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la dirección';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              TextFormField(
                initialValue: _city,
                decoration: const InputDecoration(labelText: 'Ciudad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la ciudad';
                  }
                  return null;
                },
                onSaved: (value) {
                  _city = value!;
                },
              ),
              TextFormField(
                initialValue: _cedula,
                decoration: const InputDecoration(labelText: 'Cedula'),
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
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              CheckboxListTile(
                title: const Text('Usuario Activo'),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveClient,
                child: Text(widget.client == null ? 'Guardar' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
