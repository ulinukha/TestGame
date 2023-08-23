import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:test_game/main.dart';

import '../sprite_sheet/_index.dart';

class Orc extends SimpleEnemy
    with BlockMovementCollision, AutomaticRandomMovement, UseBarLife {
  bool canMove = true;

  Orc(Vector2 position)
      : super(
          position: position,
          animation: SimpleDirectionAnimation(
            idleRight: SpriteSheetOrc.getIdleBottomRight(),
            idleDownRight: SpriteSheetOrc.getIdleBottomRight(),
            idleUpRight: SpriteSheetOrc.getIdleTopRight(),
            idleUp: SpriteSheetOrc.getIdleTopRight(),
            idleDown: SpriteSheetOrc.getIdleBottomRight(),
            runRight: SpriteSheetOrc.getRunBottomRight(),
            runUpRight: SpriteSheetOrc.getRunTopRight(),
          ),
          speed: tileSize * 3,
          size: Vector2.all(tileSize * 2.9),
        ) {
    setupBarLife(
      size: Vector2(tileSize * 1.5, tileSize / 5),
      borderWidth: tileSize / 5,
      borderColor: Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(2),
      barLifeDrawPosition: BarLifeDrawPorition.bottom,
      showLifeText: false,
      position: Vector2(width / 8, -tileSize * 0.4),
    );
  }

  @override
  Future<void> onLoad() {
    add(
      RectangleHitbox(
        size: Vector2(size.x * 0.2, size.y * 0.15),
        position: Vector2(tileSize * 1.15, tileSize * 1.5),
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (canMove) {
      seePlayer(
        radiusVision: tileSize * 2,
        observed: (player) {
          moveTowardsTarget(
            target: player,
            close: () {
              _execAttack();
            },
          );
        },
        notObserved: () {
          runRandomMovement(
            dt,
            speed: speed / 3,
            maxDistance: (tileSize * 2).toInt(),
          );
        },
      );
    }
    super.update(dt);
  }

  @override
  void die() {
    canMove = false;
    animation?.playOnce(
      SpriteSheetOrc.getDie(),
      onFinish: () {
        removeFromParent();
      },
      runToTheEnd: true,
      useCompFlip: true,
    );
    super.die();
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    if (!isDead) {
      showDamage(
        damage,
        initVelocityTop: -2,
        config: TextStyle(color: Colors.white, fontSize: tileSize / 2),
      );
      _addDamageAnimation();
    }
    super.receiveDamage(attacker, damage, identify);
  }

  void _addAttackAnimation() {
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
      case Direction.right:
        newAnimation = SpriteSheetOrc.getAttackBottomRight();
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = SpriteSheetOrc.getAttackTopRight();
        } else {
          newAnimation = SpriteSheetOrc.getAttackTopLeft();
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = SpriteSheetOrc.getAttackBottomRight();
        } else {
          newAnimation = SpriteSheetOrc.getAttackBottomLeft();
        }
        break;
      case Direction.upLeft:
      case Direction.upRight:
        newAnimation = SpriteSheetOrc.getAttackTopRight();
        break;
      case Direction.downLeft:
      case Direction.downRight:
        newAnimation = SpriteSheetOrc.getAttackBottomRight();
        break;
    }
    animation?.playOnce(
      newAnimation,
      runToTheEnd: true,
      useCompFlip: true,
    );
  }

  void _addDamageAnimation() {
    canMove = false;
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
      case Direction.right:
        newAnimation = SpriteSheetOrc.getDamageBottomRight();
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = SpriteSheetOrc.getDamageTopRight();
        } else {
          newAnimation = SpriteSheetOrc.getDamageTopLeft();
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = SpriteSheetOrc.getDamageBottomRight();
        } else {
          newAnimation = SpriteSheetOrc.getDamageBottomLeft();
        }
        break;
      case Direction.upLeft:
      case Direction.upRight:
        newAnimation = SpriteSheetOrc.getDamageTopRight();
        break;
      case Direction.downLeft:
      case Direction.downRight:
        newAnimation = SpriteSheetOrc.getDamageBottomRight();
        break;
    }
    animation?.playOnce(
      newAnimation,
      runToTheEnd: true,
      useCompFlip: true,
      onFinish: () {
        canMove = true;
      },
    );
  }

  void _execAttack() {
    simpleAttackMelee(
      damage: 10,
      size: Vector2.all(tileSize * 1.5),
      interval: 800,
      execute: _addAttackAnimation,
    );
  }
}
