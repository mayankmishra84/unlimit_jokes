import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/entities/joke.dart';
import 'models/joke_model.dart';
import '../domain/repositories/joke_repository.dart';

class JokeRepositoryImpl implements JokeRepository {
  final String apiUrl = "https://geek-jokes.sameerkumar.website/api?format=json";

  @override
  Future<Joke> fetchJoke() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final JokeModel jokeModel = JokeModel.fromJson(data);
      return Joke(joke: jokeModel.joke); // Creating a Joke instance
    } else {
      throw Exception("Failed to fetch joke");
    }
  }
}
