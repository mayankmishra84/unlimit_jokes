import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/joke_repository.dart';
import 'domain/repositories/joke_repository.dart';
import 'presentation/bloc/joke_bloc.dart';
import 'presentation/pages/joke_page.dart';

void main() {
  final JokeRepository jokeRepository = JokeRepositoryImpl();
  final JokeBloc jokeBloc = JokeBloc(jokeRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => jokeBloc),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UnLimit Jokes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JokePage(),
    );
  }
}
