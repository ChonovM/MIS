import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke.dart';

class RandomJokeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke of the Day'),
      ),
      body: FutureBuilder<Joke>(
        future: ApiService.getRandomJoke(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No joke found.'));
          }

          final joke = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(joke.setup, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text(joke.punchline,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );
  }
}
