import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:game02/game.dart';

class HighscoreDisplay {
  final CustomGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  HighscoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    Shadow shadow = Shadow(
      blurRadius: 3,
      color: Color(0xff000000),
      offset: Offset.zero,
    );

    textStyle = TextStyle(
      fontSize: 30,
      color: Color(0xffffffff),
      shadows: [shadow, shadow, shadow, shadow],
    );
  }

  void udpateHighscore() {
    int highscore = game.storage.getInt('highscore') ?? 0;
    painter.text = TextSpan(
      text: 'High-score: ' + highscore.toString(),
      style: textStyle,
    );

    painter.layout();

    position = Offset(
      game.screenSize.width - game.tileSize * .25 - painter.width,
      game.tileSize * .25,
    );
  }

  void render(Canvas canvas) {
    painter.paint(canvas, position);
  }
}
