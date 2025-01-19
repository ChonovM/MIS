import 'package:flutter/material.dart';

class FavoriteJokesScreen extends StatelessWidget {
  final List<String> favoriteJokes;

  const FavoriteJokesScreen({required this.favoriteJokes, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
        backgroundColor: Colors.redAccent,
      ),
      body: favoriteJokes.isEmpty
          ? const Center(
              child: Text(
                'No favorite jokes yet!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: favoriteJokes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      favoriteJokes[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
