import 'package:flutter/material.dart';
import 'package:random_jokes_app/theme.dart';
import '../services/api_services.dart';
import '../models/joke.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({super.key});

  @override
  _RandomJokeScreenState createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  late Future<Joke> randomJoke;

  @override
  void initState() {
    super.initState();
    randomJoke = ApiServices().fetchRandomJoke();
  }

  void _fetchNewJoke() {
    setState(() {
      randomJoke = ApiServices().fetchRandomJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Joke'),
       backgroundColor: AppTheme.primaryColor,),
      body: FutureBuilder<Joke>(
        future: randomJoke,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No joke available'));
          } else {
            Joke joke = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    joke.setup,
                    style: const TextStyle(fontSize: 20, color: AppTheme.textColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      joke.punchline,
                      style: const TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _fetchNewJoke,
                    child: const Text(
                      'Get Another Joke',
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
