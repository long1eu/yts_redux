// File created by
// Lung Razvan <long1eu>
// on 12/11/2019

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:yts_redux/src/models/app_state.dart';

class MoviesContainer extends StatelessWidget {
  const MoviesContainer({Key key, this.builder}) : super(key: key);

  final ViewModelBuilder<List<String>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<String>>(
      converter: (Store<AppState> store) => store.state.movies,
      builder: builder,
    );
  }
}
