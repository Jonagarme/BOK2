import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importa la pantalla de login
import 'product_categories_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: [
            _buildOption(context, Icons.fastfood, 'Food Menu'),
            _buildOption(context, Icons.shopping_cart, 'Orders'),
            _buildOption(context, Icons.payment, 'Payments'),
            _buildOption(context, Icons.local_offer, 'Offers'),
            _buildOption(context, Icons.people, 'Customers'),
            _buildOption(context, Icons.settings, 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, IconData icon, String label) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: InkWell(
        onTap: () {
          if (label == 'Food Menu') {
            // Navega a la nueva pantalla cuando se presione "Food Menu"
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductCategoriesScreen(),
              ),
            );
          } else {
            // Acción al presionar otros ítems
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.blue,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
