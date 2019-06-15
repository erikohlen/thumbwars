import 'dart:ui';
import 'package:langaw/langaw-game.dart';

class Bullet {
  final LangawGame game;
  Rect bulletRect;
  Paint bulletPaint;
  bool isFlying = true;
  bool isOffScreen = false;
  var player;

  Bullet(this.game, double x, double y, p) {
    player = p;
    print("Player is: $player");
    double bulletWidth = game.tileSize;
    double bulletHeight = game.tileSize;
    double exitposition = x - (bulletWidth / 2);
    bulletRect = Rect.fromLTWH(exitposition, y, game.tileSize , game.tileSize );
    bulletPaint = Paint();
    player == 'bottom'
        ? bulletPaint.color = Color(0xff6ab40c)
        : bulletPaint.color = Color(0xffff4757);
  }

  void render(Canvas c) {
    c.drawRect(bulletRect, bulletPaint);
  }

  void update(double t) {
    if (isFlying) {

      player == 'bottom'
          ? bulletRect = bulletRect.translate(0, game.tileSize * -20 * t)
          : bulletRect = bulletRect.translate(0, game.tileSize * 20 * t);

    }
    if (bulletRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
  }

  void onTapDown() {
    //bulletPaint.color = Color(0xffff4757);
    //isFlying = true;
    //game.spawnBullet();
  }
}
