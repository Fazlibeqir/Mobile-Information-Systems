import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/favorite_jokes_provider.dart';

class FavoriteScreen extends StatelessWidget {

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
      ),
      body: Consumer<FavoriteJokesProvider>(
        builder: (context, favoriteProvider, _) {
          final favoriteJokes = favoriteProvider.favoriteJokes;
          return favoriteJokes.isEmpty
              ? const Center(child: Text('No favorite jokes yet!'))
              : ListView.builder(
                  itemCount: favoriteJokes.length,
                  itemBuilder: (context, index) {
                    final joke = favoriteJokes[index];
                    return ListTile(
                      title: Text(joke.setup),
                      subtitle: Text(joke.punchline),
                    );
                  },
                );
        },
      ),
    );
  }
}