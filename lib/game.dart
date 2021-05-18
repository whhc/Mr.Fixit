import 'dart:ui';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:game02/components/car.dart';
import 'package:game02/components/normal_car.dart';
import 'package:game02/components/broken_car.dart';
import 'package:game02/components/aglie_car.dart';
import 'package:game02/components/macho_car.dart';
import 'package:game02/components/hungry_car.dart';
import 'package:game02/components/start_button.dart';
import 'package:game02/components/help_button.dart';
import 'package:game02/components/credits_button.dart';
import 'package:game02/components/backyard.dart';
import 'package:game02/components/score_display.dart';
import 'package:game02/components/highscore_display.dart';
import 'package:game02/components/music_button.dart';
import 'package:game02/components/sound_button.dart';

import 'package:game02/view.dart';
import 'package:game02/views/home_view.dart';
import 'package:game02/views/lost_view.dart';
import 'package:game02/views/help_view.dart';
import 'package:game02/views/credits_view.dart';

import 'package:game02/controllers/spawner.dart';

class CustomGame extends Game with TapDetector {
  final SharedPreferences storage;

  // AssetsAudioPlayer homeBGM;
  // AssetsAudioPlayer playingBGM;

  final homeBGM = AssetsAudioPlayer();
  final playingBGM = AssetsAudioPlayer();

  View activeView = View.home;
  HomeView homeView;
  LostView lostView;
  HelpView helpView;
  CreditsView creditsView;
  StartButton startButton;
  HelpButton helpButton;
  CreditsButton creditsButton;
  ScoreDisplay scoreDisplay;
  HighscoreDisplay highscoreDisplay;

  MusicButton musicButton;
  SoundButton soundButton;

  Size screenSize;
  double tileSize;
  List<Car> cars;
  Random rnd;
  Backyard background;

  CarSpawner carSpawner;

  int score;

  CustomGame(this.storage) {
    initialize();
  }

  void initialize() async {
    cars = [];
    resize(await Flame.util.initialDimensions());

    background = Backyard(this);
    homeView = HomeView(this);
    lostView = LostView(this);
    helpView = HelpView(this);
    creditsView = CreditsView(this);

    startButton = StartButton(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);

    rnd = Random();
    score = 0;
    // spawnCar();
    carSpawner = CarSpawner(this);

    musicButton = MusicButton(this);
    soundButton = SoundButton(this);

    // homeBGM = AssetsAudioPlayer.newPlayer();
    // playingBGM = AssetsAudioPlayer.newPlayer();

    await homeBGM.open(Audio.file('assets/audio/bgm/home.mp3'));
    await playingBGM.open(Audio.file('assets/audio/bgm/playing.mp3'));

    homeBGM.pause();
    playingBGM.pause();

    playHomeBGM();
  }

  void playHomeBGM() async {
    playingBGM.pause();
    // playingBGM.seek(Duration.zero);
    homeBGM.seek(Duration.zero);
    homeBGM.play();
  }

  void playPlayingBgm() async {
    homeBGM.pause();
    // homeBGM.seek(Duration.zero);
    playingBGM.seek(Duration.zero);
    playingBGM.play();
  }

  void spawnCar() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize * 1.35);
    double y = rnd.nextDouble() * (screenSize.height - tileSize * 1.35);
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
    if (activeView == View.help) helpView.render(canvas);

    if (activeView == View.credits) creditsView.render(canvas);

    musicButton.render(canvas);
    soundButton.render(canvas);

    background.render(canvas);

    cars.forEach((Car car) => car.render(canvas));

    if (activeView == View.home) homeView.render(canvas);

    if (activeView == View.home || activeView == View.end) {
      startButton.render(canvas);
      helpButton.render(canvas);
      creditsButton.render(canvas);
    }

    if (activeView == View.end) lostView.render(canvas);

    highscoreDisplay.render(canvas);

    if (activeView == View.playing) scoreDisplay.render(canvas);
  }

  void update(double t) {
    cars.forEach((Car car) => car.update(t));
    cars.removeWhere((Car car) => car.isOffScreen);
    carSpawner.update(t);
    scoreDisplay.update(t);
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
        if (soundButton.isEnabled) {
          // Flame.audio.play('sfx/haha' + (rnd.nextInt(5) + 1).toString() + '.ogg');
        }
        playHomeBGM();
        activeView = View.end;
      }
    }

    if (!isHandled && startButton.buttonRect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.end) {
        startButton.onTapHandler();
        isHandled = true;
      }
    }

    if (!isHandled && helpButton.helpRect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.end) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

    if (!isHandled && creditsButton.creditsRect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.end) {
        creditsButton.onTapDown();
        isHandled = true;
      }
    }

    if (!isHandled) {
      if (activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }

    if (!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapDown();
      isHandled = true;
    }

    if (!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapDown();
      isHandled = true;
    }
  }
}
