import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'game_state.dart'; // your freezed state
import 'game_notifier.dart'; // your GameNotifier


@RoutePage()
class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Game Screen")),
      body: Center(
        child: gameState.when(
          loading: () => const CircularProgressIndicator(),
          ready: () => Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.sports_esports, size: 60, color: Colors.green),
              SizedBox(height: 16),
              Text(
                "Game is Ready!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          over: () => Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.flag, size: 60, color: Colors.red),
              SizedBox(height: 16),
              Text(
                "Game Over",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(gameProvider.notifier).fetchGameData(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
