import 'package:flutter/material.dart';

class CardSpec {
  final String name;
  final String flavorText;
  final IconData icon;

  CardSpec(this.name, this.flavorText, this.icon);
}

class CardDatabase {
  static var cards = <CardSpec>[
    CardSpec("Sword", "+1 to attack", Icons.call_made_sharp)
  ];

}

class CardWidget extends StatelessWidget {
  final CardSpec card;

  CardWidget(this.card);

  @override
  Widget build(BuildContext context) {
    return null;
  }

}

class Hand {

  var hand = <CardSpec>[];

}

class HandWidget extends StatelessWidget {
  final Hand hand;

  HandWidget(this.hand);

  @override
  Widget build(BuildContext context) {
    return null;
  }

}

class DeckCardSpec {
  final CardSpec card;
  bool inDeck = true;

  DeckCardSpec(this.card);
}

class Deck {
  var cards = <DeckCardSpec>[];

  var draw = <CardSpec>[];
  var discard = <CardSpec>[];

}
