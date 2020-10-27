import 'package:roguelike/animated_sprite.dart';
import 'animated_sprite.dart';
import 'package:spritewidget/spritewidget.dart';

class InterativeAnimatedSprite extends AnimatedSprite {
  final Function onClicked;

  InterativeAnimatedSprite(List<Sprite> frames, this.onClicked)
      : super(frames) {
    userInteractionEnabled = true;
  }
  @override
  handleEvent(SpriteBoxEvent event) {
    onClicked();
    return true;
  }
}
