import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';

import 'package:cinemapedia/services/database_services.dart';
import 'package:equatable/equatable.dart';

part 'favorite_state.dart';

class FavoritesCubit extends Cubit<Set<String>> {
   DatabaseServices _databaseServices;

   Stream<List<String>>? _favoritesStream;
  StreamSubscription<List<String>>? _favoritesSubscription;

  FavoritesCubit(this._databaseServices) : super({}) {
    _initFavoritesStream();
  }

  void _initFavoritesStream() {
  _favoritesSubscription?.cancel(); // Cancela el anterior si existe

  _favoritesStream = _databaseServices.favoritesIdsStream();

  _favoritesSubscription = _favoritesStream!.listen((favorites) {
    emit(favorites.toSet());
  });
}

   /// Cambia el usuario y reconecta el stream
  void updateUser() {
    _databaseServices = DatabaseServices();
    _initFavoritesStream();
  }

  bool isFavorite(String movieId) {
    return state.contains(movieId);
  }

  Future<void> toggleFavorite(Movie movie) async {
    final isFav = isFavorite(movie.id.toString());
    if (isFav) {
      await _databaseServices.deleteMovie(movie.id.toString());
    } else {
      await _databaseServices.addMovie(MovieMapper.movieToDatabaseModel(movie));
    }
    // El estado se actualiza automáticamente por el stream
  }

   @override
  Future<void> close() {
    _favoritesSubscription?.cancel(); // Limpiar el stream al cerrar el Cubit
    return super.close();
  }
}