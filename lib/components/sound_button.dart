import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:game02/game.dart';

class SoundButton {
  final CustomGame game;
  Rect rect;
  Sprite enabledSprite;
  Sprite disabledSprite;
  bool isEnabled = true;

  SoundButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      game.tileSize * .25,
      game.tileSize,
      game.tileSize,
    );

    enabledSprite = Sprite('ui/icon-sound-enabled.png');
    disabledSprite = Sprite('ui/icon-sound-disabled.png');
  }

  void render(Canvas canvas) {
    if (isEnabled) {
      enabledSprite.renderRect(canvas, rect);
    } else {
      disabledSprite.renderRect(canvas, rect);
    }
  }

  void onTapDown() {
    if (isEnabled) {
      isEnabled = false;
      // game.homeBGM.setVolume(0);
      // game.playingBGM.setVolume(0);
    } else {
      isEnabled = true;
      // game.homeBGM.setVolume(.25);
      // game.playingBGM.setVolume(.25);
    }
  }
}
