import 'package:bok2/models/order_model.dart';
import 'package:bok2/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/client_model.dart';

class FirebaseHelper {
  final CollectionReference clientsCollection =
      FirebaseFirestore.instance.collection('clients');
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createClient(Client client) async {
    await clientsCollection.doc(client.id).set(client.toMap());
  }

  Future<void> updateClient(Client client) async {
    await clientsCollection.doc(client.id).update(client.toMap());
  }

  Future<Client?> getClientByCedula(String cedula) async {
    final querySnapshot = await clientsCollection
        .where('cedula', isEqualTo: cedula)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      return Client.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Future<void> deleteClient(String id) async {
    await clientsCollection.doc(id).delete();
  }

  Future<List<Client>> getClientsByRegistrationDate(DateTime date) async {
    final querySnapshot = await clientsCollection
        .where('registrationDate', isGreaterThanOrEqualTo: date)
        .get();
    return querySnapshot.docs
        .map(
            (doc) => Client.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Crear producto
  Future<void> createProduct(Product product) async {
    await _db.collection('products').doc(product.id).set(product.toMap());
  }

  // Actualizar producto
  Future<void> updateProduct(Product product) async {
    await _db.collection('products').doc(product.id).update(product.toMap());
  }

  // Eliminar producto
  Future<void> deleteProduct(String id) async {
    await _db.collection('products').doc(id).delete();
  }

  // Obtener productos
  Stream<QuerySnapshot> getProducts() {
    return _db.collection('products').snapshots();
  }

  // Crear pedido
  Future<void> createOrder(Orders order) async {
    await _db.collection('orders').doc(order.id).set(order.toMap());
  }

  // Actualizar pedido
  Future<void> updateOrder(Orders order) async {
    await _db.collection('orders').doc(order.id).update(order.toMap());
  }

  // Eliminar pedido
  Future<void> deleteOrder(String id) async {
    await _db.collection('orders').doc(id).delete();
  }

  // Obtener pedidos
  Stream<QuerySnapshot> getOrders() {
    return _db.collection('orders').snapshots();
  }
}
