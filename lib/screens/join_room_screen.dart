import 'package:flutter/material.dart';
import 'package:tictactoe/widgets/custom_button.dart';
import 'package:tictactoe/widgets/custom_text.dart';
import 'package:tictactoe/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomText(
            text: "Join Room",
            fontSize: 70,
            shadows: [
              Shadow(blurRadius: 40, color: Colors.blue),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Material(
            child: CustomTextField(
                namecontroller: namecontroller,
                hintText: "Enter your nickname"),
          ),
          const SizedBox(
            height: 35,
          ),
          Material(
            child: CustomTextField(
                namecontroller: namecontroller,
                hintText: "Enter your nickname"),
          ),
          const SizedBox(
            height: 35,
          ),
          CustomButton(onTap: () {}, text: "Create")
        ],
      ),
    );
  }
}
