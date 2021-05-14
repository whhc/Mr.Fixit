import 'dart:ui';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';

import 'package:game02/components/car.dart';
import 'package:game02/components/normal_car.dart';
import 'package:game02/components/broken_car.dart';
import 'package:game02/components/aglie_car.dart';
import 'package:game02/components/macho_car.dart';
import 'package:game02/components/hungry_car.dart';
import 'package:game02/components/start_button.dart';

import 'package:game02/components/backyard.dart';
import 'package:game02/view.dart';
import 'package:game02/views/home_view.dart';
import 'package:game02/views/lost_view.dart';

class CustomGame extends Game with TapDetector {
  View activeView = View.home;
  HomeView homeView;
  LostView lostView;
  StartButton startButton;

  Size screenSize;
  double tileSize;
  List<Car> cars;
  Random rnd;
  Backyard background;

  CustomGame() {
    initialize();
  }

  void initialize() async {
    cars = [];
    resize(await Flame.util.initialDimensions());

    background = Backyard(this);
    homeView = HomeView(this);
    lostView = LostView(this);
    startButton = StartButton(this);

    rnd = Random();
    spawnCar();
  }

  void spawnCar() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize * 2.025);
    double y = rnd.nextDouble() * (screenSize.height - tileSize * 2.025);
    // cars.add(NormalCar(this, x, y));
    switch (rnd.nextInt(5)) {
      case 0:
        cars.add(NormalCar(this, x, y));
        break;
      case 1:
        cars.add(BrokenCar(this, x, y));
        break;
      case 2:
        cars.add(AgileCar(this, x, y));
        break;
      case 3:
        cars.add(MachoCar(this, x, y));
        break;
      case 4:
        cars.add(HungryCar(this, x, y));
        break;
    }
  }

  void render(Canvas canvas) {
    // Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    // Paint bgPaint = Paint();
    // bgPaint.color = Color(0xff576574);
    // canvas.drawRect(bgRect, bgPaint);

    background.render(canvas);

    cars.forEach((Car car) => car.render(canvas));

    if (activeView == View.home) {
      homeView.render(canvas);
    }

    if (activeView == View.home || activeView == View.end) {
      startButton.render(canvas);
    }

    if (activeView == View.end) {
      lostView.render(canvas);
    }
  }

  void update(double t) {
    cars.forEach((Car car) => car.update(t));
    cars.removeWhere((Car car) => car.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;
    bool didHitACar = false;

    if (!isHandled) {
      cars.forEach((Car car) {
        if (car.carRect.contains(d.globalPosition)) {
          car.onTapDown();
          didHitACar = true;
          isHandled = true;
        }
      });

      if (!didHitACar && activeView == View.playing) {
        activeView = View.end;
      }
    }

    if (!isHandled && startButton.buttonRect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.end) {
        startButton.onTapHandler();
        isHandled = true;
      }
    }
  }
}
