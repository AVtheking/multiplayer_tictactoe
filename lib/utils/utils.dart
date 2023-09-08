import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/resources/game_methods.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}

void showGameDialogBox(BuildContext context, String text, Ref ref) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                GameMethods(ref: ref).clearBoard(context);
              },
              child: const Text("Play Again"),
            ),
          ],
        );
      });
}
