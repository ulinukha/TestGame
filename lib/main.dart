import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '_index.dart';

double tileSize = 20.0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
  }
  await SpriteSheetPlayer.load();
  await SpriteSheetOrc.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Game(),
      // routes: {
      //   '/': (_) => const MenuPage(),
      //   '/game': (_) => const Game()
      // },
    );
  }
}
