import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_game/components/human_player.dart';
import 'package:test_game/components/light.dart';
import 'package:test_game/components/orc.dart';
import 'package:test_game/main.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double maxSize = max(size.width, size.height);
    return LayoutBuilder(builder: (context, constraints) {
      return Material(
        color: Colors.transparent,
        child: BonfireWidget(
          joystick: Joystick(
            keyboardConfig: KeyboardConfig(
              acceptedKeys: [
                LogicalKeyboardKey.space,
              ],
            ),
            directional: JoystickDirectional(),
            actions: [
              JoystickAction(
                actionId: 1,
                margin: const EdgeInsets.all(65),
              )
            ],
          ),
          player: HumanPlayer(Vector2(4 * tileSize, 4 * tileSize)),
          cameraConfig: CameraConfig(zoom: maxSize / (tileSize * 20)),
          map: WorldMapByTiled(
            'tile/map.json',
            forceTileSize: Vector2.all(tileSize),
            objectsBuilder: {
              'light': (properties) => Light(
                    properties.position,
                    properties.size,
                  ),
              'orc': (properties) => Orc(properties.position),
            },
          ),
          lightingColorGame: Colors.black.withOpacity(0.7),
          progress: Container(
            color: Colors.black,
            child: const Center(
              child: Text(
                'Loading...',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      );
    });
  }
}
