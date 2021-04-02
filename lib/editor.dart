import 'package:flutter/material.dart';

class LevelEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [ArenaEditor(), TilePicker()]);
  }
}
