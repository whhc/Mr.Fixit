import 'dart:ui';
import 'package:game02/game.dart';
import 'package:flame/sprite.dart';
import 'package:game02/view.dart';
// import 'package:flame/flame.dart';
import 'package:game02/components/callout.dart';

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

  Callout callout;

  Car(this.game) {
    setTargeLocation();
    // carRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    // carPaint = Paint();
    // carPaint.color = Color(0xff6ab04c);
    callout = Callout(this);
  }

  void render(Canvas c) {
    // if (isDead) {
    //   deadSprite.renderRect(c, carRect.inflate(2));
    // } else {
    //   runingSprite[runingSpriteIndex.toInt()].renderRect(c, carRect.inflate(2));
    //   if (game.activeView == View.playing) {
    //     callout.render(c);
    //   }
    // }

    // 修改BUG：修改sprite尺寸为命中范围矩形的2倍
    // c.drawRect(carRect.inflate(carRect.width / 2), Paint()..color = Color(0x77ffffff));

    if (isDead) {
      deadSprite.renderRect(c, carRect.inflate(carRect.width / 2));
    } else {
      runingSprite[runingSpriteIndex.toInt()]
          .renderRect(c, carRect.inflate(carRect.width / 2));
      if (game.activeView == View.playing) {
        callout.render(c);
      }
    }

    // c.drawRect(carRect, Paint()..color = Color(0x88000000));
  }

  void update(double t) {
    if (isDead) {
      carRect = carRect.translate(0, game.tileSize * 18 * t);
    } else {
      callout.update(t);
      runingSpriteIndex += 30 * t;
      // if (runingSpriteIndex >= 2) {
      //   runingSpriteIndex -= 2;
      // }
      while (runingSpriteIndex >= 2) {
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
      print('Go to hell!');
    }

    if (carRect.top < 0) {
      isOffScreen = true;
      print('Go to heaven!');
    }
  }

  void onTapDown() {
    // carPaint.color = Color(0xffff4757);
    if (!isDead) {
      isDead = true;
      // game.spawnCar();
      if (game.activeView == View.playing) {
        game.score += 1;
        if (game.score > (game.storage.getInt('highscore') ?? 0)) {
          game.storage.setInt('highscore', game.score);
          game.highscoreDisplay.udpateHighscore();
        }
      }
      if (game.soundButton.isEnabled) {
        // Flame.audio.play('sfx/ouch' + (game.rnd.nextInt(11) + 1).toString() + '.ogg');
      }
    }
  }

  void setTargeLocation() {
    double x =
        game.rnd.nextDouble() * (game.screenSize.width - game.tileSize * 1.35);
    double y = game.rnd.nextDouble() *
            (game.screenSize.height - game.tileSize * 2.85) +
        game.tileSize * 1.5;
    targetLocation = Offset(x, y);
  }
}
