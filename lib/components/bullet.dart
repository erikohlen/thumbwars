import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:langaw/langaw-game.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flame/sprite.dart';
//import '';

class Bullet {
  final LangawGame game;
  Rect bulletRect;
  FlareActor bananaFlare;
  Sprite bananaSprite;
  double FlyingSpriteIndex = 0;
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
    //bulletPaint = Paint();
    bananaSprite = Sprite('banana.png');
    //player == 'top' ?
    //bulletPaint.color = Color(0xffff4757)
    //    : bulletPaint.color = Color(0xff6ab40c);
    //bananaFlare = FlareActor("assets/animations/banana01.flr",
       // alignment: Alignment.center,
       // fit: BoxFit.contain,
       // animation: "fruit_banana");

  }

  void render(Canvas c) {
    //c.drawRect(bulletRect,bulletPaint);
    bananaSprite.renderRect(c, bulletRect.inflate(0));
    //bananaSprite.render(c);
  }

  void update(double t) {
    if (isFlying) {
      player == 'top'
          ? bulletRect = bulletRect.translate(0, game.tileSize * 20 * t)
          : bulletRect = bulletRect.translate(0, game.tileSize * -20 * t);
    }
    if (bulletRect.top > game.screenSize.height || bulletRect.bottom < 0) {
      isOffScreen = true;
    }
  }

  void onTapDown() {
    //bulletPaint.color = Color(0xffff4757);
    //isFlying = true;
    //game.spawnBullet();
  }
}
