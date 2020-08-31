import 'package:extendingflutterstate/multi_animation_mixin.dart';
import 'package:extendingflutterstate/multi_animation_state.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(body: SomePageWithAnimationsUsingMixins()),
    );
  }
}

/// /////////////////////////////////////////
/// Basic Mixin
/// /////////////////////////////////////////
mixin SomeMixin<T> on State {
  @override
  void initState() {
    //Do some shared init stuff here
    super.initState();
  }
}

/// Use the above mixin
class SomeWidget extends StatefulWidget {
  @override
  _SomeWidgetState createState() => _SomeWidgetState();
}

class _SomeWidgetState<SomeWidget> extends State with SomeMixin {
  @override
  Widget build(BuildContext context) => Container();
}

/// /////////////////////////////////////////
/// Basic State
/// /////////////////////////////////////////
abstract class SomeState<T extends StatefulWidget> extends State<T> {
  @override
  void initState() {
    //Do some shared init stuff here
    super.initState();
  }
}

/// Use the above State
class SomeWidget2 extends StatefulWidget {
  @override
  _SomeWidgetState createState() => _SomeWidgetState();
}

class _SomeWidget2State<SomeWidget> extends SomeState {
  @override
  Widget build(BuildContext context) => Container();
}

/// //////////////////////////////////////
/// Animated Page using a [MultiAnimationStateMixin] and a [TickerProviderStateMixin]
class SomePageWithAnimationsUsingMixins extends StatefulWidget {
  @override
  _SomePageWithAnimationsUsingMixinsState createState() => _SomePageWithAnimationsUsingMixinsState();
}

class _SomePageWithAnimationsUsingMixinsState<SomePageWithAnimations> extends State
    with TickerProviderStateMixin, MultiAnimationStateMixin {
  @override
  void initState() {
    super.initState();
    // We can access the properties in the parent class, and change the duration of any of the anims if we need.
    anim1.duration = Duration(seconds: 1);
    anim1.forward(); // Start Anim1
    delayed(.35, () => anim2.forward()); // Start Anim2 (delayed)
    delayed(.7, () => anim3.forward()); // Start Anim3 (delayed)
  }

  @override
  Widget build(BuildContext context) => SomeAnimatedContent(anim3, anim3, anim3);
}

/// //////////////////////////////////////
/// Animated Page using a base [MultiAnimationState] class
class SomePageWithAnimations extends StatefulWidget {
  @override
  _SomePageWithAnimationsUsingMixinsState createState() => _SomePageWithAnimationsUsingMixinsState();
}

class _SomePageWithAnimationsState<SomePageWithAnimations> extends MultiAnimationState {
  @override
  void initState() {
    super.initState();
    // We can access the properties in the parent class, and change the duration of any of the anims if we need.
    anim1.duration = Duration(seconds: 1);
    anim1.forward(); // Start Anim1
    delayed(.35, () => anim2.forward()); // Start Anim2 (delayed)
    delayed(.7, () => anim3.forward()); // Start Anim3 (delayed)
  }

  @override
  Widget build(BuildContext context) => SomeAnimatedContent(anim3, anim3, anim3);
}

/// This is shared between both examples to reduce code, usually you'd probably just implement this within the parent build method
class SomeAnimatedContent extends StatelessWidget {
  final AnimationController anim1;
  final AnimationController anim2;
  final AnimationController anim3;

  const SomeAnimatedContent(this.anim1, this.anim2, this.anim3, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: anim1, // Anim1 fades in the whole view
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Content 1 - Fades in 2nd
          FadeTransition(
            opacity: anim2,
            child: Text("Content"),
          ),
          // Content 2
          FadeTransition(
            opacity: anim3, // - Fades in 3rd
            child: Text("Some more content..."),
          ),
        ],
      ),
    );
  }
}
