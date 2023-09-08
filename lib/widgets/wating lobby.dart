import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/widgets/custom_text.dart';
import 'package:tictactoe/widgets/custom_text_field.dart';

class WatingLobby extends ConsumerStatefulWidget {
  const WatingLobby({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WatingLobbyState();
}

class _WatingLobbyState extends ConsumerState<WatingLobby> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController(text: ref.read(roomProvider)!['_id']);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomText(
            text: "Wating for a player to join",
            fontSize: 19,
            shadows: [
              Shadow(
                color: Colors.blue,
                blurRadius: 5,
              ),
            ]),
        const SizedBox(
          height: 30,
        ),
        CustomTextField(
          namecontroller: controller,
          hintText: '',
          isReadOnly: true,
        )
      ],
    );
  }
}
