import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:windows_mobile_home/model.dart';
import 'package:windows_mobile_home/tiles/big_tile.dart';
import 'package:windows_mobile_home/tiles/small_tile.dart';
import 'package:windows_mobile_home/tiles/tiny_tile.dart';

class TileCardBuilder extends StatelessWidget {
  final CellModel model;
  static const _padding = 2.0;
  static const _blur = 7.0;

  const TileCardBuilder({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final minimumTileWidth = screenWidth / 6;
    final tileSize = _getTileSize(minimumTileWidth, model.cellType);

    return SizedBox.fromSize(
      size: tileSize,
      child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: new BackdropFilter(
              filter: ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
              child: Container(
                  color: Theme.of(context).accentColor.withAlpha(160),
                  child: _buildTile(model)))),
    );
  }

  Widget _buildTile(CellModel model) {
    if (model.cellType == CellType.tiny) return TinyTile(model);
    if (model.cellType == CellType.small) return SmallTile(model);
    return BigTile(model);
  }

  _getTileSize(double minimumTileWidth, CellType cellType) => Size(
      _getWidth(minimumTileWidth, cellType),
      _getHeight(minimumTileWidth, cellType));

  double _getHeight(double minimumTileWidth, CellType cellType) =>
      cellType == CellType.tiny ? minimumTileWidth : minimumTileWidth * 2;

  double _getWidth(double minimumTileWidth, CellType cellType) {
    if (cellType == CellType.tiny) return minimumTileWidth;
    if (cellType == CellType.small) return minimumTileWidth * 2;
    return minimumTileWidth * 4;
  }
}
