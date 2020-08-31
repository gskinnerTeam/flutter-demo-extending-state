import 'package:flutter/material.dart';

mixin MultiAnimationStateMixin on State {
  AnimationController anim1;
  AnimationController anim2;
  AnimationController anim3;

  @override
  void initState() {
    var defaultDuration = Duration(milliseconds: 350);
    anim1 = AnimationController(vsync: this as TickerProviderStateMixin, duration: defaultDuration);
    anim2 = AnimationController(vsync: this as TickerProviderStateMixin, duration: defaultDuration);
    anim3 = AnimationController(vsync: this as TickerProviderStateMixin, duration: defaultDuration);
    super.initState();
  }

  @override
  void dispose() {
    anim1.dispose();
    anim2.dispose();
    anim3.dispose();
    super.dispose();
  }

  // We can put our same Delayed function in a Mixin, just like we did the base-class
  void delayed(double duration, VoidCallback action) async =>
      Future.delayed(Duration(milliseconds: (duration * 1000).round())).then((value) => action?.call());
}
