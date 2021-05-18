import 'package:game02/game.dart';
import 'package:game02/components/car.dart';

class CarSpawner {
  final CustomGame game;

  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int intervalChange = 3;
  final maxCarsOnScreen = 7;
  int currentInterval;
  int nextSpawn;

  CarSpawner(this.game) {
    start();
    game.spawnCar();
  }

  void start() {
    destroyAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void destroyAll() {
    game.cars.forEach((Car car) => car.isDead = true);
  }

  void update(double t) {
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch;

    int brokenCars = 0;

    game.cars.forEach((Car car) {
      if (!car.isDead) brokenCars += 1;
    });

    if (nowTimeStamp >= nextSpawn && brokenCars < maxCarsOnScreen) {
      game.spawnCar();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimeStamp + currentInterval;
    }
  }
}
