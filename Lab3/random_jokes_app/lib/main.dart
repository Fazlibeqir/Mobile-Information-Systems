import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'theme.dart';
import 'screens/home_screen.dart';
import 'screens/random_joke_screen.dart';
import 'screens/favorite_screen.dart';
import 'provider/favorite_jokes_provider.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

   String? token = await messaging.getToken();
   print("FCM Token: $token");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  if (message.notification != null) {
    print('Message Title: ${message.notification!.title}');
    print('Message Body: ${message.notification!.body}');
    // Show local notification using flutter_local_notifications
  }
});
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteJokesProvider(),
      child: const MyApp(),
    ),
  );
  tz.initializeTimeZones();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
      routes: {
        '/random_joke': (context) => const RandomJokeScreen(),
        '/favorite': (context) => const FavoriteScreen(),
      },
    );
  }
}
