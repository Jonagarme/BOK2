import 'package:bok2/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../db/firebase_helper.dart';

class OrderFormScreen extends StatefulWidget {
  final Orders? order;

  const OrderFormScreen({super.key, this.order});

  @override
  _OrderFormScreenState createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _customerName;
  late String _product;
  late int _quantity;
  late double _totalPrice;
  late String _status;

  final List<String> _statuses = [
    "Pendiente",
    "En Proceso",
    "Completado",
    "Cancelado",
  ];

  @override
  void initState() {
    super.initState();
    if (widget.order != null) {
      _customerName = widget.order!.customerName;
      _product = widget.order!.product;
      _quantity = widget.order!.quantity;
      _totalPrice = widget.order!.totalPrice;
      _status = widget.order!.status;
    } else {
      _customerName = '';
      _product = '';
      _quantity = 1;
      _totalPrice = 0.0;
      _status = _statuses.first;
    }
  }

  Future<void> _saveOrder() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Order order = Orders(
        id: widget.order?.id ??
            FirebaseFirestore.instance.collection('orders').doc().id,
        customerName: _customerName,
        product: _product,
        quantity: _quantity,
        totalPrice: _totalPrice,
        status: _status,
      ) as Order;
      if (widget.order == null) {
        await FirebaseHelper().createOrder(order as Orders);
      } else {
        await FirebaseHelper().updateOrder(order as Orders);
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.order == null ? 'Crear Pedido' : 'Actualizar Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _customerName,
                  decoration:
                      const InputDecoration(labelText: 'Nombre del Cliente'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del cliente';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _customerName = value!;
                  },
                ),
                TextFormField(
                  initialValue: _product,
                  decoration: const InputDecoration(labelText: 'Producto'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el producto';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _product = value!;
                  },
                ),
                TextFormField(
                  initialValue: _quantity.toString(),
                  decoration: const InputDecoration(labelText: 'Cantidad'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la cantidad';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _quantity = int.parse(value!);
                  },
                ),
                TextFormField(
                  initialValue: _totalPrice.toString(),
                  decoration: const InputDecoration(labelText: 'Precio Total'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el precio total';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _totalPrice = double.parse(value!);
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: const InputDecoration(labelText: 'Estado'),
                  items: _statuses.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveOrder,
                  child: Text(widget.order == null ? 'Guardar' : 'Actualizar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
