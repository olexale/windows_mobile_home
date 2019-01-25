import 'package:flutter/material.dart';
import 'package:windows_mobile_home/model.dart';

class BigTile extends StatelessWidget {
  final CellModel model;

  BigTile(this.model);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${model.appName}',
                style: Theme.of(context).accentTextTheme.headline,
              ),
              Text(
                '${model.subtitle}',
                style: Theme.of(context).accentTextTheme.subhead,
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            '${model.appName}',
            style: Theme.of(context).accentTextTheme.body1,
          ),
        ),
      )
    ]);
  }
}
