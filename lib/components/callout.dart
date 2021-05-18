import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
// import 'package:flame/flame.dart';

import 'package:game02/components/car.dart';
import 'package:game02/view.dart';

class Callout {
  final Car car;
  Rect rect;
  Sprite sprite;
  double value;

  TextPainter textPainter;
  TextStyle textStyle;
  Offset position;

  Callout(this.car) {
    sprite = Sprite('ui/callout.png');
    value = 1;
    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xff000000),
      fontSize: 15,
    );
  }

  void render(Canvas canvas) {
    if (rect != null) {
      sprite.renderRect(canvas, rect);
      textPainter.paint(canvas, position);
    }
  }

  void update(double t) {
    if (car.game.activeView == View.playing) {
      value = value - .5 * t;
      if (value <= 0) {
        if (car.game.soundButton.isEnabled) {
          // Flame.audio.play('sfx/haha' + (car.game.rnd.nextInt(5) + 1).toString() + '.ogg');
        }
        car.game.playHomeBGM();
        car.game.activeView = View.end;
      }
    }

    rect = Rect.fromLTWH(
      car.carRect.left - car.game.tileSize * .25,
      car.carRect.top - car.game.tileSize * .5,
      car.game.tileSize * .75,
      car.game.tileSize * .75,
    );
    textPainter.text =
        TextSpan(text: (value * 10).toInt().toString(), style: textStyle);

    textPainter.layout();
    position = Offset(
      rect.center.dx - (textPainter.width / 2),
      rect.top + rect.height * .4 - (textPainter.height / 2),
    );
  }
}
