import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/responsive/responsive.dart';
import 'package:tictactoe/widgets/custom_button.dart';
import 'package:tictactoe/widgets/custom_text.dart';
import 'package:tictactoe/widgets/custom_text_field.dart';

class CreateRoomScreen extends ConsumerStatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  ConsumerState<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends ConsumerState<CreateRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void createRoom(String nickname) {
    ref.watch(socketMethodsProvider).createRoom(nickname);
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              text: "Create Room",
              fontSize: 70,
              shadows: [
                Shadow(
                  color: Colors.blue,
                  blurRadius: 40,
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Material(
              child: CustomTextField(
                  namecontroller: _controller, hintText: "Enter your Nickname"),
            ),
            const SizedBox(
              height: 35,
            ),
            CustomButton(
                onTap: () {
                  createRoom(_controller.text);
                },
                text: "Create")
          ],
        ),
      ),
    );
  }
}
