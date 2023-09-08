import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/resources/socket_methods.dart';

class TicTacToeBoard extends ConsumerStatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  ConsumerState<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends ConsumerState<TicTacToeBoard> {
  void tap(int index) {
    final room = ref.watch(roomProvider)!;
    final displayElement = ref.watch(displayElementProvider);
    ref
        .watch(socketMethodsProvider)
        .tapGrid(index, room['_id'], displayElement);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height * 0.7, maxWidth: 500),
      child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () => tap(index),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.white24,
                )),
                child: const Center(
                  child: Text(
                    'X',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                      shadows: [
                        Shadow(color: Colors.blue, blurRadius: 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }
}
