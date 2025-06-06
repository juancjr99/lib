class MovieDatabaseModel {
  final bool adult;
  final String backdropPath;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDatabaseModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id, 
    required this.originalLanguage, 
    required this.originalTitle, 
    required this.overview, 
    required this.popularity, 
    required this.posterPath, 
    required this.releaseDate, 
    required this.title, 
    required this.video, 
    required this.voteAverage, 
    required this.voteCount});

  factory MovieDatabaseModel.fromJson(Map<String, dynamic> json) => MovieDatabaseModel(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"] ?? 'no-backdrop',
    genreIds: List<String>.from(json["genre_ids"].map((x) => x.toString())),
    id: json["id"] ?? 0,
    originalLanguage: json["original_language"] ?? 'no-language',
    originalTitle: json["original_title"] ?? 'no-title',
    overview: json["overview"] ?? 'no-overview',
    popularity: (json["popularity"] ?? 0).toDouble(),
    posterPath: json["poster_path"] ?? 'no-poster',
    releaseDate: DateTime.parse(json["release_date"]),
    title: json["title"] ?? 'no-title',
    video: json["video"] ?? false,
    voteAverage: (json["vote_average"] ?? 0).toDouble(),
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate.toIso8601String(),
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  MovieDatabaseModel copyWith({
    bool? adult,
    String? backdropPath,
    List<String>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    DateTime? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) {
    return MovieDatabaseModel(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      id: id ?? this.id,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount
    );
  }

}