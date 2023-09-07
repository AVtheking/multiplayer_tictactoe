import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/resources/socket_client.dart';

final socketMethodsProvider = Provider((ref) => SocketMethods());

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
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
}
