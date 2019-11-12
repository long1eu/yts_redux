// File created by
// Lung Razvan <long1eu>
// on 12/11/2019
import 'package:meta/meta.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yts_redux/src/actions/get_movies.dart';
import 'package:yts_redux/src/data/yts_api.dart';
import 'package:yts_redux/src/models/app_state.dart';

export 'package:rxdart/rxdart.dart';

class AppEpics {
  const AppEpics({@required YtsApi ytsApi})
      : assert(ytsApi != null),
        _ytsApi = ytsApi;

  final YtsApi _ytsApi;

  Epic<AppState> get epics {
    return combineEpics<AppState>(<Epic<AppState>>[
      _getMovies,
    ]);
  }

  Stream<dynamic> _getMovies(Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable<dynamic>(actions)
        .whereType<GetMovies>()
        .distinct()
        .delay(const Duration(seconds: 5))
        .flatMap((GetMovies action) =>
            Observable<List<String>>.fromFuture(_ytsApi.getMovies(store.state.page)))
        .takeUntil(Observable<dynamic>(actions).whereType<StopGetMovies>())
        .map<dynamic>((List<String> movies) => SetMovies(movies))
        .onErrorReturnWith((dynamic error) => GetMoviesError(error));
  }
}
