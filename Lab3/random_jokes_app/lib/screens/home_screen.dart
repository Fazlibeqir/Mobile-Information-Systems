import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/api_services.dart';
import '../widgets/joke_card.dart';
import 'favorite_screen.dart';
import '../models/joke.dart';
import '../services/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<String>> _jokeTypes;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _jokeTypes = ApiServices().fetchJokeTypes();
    _initializeNotificationService();
  }

  Future<void> _initializeNotificationService() async {
    try {
      await _notificationService.init();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initialize notifications: $e')),
      );
    }
  }

  Future<void> _sendDailyJokeNotification() async {
    try {
      // Fetch a random joke
      Joke randomJoke = await ApiServices().fetchRandomJoke();

      // Schedule the notification
      await _notificationService.showDailyJokeNotification(
        "${randomJoke.setup}\n${randomJoke.punchline}",
      );

      // Notify user about the successful scheduling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notification scheduled: ${randomJoke.setup}')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch joke: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes App'),
        backgroundColor: AppTheme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              Navigator.pushNamed(context, '/random_joke');
            },
            color: Colors.white,
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: _jokeTypes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No joke types available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String type = snapshot.data![index];
                return JokeCard(type: type);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendDailyJokeNotification,
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.notifications),
      ),
    );
  }
}
