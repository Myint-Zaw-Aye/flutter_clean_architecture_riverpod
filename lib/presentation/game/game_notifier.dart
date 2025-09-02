import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'game_state.dart';

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier(this.ref) : super(const GameState.loading()) {
    fetchGameData();
  }

  final Ref ref;

  Future<void> fetchGameData() async {
    state = const GameState.loading();
    await Future.delayed(const Duration(seconds: 2));
    state = const GameState.ready();
    await Future.delayed(const Duration(minutes: 5));
    state = const GameState.over();
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) => GameNotifier(ref));
