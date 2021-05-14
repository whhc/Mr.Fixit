import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:game02/game.dart';
import 'car.dart';

class MachoCar extends Car {
  double get speed => game.tileSize * 2;
  MachoCar(CustomGame game, double x, double y) : super(game) {
    carRect = Rect.fromLTWH(x, y, game.tileSize * 2.025, game.tileSize * 2.025);
    runingSprite = [];
    runingSprite.add(Sprite('flies/macho-fly-1.png'));
    runingSprite.add(Sprite('flies/macho-fly-2.png'));
    deadSprite = Sprite('flies/macho-fly-dead.png');
  }
}
