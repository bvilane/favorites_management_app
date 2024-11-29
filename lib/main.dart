import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/favorites.dart';
import 'screens/favorites_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Favorites(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorites App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  final List<String> products = const [
    'iPhone 13',
    'MacBook Pro',
    'AirPods Pro',
    'iPad Air',
    'Apple Watch',
    'iMac',
    'Mac Mini',
    'Apple TV',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(products[index]),
              trailing: Consumer<Favorites>(
                builder: (context, favorites, child) {
                  return IconButton(
                    icon: Icon(
                      favorites.items.contains(products[index])
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    onPressed: () {
                      if (favorites.items.contains(products[index])) {
                        favorites.removeItem(products[index]);
                      } else {
                        favorites.addItem(products[index]);
                      }
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FavoritesScreen()),
          );
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }
}