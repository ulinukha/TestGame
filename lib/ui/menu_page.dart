import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:test_game/utils/_index.dart';

import '../sprite_sheet/_index.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Widget player = SpriteSheetPlayer.idleTopRight.asWidget();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 20);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Fantasy',
              style: textStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ).marginOnly(bottom: 40),
            player.marginOnly(bottom: 40),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed('/game'),
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.all(const EdgeInsets.all(20)),
                overlayColor: MaterialStateProperty.all(
                  Colors.white.withOpacity(0.2),
                ),
                side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.white),
                ),
              ),
              child: Text(
                'Start Game',
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
