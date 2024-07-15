import 'package:flutter/material.dart';

class ProductCategoriesScreen extends StatefulWidget {
  const ProductCategoriesScreen({super.key});

  @override
  _ProductCategoriesScreenState createState() =>
      _ProductCategoriesScreenState();
}

class _ProductCategoriesScreenState extends State<ProductCategoriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> categories = [
    "Entradas",
    "Platos Principales",
    "Postres",
    "Bebidas"
  ];
  final Map<String, List<String>> products = {
    "Entradas": ["Ensalada César", "Sopa de Tomate", "Bruschetta"],
    "Platos Principales": [
      "Pizza Margherita",
      "Pasta Carbonara",
      "Pollo Asado"
    ],
    "Postres": ["Tiramisú", "Helado de Vainilla", "Tarta de Manzana"],
    "Bebidas": ["Coca Cola", "Jugo de Naranja", "Café Espresso"]
  };
  List<String> currentProducts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    currentProducts = products[categories[0]]!;
    _tabController.addListener(() {
      setState(() {
        currentProducts = products[categories[_tabController.index]]!;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Menu'),
        bottom: TabBar(
          controller: _tabController,
          tabs: categories.map((category) => Tab(text: category)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categories.map((category) {
          return ListView.builder(
            itemCount: currentProducts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(currentProducts[index]),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
