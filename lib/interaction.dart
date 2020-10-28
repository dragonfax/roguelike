class Entity {
  final bool isHero;
  final bool isEnemy;
  final bool isFloor;

  final strength = 20;

  Entity(this.isHero, this.isEnemy, this.isFloor);
}

class Actor extends Entity {
  int hp = 100;

  Actor(bool isHero, bool isEnemy) : super(isHero, isEnemy, false);

  void move() {
    todo
  }

  moveTowards(Entity entity) {
    todo
  }

  attack(Actor entity) {
    entity.hp -= strength;
  }
}

var interactionManager = InteractionManager();
var monsterManager = MonsterManager();

enum Phase { ChoosingHero, SelectingCommand, EnemyMove }

class InteractionManager {
  Phase phase = Phase.ChoosingHero;
  Actor selectedHero;
  
  todo wire this into all nodes created,
  tod create floor nodes.
  Function currySelectEntity(Entity entity) {
    return () {
      // choose what to do based on our current phase.
      switch (phase) {
        case Phase.EnemyMove:
          // do nothing
          break;
        case Phase.ChoosingHero:
          if (!entity.isHero) {
            break;
          }
          selectedHero = entity;
          phase = Phase.SelectingCommand;
          break;
        case Phase.SelectingCommand:
          if (entity.isEnemy) {
            selectedHero.attack(entity);
          } else if (entity.isFloor) {
            selectedHero.moveTowards(entity);
          } else {
            // not a valid command, try again.
            break;
          }
          selectedHero = null;
          phase = Phase.EnemyMove;
          monsterManager.moveMonsters();
          break;
      }
    };
  }
}

class MonsterManager {
  todo create level monsters from this list.
  var monsters = <Actor>[
    todo
  ];
  moveMonsters() async {
    for (var monster in monsters) {
      monster.move();
    }
    interactionManager.phase = Phase.ChoosingHero;
  }
}
