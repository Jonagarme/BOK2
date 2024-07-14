import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  final CollectionReference _foodCollection =
      FirebaseFirestore.instance.collection('food_items');

  Future<List<FoodItem>> getFoodItems() async {
    final querySnapshot = await _foodCollection.get();
    return querySnapshot.docs
        .map((doc) => FoodItem.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<void> insertFoodItem(FoodItem foodItem) async {
    await _foodCollection.add(foodItem.toMap());
  }
}
