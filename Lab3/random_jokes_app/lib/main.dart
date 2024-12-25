import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'screens/home_screen.dart';
import 'screens/random_joke_screen.dart';
import 'screens/favorite_screen.dart';
import 'provider/favorite_jokes_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteJokesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: AppTheme.lightTheme,
      home:  const HomeScreen(),
      routes: {
        '/random_joke':(context) => const RandomJokeScreen(),
        '/favorite':(context) => const FavoriteScreen(),
      },
    );
  }
}
