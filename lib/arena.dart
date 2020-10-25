import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'sprites.dart';
import 'animated_sprite.dart';

class Terrain {
  final IconData icon;
  Terrain(this.icon);
}

var terrains = <String,Terrain>{};

class Cell {
  final Position position;

  Entity entity;

  final Terrain floor;

  Cell(this.position, this.floor);
}

class CellWidget extends StatelessWidget {
  final Cell cell;

  CellWidget(this.cell);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Position {
  int x, y;
}

class Arena {
  var arena = <Position,Cell>{};

  var entities = <Entity>[];
}

class ArenaWidget extends StatelessWidget {
  final Arena arena;

  ArenaWidget(this.arena);

  @override
  Widget build(BuildContext context) {
    var sheet = SpriteSheet(tileSetImage,spriteJS);
    var root = NodeWithSize(const Size(256.0, 256.0));

    var x = 0.0;
    var y = 0.0;
    var yAdd = 0.0;
    for ( var tileDef in tileDatabase.values ) {
      var name = tileDef.name;

      var frameList = <Sprite>[];
      for ( var frame=0; frame< tileDef.frames; frame++ ) {
        var texture = sheet.textures["${name}_$frame"];
        var sprite = Sprite(texture);
        frameList.add(sprite);
      }

      var node = AnimatedSprite(frameList);
      node.position = Offset(x,y);
      root.addChild(node);
      x += node.size.width;
      if ( node.size.height > yAdd ) {
        yAdd = node.size.height;
      }
      if ( x > 256 ) {
        x = 0;
        y += yAdd;
        yAdd = 0;
      }
    }
    return SpriteWidget(root, SpriteBoxTransformMode.scaleToFit);
  }
}

enum CombatStyle {
  Ranged,
  Close,
  Magick,
}

abstract class Entity {

  int hp;
  final CombatStyle combatStyle;

  Entity(this.hp, this.combatStyle);

}