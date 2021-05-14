import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:game02/components/car.dart';
import 'package:game02/game.dart';

class NormalCar extends Car {
  NormalCar(CustomGame game, double x, double y) : super(game) {
    carRect = Rect.fromLTWH(x, y, game.tileSize * 1.5, game.tileSize * 1.5);
    runingSprite = [];
    runingSprite.add(Sprite('flies/house-fly-1.png'));
    runingSprite.add(Sprite('flies/house-fly-2.png'));
    deadSprite = Sprite('flies/house-fly-dead.png');
  }
}
