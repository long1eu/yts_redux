// File created by
// Lung Razvan <long1eu>
// on 12/11/2019

class GetMovies {
  const GetMovies(this.page);

  final int page;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetMovies && runtimeType == other.runtimeType && page == other.page;

  @override
  int get hashCode => page.hashCode;
}

class SetMovies {
  const SetMovies(this.movies);

  final List<String> movies;
}

class GetMoviesError {
  const GetMoviesError(this.error);

  final Object error;
}

class StopGetMovies {
  const StopGetMovies();
}
