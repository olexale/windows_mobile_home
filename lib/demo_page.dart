import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:windows_mobile_home/model.dart';
import 'package:windows_mobile_home/tile_card_builder.dart';

class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tiles = getTiles(26).toList();

    return Scaffold(
        body: Stack(fit: StackFit.expand, children: [
      Image.network(
          // https://www.pexels.com/photo/landscape-photography-of-snowy-mountain-1366919/
          'https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
          fit: BoxFit.cover),
      StaggeredGridView.countBuilder(
        crossAxisCount: 6,
        itemCount: tiles.length,
        itemBuilder: (c, i) => TileCardBuilder(model: tiles[i]),
        staggeredTileBuilder: (i) => StaggeredTile.fit(tiles[i].width),
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
      ),
    ]));
  }
}
