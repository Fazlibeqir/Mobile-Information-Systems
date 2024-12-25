import 'package:flutter/material.dart';
import '../screens/joke_type_screen.dart';
import '../theme.dart'; // Ensure you import the theme file

class JokeCard extends StatelessWidget {
  final String type;

  const JokeCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      color: AppTheme.cardBackgroundColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JokeTypeScreen(type: type),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.lightbulb_outline,
                size: 50,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 10),
              Text(
                type,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
