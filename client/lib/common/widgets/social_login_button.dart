import 'package:flutter/material.dart';

class DualActionButton extends StatelessWidget {
  final VoidCallback onFirstAction;
  final VoidCallback onSecondAction;

  DualActionButton({required this.onFirstAction, required this.onSecondAction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          // Get the click position
          double buttonWidth = MediaQuery.of(context).size.width / 2;
          if (details.localPosition.dx < buttonWidth) {
            // Left part clicked
            onFirstAction();
          } else {
            // Right part clicked
            onSecondAction();
          }
        },
        child: Container(
          width: double.infinity,
          height: 50.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
            ),
          ),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Left Part',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 16.0),
                Text(
                  'Right Part',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
