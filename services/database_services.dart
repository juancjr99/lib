// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinemapedia/infrastructure/models/moviedb/movie_database_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String MOVIES_COLLECTION_REF = 'movies';

class DatabaseServices {

  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _moviesRef;
  DatabaseServices(){
    _moviesRef = _firestore.collection(MOVIES_COLLECTION_REF).withConverter<MovieDatabaseModel>(
      fromFirestore: (snapshots,_) => MovieDatabaseModel.fromJson(snapshots.data()!),
      toFirestore: (movieDatabaseModel,_) => movieDatabaseModel.toJson());
  }

  Stream<QuerySnapshot> getMovies(){
    return _moviesRef.snapshots();
  }

  void addMovie(MovieDatabaseModel movieDatabaseModel)async{
  try {
    await _moviesRef.add(movieDatabaseModel);
  } catch (e) {
    // Aquí podrías usar un logger, mostrar un snackbar, etc.
    print('Error al agregar película: $e');
  }
}
}
