import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/widgets/score_board.dart';
import 'package:tictactoe/widgets/tic_tac_toe_board.dart';
import 'package:tictactoe/widgets/wating%20lobby.dart';

class GameScreen extends ConsumerStatefulWidget {
  static String routeName = "/game";
  const GameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void initState() {
    ref.read(socketMethodsProvider).updateRoomListener(context);
    ref.read(socketMethodsProvider).updatePlayerListener(context);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final player1 = ref.watch(player1Provider);
    // final player2 = ref.watch(player2Provider);
    // print(player1!.nickname);
    // print(player2!.nickname);
    final roomData = ref.watch(roomProvider)!;
    return Scaffold(
      body: roomData['isJoin']
          ? const WatingLobby()
          : const SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [ScoreBoard(), TicTacToeBoard()],
              ),
            ),
    );
  }
}
