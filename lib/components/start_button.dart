import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:game02/game.dart';
import 'package:game02/view.dart';

class StartButton {
  final CustomGame game;

  Rect buttonRect;
  Sprite buttonSprite;

  StartButton(this.game) {
    buttonRect = Rect.fromLTWH(
      game.tileSize * 1.5,
      game.screenSize.height * .75 - game.tileSize * 1.5,
      game.tileSize * 6,
      game.tileSize * 3,
    );
    buttonSprite = Sprite('ui/start-button.png');
  }

  void render(Canvas canvas) {
    buttonSprite.renderRect(canvas, buttonRect);
  }

  void update(double t) {}

  void onTapHandler() {
    game.activeView = View.playing;
  }
}
