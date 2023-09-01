import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/joke.dart';
import '../bloc/joke_bloc.dart';

class JokePage extends StatefulWidget {
  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  @override
  void initState() {
    super.initState();
    final jokeBloc = context.read<JokeBloc>();
    jokeBloc.fetchNewJoke();

    // Fetch a new joke every minute
    Timer.periodic(Duration(minutes: 1), (_) {
      jokeBloc.fetchNewJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UnLimit Jokes'),
      ),
      body: BlocBuilder<JokeBloc, List<Joke>>(
        builder: (context, jokes) {
          return ListView.builder(
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: AnimatedOpacity(
                  opacity: 1.0, // Adjust the opacity as needed
                  duration: const Duration(milliseconds: 500),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.sentiment_satisfied,
                            // Add the smiley face icon here
                            color: Colors.amber, // Customize the icon color
                            size: 24.0, // Customize the icon size
                          ),
                          const SizedBox(width: 16.0), // Add some spacing
                          Expanded(
                            child: Text(
                              jokes[index].joke ?? "",
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final jokeBloc = context.read<JokeBloc>();
          jokeBloc.fetchNewJoke();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
