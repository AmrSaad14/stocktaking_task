import 'package:flutter/material.dart';
import 'package:stocktaking_task/view/screens/check_inventory/screens/check_inventory.dart';
import 'package:stocktaking_task/view/screens/home_screen/widgets/home_document_item.dart';
import 'package:stocktaking_task/view/screens/new_document/screens/new_document_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeDocumentItem(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewDocumentScreen()));
                },
                title: 'New Stocktaking Document',
              ),
              const SizedBox(
                height: 20,
              ),
              HomeDocumentItem(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckInventoryScreen()));
                },
                title: 'Check Inventory',
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
