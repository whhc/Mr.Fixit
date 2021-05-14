import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:game02/game.dart';

class LostView {
  final CustomGame game;

  Rect lostRect;
  Sprite lostSprite;
  LostView(this.game) {
    lostRect = Rect.fromLTWH(
      game.tileSize,
      game.screenSize.height / 2 - game.tileSize * 4,
      game.tileSize * 7,
      game.tileSize * 4,
    );
    lostSprite = Sprite('bg/lose-splash.png');
  }
  void render(Canvas canvas) {
    lostSprite.renderRect(canvas, lostRect);
  }

  void update(double t) {}
}
