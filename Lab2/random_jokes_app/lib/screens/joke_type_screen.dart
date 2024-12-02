import 'package:flutter/material.dart';
import 'package:random_jokes_app/theme.dart';
import '../services/api_services.dart';
import '../models/joke.dart';

class JokeTypeScreen extends StatefulWidget{
  final String type;
  const JokeTypeScreen({super.key, required this.type});

  @override
  _JokeTypeScreenState createState() => _JokeTypeScreenState();
}
class _JokeTypeScreenState extends State<JokeTypeScreen>{
  late Future<List<Joke>> jokes;
  @override
  void initState(){
    super.initState();
    jokes = ApiServices().fetchJokesByType(widget.type);
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.type} Jokes'),
       backgroundColor: AppTheme.primaryColor,),
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
                Joke joke = snapshot.data![index];
                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                );
              },
            );
          }
        },
      ),
    );
  }
}