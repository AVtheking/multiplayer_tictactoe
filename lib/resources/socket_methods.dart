import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/resources/game_methods.dart';
import 'package:tictactoe/resources/socket_client.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/utils/utils.dart';

final socketMethodsProvider = Provider((ref) => SocketMethods(ref: ref));
final roomProvider = StateProvider<Map<String, dynamic>?>((ref) => null);
final player1Provider = StateProvider<Player?>((ref) => null);
final player2Provider = StateProvider<Player?>((ref) => null);
final displayElementProvider =
    StateProvider<List<String>>((ref) => ['', '', '', '', '', '', '', '', '']);

final filledBoxesProvider = StateProvider<int>((ref) => 0);

class SocketMethods {
  final Ref _ref;

  SocketMethods({required Ref ref}) : _ref = ref;
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;
  // Future<void> sendMessage(String message) async {
  //   await _socketClient.sink.add(message);
  // }

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit("createRoom", {
        {"nickname": nickname}
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit("joinRoom", {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElement) {
    if (displayElement[index] == '') {
      _socketClient.emit("tap", {'roomId': roomId, 'index': index});
    }
  }

  void createRoomSuccess(BuildContext context) {
    //for recieving data from the server we use 'on' method
    _socketClient.on("createRoomSuccess", (room) {
      // print(room);
      _ref.read(roomProvider.notifier).update((state) => room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccess(BuildContext context) {
    _socketClient.on("joinRoomSuccess", (room) {
      _ref.read(roomProvider.notifier).update((state) => room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorListener(BuildContext context) {
    _socketClient.on("error", (data) => showSnackBar(context, data));
  }

  void updatePlayerListener(BuildContext context) {
    _socketClient.on("updatePlayers", (playerData) {
      _ref
          .read(player1Provider.notifier)
          .update((state) => Player.fromMap(playerData[0]));
      _ref
          .read(player2Provider.notifier)
          .update((state) => Player.fromMap(playerData[1]));
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on("updateRoom", (room) {
      // print(room.toString());
      _ref.read(roomProvider.notifier).update((state) => room);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on("tapped", (data) {
      final displayElement = _ref.read(displayElementProvider);
      displayElement[data['index']] = data['choice'];
      _ref
          .read(displayElementProvider.notifier)
          .update((state) => displayElement);
      _ref.read(filledBoxesProvider.notifier).state++;
      _ref.read(roomProvider.notifier).update((state) => data['room']);
      _ref.watch(gameMethodsProvider).checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListner(BuildContext context) {
    _socketClient.on("pointIncrease", (data) {
      final player1 = _ref.read(player1Provider)!;
      final player2 = _ref.read(player2Provider)!;
      if (data['socketId'] == player1.socketId) {
        _ref
            .read(player1Provider.notifier)
            .update((state) => Player.fromMap(data));
      } else {
        _ref
            .read(player2Provider.notifier)
            .update((state) => Player.fromMap(data));
      }
    });
  }

  void endgameListner(BuildContext context) {
    _socketClient.on("endgame", (playerData) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("${playerData['nickname']} won the game!"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => false);
                    },
                    child: const Text("ok"))
              ],
            );
          });
    });
  }
}
