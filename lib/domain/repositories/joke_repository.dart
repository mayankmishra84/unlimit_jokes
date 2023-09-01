import '../entities/joke.dart';

abstract class JokeRepository {
  Future<Joke> fetchJoke();
}
