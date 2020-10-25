import 'package:flutter/material.dart';
import 'sprites.dart';

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
    return GridView.count(
      crossAxisCount: 10,
      crossAxisSpacing: 1.0,
      children: [ for ( var def in tileDatabase.values ) getTileWidget(def)],
    );
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