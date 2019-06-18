import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:langaw/langaw-game.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';


void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  Flame.images.loadAll(<String>['banana.png']);
  LangawGame game = LangawGame();
  runApp(game.widget);

  MultiTapGestureRecognizer tapper = MultiTapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}
