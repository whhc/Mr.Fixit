import 'dart:ui';
import 'package:game02/game.dart';
import 'package:flame/sprite.dart';

class Car {
  final CustomGame game;
  Rect carRect;
  Paint carPaint;

  List runingSprite;
  Sprite deadSprite;
  double runingSpriteIndex = 0;

  bool isDead = false;
  bool isOffScreen = false;

  double get speed => game.tileSize * 3;
  Offset targetLocation;

  Car(this.game) {
    setTargeLocation();
    // carRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    // carPaint = Paint();
    // carPaint.color = Color(0xff6ab04c);
  }

  void render(Canvas c) {
    // c.drawRect(carRect, carPaint);
    if (isDead) {
      deadSprite.renderRect(c, carRect.inflate(2));
    } else {
      runingSprite[runingSpriteIndex.toInt()].renderRect(c, carRect.inflate(2));
    }
  }

  void update(double t) {
    if (isDead) {
      carRect = carRect.translate(0, game.tileSize * 12 * t);
    } else {
      runingSpriteIndex += 30 * t;
      if (runingSpriteIndex >= 2) {
        runingSpriteIndex -= 2;
      }
    }

    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(carRect.left, carRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget =
          Offset.fromDirection(toTarget.direction, stepDistance);
      carRect = carRect.shift(stepToTarget);
    } else {
      carRect = carRect.shift(toTarget);
      setTargeLocation();
    }

    if (carRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
  }

  void onTapDown() {
    // carPaint.color = Color(0xffff4757);
    isDead = true;
    game.spawnCar();
  }

  void setTargeLocation() {
    double x =
        game.rnd.nextDouble() * (game.screenSize.width - game.tileSize * 2.025);
    double y = game.rnd.nextDouble() *
        (game.screenSize.height - game.tileSize * 2.025);
    targetLocation = Offset(x, y);
  }
}
