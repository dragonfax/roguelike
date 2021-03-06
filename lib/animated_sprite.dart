import 'package:spritewidget/spritewidget.dart';
import 'dart:math';

class AnimatedSprite extends NodeWithSize {
  final List<Sprite> frames;
  Sprite currentFrame;
  int frameModifier;

  static Random rand = Random();

  AnimatedSprite(this.frames) : super(frames[0].size) {
    frameModifier = rand.nextInt(frames.length);

    if (frames.length > 1) {
      MotionTween myTween = new MotionTween<double>(
        rotateFrames,
        0,
        (frames.length - 1).toDouble(),
        0.5,
      );
      motions.run(MotionRepeatForever(myTween));
    } else {
      addChild(frames[0]);
    }
  }

  void rotateFrames(dynamic f) {
    if (currentFrame != null) {
      removeChild(currentFrame);
    }
    var i = (f as double).floor();
    i += frameModifier;
    i = i % frames.length;
    var newSprite = frames[i];
    addChild(newSprite);
    currentFrame = newSprite;
  }
}
