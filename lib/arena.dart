import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'sprites.dart';
import 'dart:math';

class Terrain {
  final IconData icon;
  Terrain(this.icon);
}

var terrains = <String, Terrain>{};

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
  var arena = <Position, Cell>{};

  var entities = <Entity>[];
}

class ArenaWidget extends StatelessWidget {
  final Arena arena;

  ArenaWidget(this.arena);

  @override
  Widget build(BuildContext context) {
    var root = NodeWithSize(const Size(17.0 * 10, 17.0 * 10));

    // buildTileDemo(root);
    buildRandomMap(root);

    return SpriteWidget(root, SpriteBoxTransformMode.scaleToFit);
  }
}

var rand = Random();

buildRandomMap(Node root) {
  for (var x = 0.0; x < 10; x++) {
    for (var y = 0.0; y < 10; y++) {
      var i = rand.nextInt(8) + 1;
      var node = tileToNode("floor_$i");
      node.position = Offset(x * 17, y * 17);
      root.addChild(node);
    }
  }

  var node = tileToNode("wizzard_f_idle_anim");
  node.position = Offset(3.0 * 17, 8.0 * 17);
  root.addChild(node);

  node = tileToNode("knight_m_idle_anim");
  node.position = Offset(4.0 * 17, 6.0 * 17);
  root.addChild(node);

  node = tileToNode("elf_m_idle_anim");
  node.position = Offset(2.0 * 17, 7.0 * 17);
  root.addChild(node);

  node = tileToNode("skelet_idle_anim");
  node.position = Offset(2.0 * 17, 2.0 * 17);
  root.addChild(node);

  node = tileToNode("ice_zombie_idle_anim");
  node.position = Offset(8.0 * 17, 1.0 * 17);
  root.addChild(node);

  node = tileToNode("big_demon_idle_anim");
  node.position = Offset(5.0 * 17, 1.0 * 17);
  root.addChild(node);
}

buildTileDemo(Node root) {
  var x = 0.0;
  var y = 0.0;
  var yAdd = 0.0;
  for (var tileName in tileDatabase.keys) {
    var node = tileToNode(tileName);

    node.position = Offset(x, y);
    root.addChild(node);

    x += node.size.width;
    if (node.size.height > yAdd) {
      yAdd = node.size.height;
    }
    if (x > 256) {
      x = 0;
      y += yAdd;
      yAdd = 0;
    }
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
