import 'dart:ui';
import 'package:langaw/langaw-game.dart';

class Cannon {
  final LangawGame game;
  Rect cannonRect;
  Paint cannonPaint;
  double centerX;
  double centerY;
  int hp = 100;
  var player;

  Cannon(this.game, double x, double y, p) {
    player = p;
    cannonRect = Rect.fromLTWH(x, y, game.tileSize * 2, game.tileSize *3);
    cannonPaint = Paint();
    if(player == 'bottom'){cannonPaint.color = Color(0xff6ab40c);}
    if(player == 'top'){cannonPaint.color = Color(0xffff4757);}

    centerX = cannonRect.center.dx;
    centerY = cannonRect.center.dy;
  }

  void render (Canvas c){
    c.drawRect(cannonRect, cannonPaint);
  }
  void update (double t) {

  }
  void onTapDown() {
  game.spawnBullet(centerX, centerY, player);
  }
}