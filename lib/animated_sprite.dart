import 'package:spritewidget/spritewidget.dart';
import 'dart:ui';

class AnimatedSprite extends Node {
  final List<Sprite> frames;
  Sprite currentFrame;

  Size get size {
    return frames[0].size;
  }

  AnimatedSprite(this.frames) {

    if ( frames.length > 1 ) {
      MotionTween myTween = new MotionTween<double>(
        rotateFrames,
        0, 
        (frames.length -1).toDouble(), 
        0.5,
      );
      motions.run(MotionRepeatForever(myTween));
    } else {
      addChild(frames[0]);
    }

  }

  void rotateFrames(dynamic f) {
    if ( currentFrame != null ) {
      removeChild(currentFrame);
    }
    var i = (f as double).floor();
    var newSprite = frames[i];
    addChild(newSprite);
    currentFrame = newSprite;
  }
}
