
class MoviesListModel {
  List<Results>? results;

  MoviesListModel({this.results});

  MoviesListModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromMap(v));
      });
    }
  }
}

class Results {
  int? id;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;

  Results({
    this.id,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
  });

  Results.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    overview = data['overview'];
    posterPath = data['poster_path'];
    releaseDate = data['release_date'];
    title = data['title'];
  }
}
