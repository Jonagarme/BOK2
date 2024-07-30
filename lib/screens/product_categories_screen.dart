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

  final Map<String, String> productImages = {
    "Ensalada César": "assets/images/ensalada_cesar.jpg",
    "Sopa de Tomate": "assets/images/sopa_tomate.jpg",
    "Bruschetta": "assets/images/bruschetta.jpg",
    "Pizza Margherita": "assets/images/pizza.jpg",
    "Pasta Carbonara": "assets/images/pasta_carbonara.jpg",
    "Pollo Asado": "assets/images/pollo_asado.jpg",
    "Tiramisú": "assets/images/tiramisu.jpg",
    "Helado de Vainilla": "assets/images/helado_vainilla.jpg",
    "Tarta de Manzana": "assets/images/tarta_manzana.jpg",
    "Coca Cola": "assets/images/coca_cola.jpg",
    "Jugo de Naranja": "assets/images/jugo_naranja.jpg",
    "Café Espresso": "assets/images/cafe.jpg",
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
              final productName = currentProducts[index];
              final productImage = productImages[productName]!;
              return ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                leading: Image.asset(
                  productImage,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(productName),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
