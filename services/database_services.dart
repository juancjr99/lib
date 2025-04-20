// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinemapedia/infrastructure/models/moviedb/movie_database_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String MOVIES_COLLECTION_REF = 'movies';

class DatabaseServices {

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // late final CollectionReference _moviesRef;
  // DatabaseServices(){
  //   _moviesRef = _firestore.collection(MOVIES_COLLECTION_REF).withConverter<MovieDatabaseModel>(
  //     fromFirestore: (snapshots,_) => MovieDatabaseModel.fromJson(snapshots.data()!),
  //     toFirestore: (movieDatabaseModel,_) => movieDatabaseModel.toJson());
  // }

  // Retorna la referencia a la subcolección de favoritos del usuario actual
  CollectionReference<MovieDatabaseModel> get _userFavoritesRef {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        
        .withConverter<MovieDatabaseModel>(
          fromFirestore: (snapshots, _) =>
              MovieDatabaseModel.fromJson(snapshots.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );
  }

  
  /// Obtener las películas favoritas en tiempo real
  Stream<QuerySnapshot<MovieDatabaseModel>> getMovies() {
    return _userFavoritesRef.snapshots();
  }

  /// Agregar película a favoritos
  Future<void> addMovie(MovieDatabaseModel movie) async {
    try {
      await _userFavoritesRef.doc(movie.id.toString()).set(movie);
    } catch (e) {
      print('Error al agregar película: $e');
    }
  }

  /// Eliminar película de favoritos
  Future<void> deleteMovie(String movieId) async {
    try {
      await _userFavoritesRef.doc(movieId).delete();
    } catch (e) {
      print('Error al eliminar película: $e');
    }
  }

  /// Verifica si una película está en favoritos
  Future<bool> isFavorite(String movieId) async {
    try {
      final doc = await _userFavoritesRef.doc(movieId).get();
      return doc.exists;
    } catch (e) {
      print('Error al verificar favorito: $e');
      return false;
    }
  }

  Stream<List<String>> favoritesIdsStream() {
  return _userFavoritesRef.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => doc.id).toList();
  });
}

//   Stream<QuerySnapshot> getMovies(){
//     return _moviesRef.snapshots();
//   }

//   void addMovie(MovieDatabaseModel movieDatabaseModel)async{
//   try {
//     await _moviesRef.add(movieDatabaseModel);
//   } catch (e) {
//     // Aquí podrías usar un logger, mostrar un snackbar, etc.
//     print('Error al agregar película: $e');
//   }

// }
// void deleteMovie(String id)async{
//     try {
//       await _moviesRef.doc(id).delete();
//     } catch (e) {
//       // Aquí podrías usar un logger, mostrar un snackbar, etc.
//       print('Error al eliminar película: $e');
//     }
//   }
}
