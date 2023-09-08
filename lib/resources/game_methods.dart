import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/utils/utils.dart';

final gameMethodsProvider = Provider((ref) => GameMethods(ref: ref));

class GameMethods {
  final Ref _ref;
  GameMethods({required Ref ref}) : _ref = ref;
  void checkWinner(BuildContext context, Socket socketClient) {
    final displayElements = _ref.read(displayElementProvider);
    final player1 = _ref.read(player1Provider)!;
    final player2 = _ref.read(player2Provider)!;
    final room = _ref.read(roomProvider)!;
    final filledBoxes = _ref.read(filledBoxesProvider);
    String winner = '';
    //checking rows
    if (displayElements[0] == displayElements[1] &&
        displayElements[0] == displayElements[2] &&
        displayElements[0] != '') {
      winner = displayElements[0];
    }
    if (displayElements[3] == displayElements[4] &&
        displayElements[3] == displayElements[5] &&
        displayElements[3] != '') {
      winner = displayElements[3];
    }
    if (displayElements[6] == displayElements[7] &&
        displayElements[6] == displayElements[8] &&
        displayElements[6] != '') {
      winner = displayElements[6];
    }
    //checking column
    if (displayElements[0] == displayElements[3] &&
        displayElements[0] == displayElements[6] &&
        displayElements[0] != '') {
      winner = displayElements[0];
    }
    if (displayElements[1] == displayElements[4] &&
        displayElements[1] == displayElements[7] &&
        displayElements[1] != '') {
      winner = displayElements[1];
    }
    if (displayElements[2] == displayElements[5] &&
        displayElements[2] == displayElements[8] &&
        displayElements[2] != '') {
      winner = displayElements[2];
    }
    //check Diagonal
    if (displayElements[0] == displayElements[4] &&
        displayElements[0] == displayElements[8] &&
        displayElements[0] != '') {
      winner = displayElements[0];
    }
    if (displayElements[2] == displayElements[4] &&
        displayElements[2] == displayElements[6] &&
        displayElements[2] != '') {
      winner = displayElements[2];
    } else if (filledBoxes == 9) {
      winner = '';
      showGameDialogBox(context, "Draw", _ref);
    }
    if (winner != '') {
      if (winner == player1.playertype) {
        showGameDialogBox(context, "${player1.nickname} won!", _ref);
        socketClient.emit(
          "winner",
          {
            'winnerSocketId': player1.socketId,
            'roomId': room['_id'],
          },
        );
        SocketMethods(ref: _ref).pointIncreaseListner(context);
      } else {
        showGameDialogBox(context, "${player2.nickname} won!", _ref);
        socketClient.emit(
          "winner",
          {
            'winnerSocketId': player2.socketId,
            'roomId': room['_id'],
          },
        );
        SocketMethods(ref: _ref).pointIncreaseListner(context);
      }
    }
  }

  void clearBoard(BuildContext context) {
    var displayElements = _ref.read(displayElementProvider);
    displayElements = ['', '', '', '', '', '', '', '', ''];
    _ref
        .read(displayElementProvider.notifier)
        .update((state) => displayElements);
    _ref.read(filledBoxesProvider.notifier).state = 0;
    // print(_ref.read(filledBoxesProvider));
  }
}
