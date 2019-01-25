import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:windows_mobile_home/flip_transition.dart';
import 'package:windows_mobile_home/model.dart';

class SmallTile extends StatefulWidget {
  final CellModel model;

  SmallTile(this.model);

  @override
  _SmallTileState createState() => _SmallTileState();
}

class _SmallTileState extends State<SmallTile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _frontRotation;
  Animation<double> _backRotation;
  Timer _timer;

  @override
  void initState() {
    if (widget.model.imageUrl != null) {
      _controller = AnimationController(
          duration: const Duration(milliseconds: 500), vsync: this);

      _frontRotation = TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: Tween(begin: 0.0, end: pi / 2)
                .chain(CurveTween(curve: Curves.linear)),
            weight: 50.0,
          ),
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(pi / 2),
            weight: 50.0,
          ),
        ],
      ).animate(_controller);

      _backRotation = TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(pi / 2),
            weight: 50.0,
          ),
          TweenSequenceItem<double>(
            tween: Tween(begin: -pi / 2, end: 0.0)
                .chain(CurveTween(curve: Curves.linear)),
            weight: 50.0,
          ),
        ],
      ).animate(_controller);

      _timer = Timer.periodic(Duration(seconds: Random().nextInt(3) + 2),
          (t) => _toggleAnimation());
    }

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.model.imageUrl == null) return front();

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FlipTransition(animation: _frontRotation, child: front()),
        FlipTransition(
          animation: _backRotation,
          child: back(),
        ),
      ],
    );
  }

  Widget front() => Stack(children: [
        Center(
          child: Icon(
            widget.model.icon,
            size: 48,
            color: Theme.of(context).accentIconTheme.color,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              '${widget.model.appName}',
              style: Theme.of(context).accentTextTheme.body1,
            ),
          ),
        )
      ]);

  Widget back() => Image.network(widget.model.imageUrl, fit: BoxFit.cover);

  void _toggleAnimation() async {
    if (_controller.status == AnimationStatus.dismissed)
      await _controller.forward();
    else if (_controller.status == AnimationStatus.completed)
      await _controller.reverse();
  }
}
