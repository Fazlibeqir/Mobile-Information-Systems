import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/joke.dart';
import '../services/api_services.dart';
import '../provider/favorite_jokes_provider.dart';
import '../theme.dart';

class JokeTypeScreen extends StatefulWidget {
  final String type;

  const JokeTypeScreen({super.key, required this.type});

  @override
  _JokeTypeScreenState createState() => _JokeTypeScreenState();
}

class _JokeTypeScreenState extends State<JokeTypeScreen> {
  late Future<List<Joke>> jokes;

  @override
  void initState() {
    super.initState();
    jokes = ApiServices().fetchJokesByType(widget.type);
  }

  void toggleFavorite(Joke joke) {
    final favoriteJokesProvider =
        Provider.of<FavoriteJokesProvider>(context, listen: false);
    setState(() {
      joke.isFavorite = !joke.isFavorite;
      if (joke.isFavorite) {
        favoriteJokesProvider.addFavorite(joke);
      } else {
        favoriteJokesProvider.removeFavorite(joke);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Jokes'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: FutureBuilder<List<Joke>>(
        future: jokes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No jokes available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final joke = snapshot.data![index];
                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  trailing: IconButton(
                    icon: Icon(
                      joke.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: joke.isFavorite ? Colors.red : null,
                    ),
                    onPressed: () => toggleFavorite(joke),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
