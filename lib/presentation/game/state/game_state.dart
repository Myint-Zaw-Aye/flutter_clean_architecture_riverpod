import 'package:freezed_annotation/freezed_annotation.dart';
part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState.loading() = _Loading;
  const factory GameState.ready() = _Ready;
  const factory GameState.over() = _Over;
}
