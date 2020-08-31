
import 'package:flutter/material.dart';

abstract class MultiAnimationState<T extends StatefulWidget> extends State<T> with TickerProviderStateMixin {
  AnimationController anim1;
  AnimationController anim2;
  AnimationController anim3;

  @override
  void initState() {
    var defaultDuration = Duration(milliseconds: 350);
    anim1 = AnimationController(vsync: this, duration: defaultDuration);
    anim2 = AnimationController(vsync: this, duration: defaultDuration);
    anim3 = AnimationController(vsync: this, duration: defaultDuration);
    super.initState();
  }

  @override
  void dispose() {
    anim1.dispose();
    anim2.dispose();
    anim3.dispose();
    super.dispose();
  }

  // For fun, lets provide a bonus method, a shortcut for delayed methods.
  // It's likely we'll use these anims in a sequenced way and this makes it easier to read
  void delayed(double duration, VoidCallback action) async {
    // Do something in X seconds
    Future.delayed(Duration(milliseconds: (duration * 1000).round())).then((value) => action?.call());
  }
}