class DetailMovieModel {
  DetailMovieModel({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
  late final bool adult;
  late final String backdropPath;
  late final int budget;
  late final List<Genres> genres;
  late final String homepage;
  late final int id;
  late final String imdbId;
  late final String originalLanguage;
  late final String originalTitle;
  late final String overview;
  late final double popularity;
  late final String posterPath;
  late final String releaseDate;
  late final int revenue;
  late final int runtime;
  late final String status;
  late final String tagline;
  late final String title;
  late final bool video;
  late final double voteAverage;
  late final int voteCount;

  DetailMovieModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] ?? false;
    backdropPath = json['backdrop_path'] ?? "/1X7vow16X7CnCoexXh4H4F2yDJv.jpg";
    budget = json['budget'] ?? 0;
    genres = List.from(json['genres']).map((e) => Genres.fromJson(e)).toList();
    homepage = json['homepage'] ?? '';
    id = json['id'] ?? 0;
    imdbId = json['imdb_id'] ?? '';
    originalLanguage = json['original_language'] ?? '';
    originalTitle = json['original_title'] ?? '';
    overview = json['overview'] ?? '';
    popularity = json['popularity'] ?? 0.0;
    posterPath = json['poster_path'] ?? "/1X7vow16X7CnCoexXh4H4F2yDJv.jpg";
    releaseDate = json['release_date'] ?? '';
    revenue = json['revenue'] ?? 0;
    runtime = json['runtime'] ?? 0;
    status = json['status'] ?? '';
    tagline = json['tagline'] ?? '';
    title = json['title'] ?? '';
    video = json['video'] ?? false;
    voteAverage = json['vote_average'] ?? false;
    voteCount = json['vote_count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['adult'] = adult;
    _data['backdrop_path'] = backdropPath;
    _data['budget'] = budget;
    _data['genres'] = genres.map((e) => e.toJson()).toList();
    _data['homepage'] = homepage;
    _data['id'] = id;
    _data['imdb_id'] = imdbId;
    _data['original_language'] = originalLanguage;
    _data['original_title'] = originalTitle;
    _data['overview'] = overview;
    _data['popularity'] = popularity;
    _data['poster_path'] = posterPath;
    _data['release_date'] = releaseDate;
    _data['revenue'] = revenue;
    _data['runtime'] = runtime;
    _data['status'] = status;
    _data['tagline'] = tagline;
    _data['title'] = title;
    _data['video'] = video;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    return _data;
  }
}

class Genres {
  Genres({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
