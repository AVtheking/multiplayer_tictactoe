import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/widgets/score_column.dart';

class ScoreBoard extends ConsumerWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player1 = ref.watch(player1Provider)!;
    final player2 = ref.watch(player2Provider)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: ScoreColumn(
              name: player1.nickname, points: player1.points.toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: ScoreColumn(
              name: player2.nickname, points: player2.points.toString()),
        ),
      ],
    );
  }
}
