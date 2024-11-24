import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'T-Shirt',
      imageUrl: 'https://owayo-cdn.com/cdn-cgi/image/format=auto,fit=contain,width=490/newhp/img/productHome/productSeitenansicht/productservice/tshirts_classic_herren_basic_productservice/st2020_whi.png',
      description: 'Comfortable cotton T-shirt.',
      price: 15.99,
    ),
    Product(
      name: 'Jeans',
      imageUrl: 'https://found.store/cdn/shop/files/baggy-jeans-blue-lacy-found-2-1.jpg?v=1714676802',
      description: 'Stylish blue jeans.',
      price: 49.99,
    ),
    Product(
      name: 'Sneakers',
      imageUrl: 'https://martinvalen.com/29677-mv_large_default/v-harmony-high-sole-sneakers.jpg',
      description: 'Sporty sneakers.',
      price: 34.99,
    )
  ];

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('191045'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product),
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('\$${product.price}'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  Product({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
  });
}

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl),
            const SizedBox(height: 16.0),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(product.description),
            const SizedBox(height: 8.0),
            Text('Price: \$${product.price}'),
          ],
        ),
      ),
    );
  }
}
