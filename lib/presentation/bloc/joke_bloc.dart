import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/joke.dart';
import '../../domain/repositories/joke_repository.dart';

class JokeBloc extends Cubit<List<Joke>> {
  final JokeRepository jokeRepository;

  JokeBloc(this.jokeRepository) : super([]);

  Future<void> fetchNewJoke() async {
    try {
      final joke = await jokeRepository.fetchJoke();
      state.add(joke);

      if (state.length > 10) {
        state.removeAt(0);
      }

      emit(state.toList());
    } catch (e) {
      // Handle error
    }
  }
}
