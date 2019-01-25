import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class CellModel {
  final String appName;
  final String imageUrl;
  final IconData icon;
  final String subtitle;
  final CellType cellType;

  CellModel(
      {this.appName, this.imageUrl, this.subtitle, this.cellType, this.icon});

  int get width {
    switch (this.cellType) {
      case CellType.tiny:
        return 1;
      case CellType.small:
        return 2;
      case CellType.big:
        return 4;
    }
    return 1;
  }
}

enum CellType { tiny, small, big }

/// Photos by https://www.pexels.com/@eberhardgross
const _images = [
  'https://images.pexels.com/photos/750108/pexels-photo-750108.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=300&w=300',
  'https://images.pexels.com/photos/640805/pexels-photo-640805.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=300&w=300',
  'https://images.pexels.com/photos/772456/pexels-photo-772456.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=300&w=300'
];

final _apps = [
  CellModel(appName: 'Phone', icon: Icons.phone),
  CellModel(appName: 'Groove Music', icon: Icons.headset),
  CellModel(
      appName: 'Messages', icon: Icons.message, subtitle: 'No unread messages'),
  CellModel(
      appName: 'Outlook',
      icon: Icons.email,
      subtitle: 'Your Wednesday evening trip with Uber'),
  CellModel(appName: 'Store', icon: Icons.local_grocery_store),
  CellModel(appName: 'Gallery', icon: Icons.photo_library),
  CellModel(appName: 'Camera', icon: Icons.camera),
  CellModel(appName: 'Alarm', icon: Icons.alarm),
  CellModel(appName: 'People', icon: Icons.people),
  CellModel(appName: 'HERE Maps', icon: Icons.navigation),
  CellModel(appName: 'Settings', icon: Icons.settings)
];

Iterable<CellModel> getTiles(int count) sync* {
  final rnd = Random();
  final cellTypes = [CellType.small, CellType.small, CellType.small]
    ..addAll(CellType.values);
  for (var i = 0; i < count; ++i) {
    final app = _apps[rnd.nextInt(_apps.length)];
    yield CellModel(
        appName: app.appName,
        imageUrl:
            rnd.nextInt(10) >= 7 ? _images[rnd.nextInt(_images.length)] : null,
        subtitle: app.subtitle ?? '',
        cellType: cellTypes[rnd.nextInt(cellTypes.length)],
        icon: app.icon);
  }
}
