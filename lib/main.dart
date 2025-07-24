import 'package:flutter/material.dart';
import 'core/game/dress_up_game.dart';
import 'presentation/widgets/game_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dress Up Game',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        useMaterial3: true,
      ),
      home: const GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late DressUpGame game;

  @override
  void initState() {
    super.initState();
    game = DressUpGame();
  }

  @override
  Widget build(BuildContext context) {
    return DressUpGameWidget(game: game);
  }
}
