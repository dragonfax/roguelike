import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';

const tileListFilename = 'assets/tiles_list_v1.3';
const tileSetFilename = 'assets/0x72_DungeonTilesetII_v1.3.png';

class TileDef {
  final String name;
  final int x, y, width, height, frames;

  TileDef(this.name, this.x, this.y, this.width, this.height, this.frames);
}

var tileDatabase = <String,TileDef>{};

var tileDefR = RegExp(r"^([a-z0-9_]+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)(\s+(\d+))?$");

Image tileSetImage;

readTiles() async {
  var tileListBody = await rootBundle.loadString(tileListFilename);
  var tileList = tileListBody.split("\n");
  for ( var line in tileList) {
    if ( line == "" ) {
      continue;
    }

    var m = tileDefR.firstMatch(line);
    if ( m == null ) {
      throw("failure to match tile definition '$line'");
    }
    if ( m.groupCount <= 4 ) {
      throw("failure to match enough fields ${m.groupCount} '$line' '$m'");
    }
    var name = m.group(1);
    var x = int.parse(m.group(2));
    var y = int.parse(m.group(3));
    var width = int.parse(m.group(4));
    var height = int.parse(m.group(5));
    var frames = m.group(7) == null ? 1 : int.parse(m.group(7));

    tileDatabase[name] = TileDef(name, x, y, width, height, frames);
  }

  print("${tileDatabase.length} tiles loaded into database");

  tileSetImage = Image(image: AssetImage(tileSetFilename));
}

class ImageClipper extends CustomClipper<Rect> {
  final Rect rect;

  ImageClipper(this.rect);

  @override
  Rect getClip(Size size) {
    return rect;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }

}

Widget getTileWidget(TileDef def) {
  return ClipRect(
    clipper: ImageClipper(Rect.fromLTWH(def.x.toDouble(), def.y.toDouble(), def.width.toDouble(), def.height.toDouble())),
    child:tileSetImage
  );
}
