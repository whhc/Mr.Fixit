import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:game02/game.dart';

class CreditsView {
  final CustomGame game;
  Rect creditsViewRect;
  Sprite creditsViewSprite;

  CreditsView(this.game) {
    creditsViewRect = Rect.fromLTWH(
      game.tileSize * .5,
      game.screenSize.height / 2 - game.tileSize * 6,
      game.tileSize * 8,
      game.tileSize * 12,
    );
    creditsViewSprite = Sprite('ui/dialog-credits.png');
  }
  void render(Canvas canvas) {
    creditsViewSprite.renderRect(canvas, creditsViewRect);
  }
}
