import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/client_model.dart';

class FirebaseHelper {
  final CollectionReference clientsCollection =
      FirebaseFirestore.instance.collection('clients');

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
}
