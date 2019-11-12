// File created by
// Lung Razvan <long1eu>
// on 12/11/2019

import 'package:redux/redux.dart';
import 'package:yts_redux/src/actions/get_movies.dart';
import 'package:yts_redux/src/models/app_state.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  TypedReducer<AppState, SetMovies>(_setMovies),
]);

AppState _setMovies(AppState state, SetMovies action) {
  return state.copyWith(
    movies: <String>[...state.movies, ...action.movies],
    page: state.page + 1,
  );
}
