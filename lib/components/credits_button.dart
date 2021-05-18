import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:game02/game.dart';
import 'package:game02/view.dart';

class CreditsButton {
  final CustomGame game;
  Rect creditsRect;
  Sprite creditsSprite;
  CreditsButton(this.game) {
    creditsRect = Rect.fromLTWH(
      game.screenSize.width - game.tileSize * 1.25,
      game.screenSize.height - game.tileSize * 1.25,
      game.tileSize,
      game.tileSize,
    );
    creditsSprite = Sprite('ui/icon-credits.png');
  }

  void render(Canvas canvas) {
    creditsSprite.renderRect(canvas, creditsRect);
  }

  void onTapDown() {
    game.activeView = View.credits;
  }
}
