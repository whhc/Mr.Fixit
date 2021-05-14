import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:game02/game.dart';
import 'car.dart';

class AgileCar extends Car {
  double get speed => game.tileSize * 8;
  AgileCar(CustomGame game, double x, double y) : super(game) {
    carRect = Rect.fromLTWH(x, y, game.tileSize * 1.5, game.tileSize * 1.5);
    runingSprite = [];
    runingSprite.add(Sprite('flies/agile-fly-1.png'));
    runingSprite.add(Sprite('flies/agile-fly-2.png'));
    deadSprite = Sprite('flies/agile-fly-dead.png');
  }
}
