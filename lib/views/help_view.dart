import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:game02/game.dart';

class HelpView {
  final CustomGame game;

  Rect helpViewRect;
  Sprite helpViewSprite;

  HelpView(this.game) {
    helpViewRect = Rect.fromLTWH(
      game.tileSize * .5,
      game.screenSize.height / 2 - game.tileSize * 6,
      game.tileSize * 8,
      game.tileSize * 12,
    );
    helpViewSprite = Sprite('ui/dialog-help.png');
  }
  void render(Canvas canvas) {
    helpViewSprite.renderRect(canvas, helpViewRect);
  }
}
