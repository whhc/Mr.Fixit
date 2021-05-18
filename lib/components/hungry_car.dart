import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:game02/game.dart';
import 'car.dart';

class HungryCar extends Car {
  HungryCar(CustomGame game, double x, double y) : super(game) {
    carRect = Rect.fromLTWH(x, y, game.tileSize * 1.1, game.tileSize * 1.1);
    runingSprite = [];
    runingSprite.add(Sprite('flies/hungry-fly-1.png'));
    runingSprite.add(Sprite('flies/hungry-fly-2.png'));
    deadSprite = Sprite('flies/hungry-fly-dead.png');
  }
}
