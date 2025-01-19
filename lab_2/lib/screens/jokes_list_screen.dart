import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke.dart';

class JokesListScreen extends StatelessWidget {
  final String type;

  const JokesListScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes of type: $type'),
      ),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.getJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No jokes found.'));
          }

          return ListView(
            children: snapshot.data!
                .map((joke) => ListTile(
                      title: Text(joke.setup),
                      subtitle: Text(joke.punchline),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
