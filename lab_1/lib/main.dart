import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: MyHomePage(title: '201154'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  final List<Map<String, String>> products = [
    {
      'name': 'Дуксер',
      'image': 'https://i.imgur.com/3P2KIvR.jpeg',
      'description': 'НСФВ Аниме дуксер',
      'price': '\$20',
    },
    {
      'name': 'Фаркмерки',
      'image': 'https://i.imgur.com/C7PrZfs.jpeg',
      'description': 'Директен експорт од Зара',
      'price': '\$50',
    },
    {
      'name': 'Јакна',
      'image': 'https://i.imgur.com/YL1hMLA.jpeg',
      'description': 'Јакната доаѓа 2 во 1 со Канје',
      'price': '\$60',
    },
    {
      'name': 'Патики',
      'image':
          'https://www.clownsupplies.com/cdn/shop/products/model24_grande.jpg?v=1670067106',
      'description': 'Оригинал од Биди и Бади',
      'price': '\$50',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(product: product),
                ),
              );
            },
            child: Card(
              color: Colors.blue[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product['image']!,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product['name']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});
  final Map<String, String> product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']!),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product['image']!,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              product['name']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              product['description']!,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Цена: ${product['price']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
