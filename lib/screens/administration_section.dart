import 'package:bok2/screens/order_list_screen.dart';
import 'package:bok2/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'client_list_screen.dart';

class AdminSectionScreen extends StatelessWidget {
  const AdminSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sección de administración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildAdminOption(
              context,
              icon: Icons.people,
              label: 'Gestionar Clientes',
              destination: const ClientListScreen(),
            ),
            _buildAdminOption(
              context,
              icon: Icons.inventory,
              label: 'Gestionar Productos',
              destination: const ProductListScreen(),
            ),
            _buildAdminOption(
              context,
              icon: Icons.receipt,
              label: 'Gestionar Pedidos',
              destination: const OrderListScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminOption(BuildContext context,
      {required IconData icon,
      required String label,
      required Widget destination}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Theme.of(context).primaryColor),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
