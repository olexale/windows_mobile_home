import 'package:flutter/material.dart';
import 'package:windows_mobile_home/model.dart';

class TinyTile extends StatelessWidget {
  final CellModel model;

  TinyTile(this.model);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Icon(
      model.icon,
      size: 32,
      color: Theme.of(context).accentIconTheme.color,
    ));
  }
}
