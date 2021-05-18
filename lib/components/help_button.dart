import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:game02/game.dart';
import 'package:game02/view.dart';

class HelpButton {
  final CustomGame game;
  Rect helpRect;
  Sprite helpSprite;
  HelpButton(this.game) {
    helpRect = Rect.fromLTWH(
      game.tileSize * .25,
      game.screenSize.height - game.tileSize * 1.25,
      game.tileSize,
      game.tileSize,
    );
    helpSprite = Sprite('ui/icon-help.png');
  }

  void render(Canvas canvas) {
    helpSprite.renderRect(canvas, helpRect);
  }

  void onTapDown() {
    game.activeView = View.help;
  }
}
