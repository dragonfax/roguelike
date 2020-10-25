import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:spritewidget/spritewidget.dart';

const tileListFilename = 'assets/tiles_list_v1.3';
const tileSetFilename = 'assets/0x72_DungeonTilesetII_v1.3.png';

class TileDef {
  final String name;
  final int x, y, width, height, frames;

  TileDef(this.name, this.x, this.y, this.width, this.height, this.frames);
}

var tileDatabase = <String,TileDef>{};

var tileDefR = RegExp(r"^([a-z0-9_]+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)(\s+(\d+))?$");

ui.Image tileSetImage;

String spriteJS;

readTiles() async {
  var tileListBody = await rootBundle.loadString(tileListFilename);
  var tileList = tileListBody.split("\n");
  var tileStrings = <String>[];
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

    for ( var frameNum=0;  frameNum<frames; frameNum++) {
      tileStrings.add('{ "filename": "${name}_$frameNum", "rotated": false, "trimmed": true, "pivot": { "x":0,"y":0 }, "frame": {"x":${x + width * frameNum},"y":$y,"w":$width,"h":$height}, "sourceSize":{"w":$width,"h":$height}, "spriteSourceSize":{"x":0,"y":0,"w":$width,"h":$height} }');
    }
  }

  spriteJS = '{ "frames": [ ${tileStrings.join(",")} ]}';
  print(spriteJS);

  print("${tileDatabase.length} tiles loaded into database");

  ImageMap images = new ImageMap(rootBundle);
  tileSetImage = await images.loadImage(tileSetFilename);
}

class ImageClipper extends CustomClipper<Rect> {
  final Rect rect;

  ImageClipper(this.rect);

  @override
  Rect getClip(Size size) {
    print("ImageClipper got size $size");
    return rect;
  }
  
  @override
  bool shouldReclip(ImageClipper oldClipper) {
    print("ImageClipper got old ${oldClipper.rect}");
    return true;
  }

}

/*
Widget getTileWidget(TileDef def) {
  return ClipRect(
    clipper: ImageClipper(Rect.fromLTWH(def.x.toDouble(), def.y.toDouble(), def.width.toDouble(), def.height.toDouble())),
    child:tileSetImage,
  );
}
*/
