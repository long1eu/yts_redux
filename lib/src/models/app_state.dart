// File created by
// Lung Razvan <long1eu>
// on 12/11/2019

class AppState {
  const AppState({this.movies = const <String>[], this.page = 1});

  final List<String> movies;
  final int page;

  AppState copyWith({List<String> movies, int page}) {
    return AppState(
      movies: movies ?? this.movies,
      page: page ?? this.page,
    );
  }
}
