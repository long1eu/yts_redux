import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:yts_redux/src/actions/get_movies.dart';
import 'package:yts_redux/src/containers/movie_connector.dart';
import 'package:yts_redux/src/data/yts_api.dart';
import 'package:yts_redux/src/epics/app_epics.dart';
import 'package:yts_redux/src/models/app_state.dart';

import 'src/reducer/reducer.dart';

void main() {
  final YtsApi api = YtsApi();

  final Store<AppState> store = Store<AppState>(
    (AppState state, dynamic action) {
      print(action);
      return reducer(state, action);
    },
    initialState: const AppState(),
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(AppEpics(ytsApi: api).epics),
    ],
  );

  store.dispatch(const GetMovies(1));

  runApp(YtsReduxApp(store: store));
}

class YtsReduxApp extends StatefulWidget {
  const YtsReduxApp({Key key, this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  _YtsReduxAppState createState() => _YtsReduxAppState();
}

class _YtsReduxAppState extends State<YtsReduxApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.minScrollExtent == _scrollController.position.extentAfter) {
      final Store<AppState> store = StoreProvider.of<AppState>(context);
      store.dispatch(GetMovies(store.state.page));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YTS'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.stop),
            onPressed: () {
              StoreProvider.of<AppState>(context).dispatch(const StopGetMovies());
            },
          ),
        ],
      ),
      body: MoviesContainer(
        builder: (BuildContext context, List<String> movies) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                title: Text(movies[i]),
              );
            },
          );
        },
      ),
    );
  }
}
