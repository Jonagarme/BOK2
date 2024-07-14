import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../db/database_helper.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<FoodItem> _foodItems = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFoodItems();
  }

  void _loadFoodItems() async {
    final foodItems = await DatabaseHelper.instance.getFoodItems();
    setState(() {
      _foodItems = foodItems;
    });
  }

  void _addFoodItem() async {
    final name = _nameController.text;
    final price = double.tryParse(_priceController.text);
    if (name.isNotEmpty && price != null) {
      final foodItem = FoodItem(name: name, price: price);
      await DatabaseHelper.instance.insertFoodItem(foodItem);
      _loadFoodItems();
      _nameController.clear();
      _priceController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Food Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addFoodItem,
              child: Text('Add Food Item'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _foodItems.length,
                itemBuilder: (context, index) {
                  final foodItem = _foodItems[index];
                  return ListTile(
                    title: Text(foodItem.name),
                    subtitle: Text('Price: \$${foodItem.price}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
