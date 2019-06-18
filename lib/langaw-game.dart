import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:langaw/components/bullet.dart';
import 'package:langaw/components/cannon.dart';

class LangawGame extends Game {
  Size screenSize;
  double tileSize;
  List<Bullet> bullets;
  List<Cannon> cannons;

  //Random rnd;

  LangawGame() {
    initialize();
  }

  void initialize() async {
    bullets = List<Bullet>();
    cannons = List<Cannon>();
    //rnd = Random();
    resize(await Flame.util.initialDimensions());
    //spawnBullet();
    //spawnCannon();
    cannons.add(Cannon(this, tileSize, 100, 'top'));
    cannons.add(Cannon(this, tileSize * 4, 100, 'top'));
    cannons.add(Cannon(this, tileSize * 7, 100, 'top'));
    cannons.add(Cannon(this, tileSize * 10, 100, 'top'));
    cannons.add(Cannon(this, tileSize, screenSize.height - 150, 'bottom'));
    cannons.add(Cannon(this, tileSize * 4, screenSize.height - 150, 'bottom'));
    cannons.add(Cannon(this, tileSize * 7, screenSize.height - 150, 'bottom'));
    cannons.add(Cannon(this, tileSize * 10, screenSize.height - 150, 'bottom'));
  }

  void spawnBullet(x, y, p) {
    //double x = rnd.nextDouble() * (screenSize.width - tileSize);
    //double y = rnd.nextDouble() * (screenSize.height - tileSize);
    print('spawnbullet p is $p');
    bullets.add(Bullet(this, x, y, p));
  }

  void spawnCannon() {
    //cannons.add(Cannon(this, 50, 700));
  }

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);
    bullets.forEach((Bullet bullet) => bullet.render(canvas));
    cannons.forEach((Cannon cannon) => cannon.render(canvas));

  }

  void update(double t) {

    bullets.forEach((Bullet bullet) => bullet.update(t));
    bullets.removeWhere((Bullet bullet) => bullet.isOffScreen);
    bullets.removeWhere((Bullet bullet) => bullet.isExploding);
    cannons.removeWhere((Cannon cannon) => cannon.hp <= 0);
    bullets.forEach((Bullet firstBullet) {
      bullets.forEach((Bullet otherBullet) {
        if (firstBullet.bulletRect.intersect(otherBullet.bulletRect).height > 0
            && firstBullet.bulletRect.intersect(otherBullet.bulletRect).width > 0
            && firstBullet.player != otherBullet.player) {
          //print(firstBullet.bulletRect.intersect(otherBullet.bulletRect).height);
          //print(bullets);
          print('BANG!');
          firstBullet.isExploding = true;
          otherBullet.isExploding = true;
        }
      });
      cannons.forEach((Cannon cannon){
        if (firstBullet.bulletRect.intersect(cannon.cannonRect).height > 0 &&
            firstBullet.bulletRect.intersect(cannon.cannonRect).width > 0 &&
        firstBullet.player != cannon.player){
          cannon.hp -= 10;
          firstBullet.isExploding = true;
          print("${cannon.player} now has ${cannon.hp} in HP");
        }
      });
    });

  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 13;
  }

  void onTapDown(tap, TapDownDetails d) {
    bullets.forEach((Bullet bullet) {
      if (bullet.bulletRect.contains(d.globalPosition)) {
        bullet.onTapDown();
      }
    });
    cannons.forEach((Cannon cannon) {
      if (cannon.cannonRect.contains(d.globalPosition)) {
        cannon.onTapDown();
      }
    });
  }
}
