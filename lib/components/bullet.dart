import 'dart:ui';
import 'package:langaw/langaw-game.dart';

class Bullet {
  final LangawGame game;
  Rect bulletRect;
  Paint bulletPaint;
  bool isFlying = true;
  bool isOffScreen = false;
  bool isExploding = false;
  var player;

  Bullet(this.game, double x, double y, p) {
    player = p;
    print("Player is: $player");
    double bulletWidth = game.tileSize;
    double exitposition = x - (bulletWidth / 2);
    bulletRect = Rect.fromLTWH(exitposition, y, game.tileSize, game.tileSize);
    bulletPaint = Paint();
    player == 'top'?
         bulletPaint.color = Color(0xffff4757)
        : bulletPaint.color = Color(0xff6ab40c);
  }

  void render(Canvas c) {
    c.drawRect(bulletRect, bulletPaint);
  }

  void update(double t) {
    if (isFlying) {
      player == 'top'
          ? bulletRect = bulletRect.translate(0, game.tileSize * 20 * t)
          : bulletRect = bulletRect.translate(0, game.tileSize * -20 * t);
    }
    if (bulletRect.top > game.screenSize.height || bulletRect.bottom <0) {
      isOffScreen = true;
    }

  }

  void onTapDown() {
    //bulletPaint.color = Color(0xffff4757);
    //isFlying = true;
    //game.spawnBullet();
  }
}
