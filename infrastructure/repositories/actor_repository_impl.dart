import 'package:cinemapedia/domain/datasources/actors.datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repository/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository{
  
  final ActorsDatasource datasource;

  ActorRepositoryImpl(this.datasource);
  
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
   return datasource.getActorsByMovie(movieId);
    
  }
}