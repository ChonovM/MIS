import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String type;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const JokeCard({
    required this.type,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          type,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: const Icon(Icons.mood, size: 32, color: Colors.blue),
        trailing: IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.red),
          onPressed: onFavorite,
        ),
        onTap: onTap,
      ),
    );
  }
}
