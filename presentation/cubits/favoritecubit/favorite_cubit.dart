import 'package:bloc/bloc.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';

import 'package:cinemapedia/services/database_services.dart';
import 'package:equatable/equatable.dart';

part 'favorite_state.dart';

class FavoritesCubit extends Cubit<Set<String>> {
  final DatabaseServices databaseServices;

  Stream<List<String>>? _favoritesStream;

  FavoritesCubit(this.databaseServices) : super({}) {
    _favoritesStream = databaseServices.favoritesIdsStream();
    _favoritesStream!.listen((favorites) {
      emit(favorites.toSet());
    });
  }

  bool isFavorite(String movieId) {
    return state.contains(movieId);
  }

  Future<void> toggleFavorite(Movie movie) async {
    final isFav = isFavorite(movie.id.toString());
    if (isFav) {
      await databaseServices.deleteMovie(movie.id.toString());
    } else {
      await databaseServices.addMovie(MovieMapper.movieToDatabaseModel(movie));
    }
    // El estado se actualiza automáticamente por el stream
  }
}