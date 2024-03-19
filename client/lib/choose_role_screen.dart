import 'package:flutter/material.dart';
import 'package:homelyf_services/res/widgets/custom_button.dart';
import 'package:homelyf_services/utils/global_variables.dart';
import 'package:homelyf_services/view/auth/screens/signin_screen.dart';
import 'package:homelyf_services/view/partner/screens/signin_partner.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

class ChooseRoleScreen extends StatefulWidget {
  static const String routeName = "choose-role";
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              "Let's get started!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: GlobalVariables.titleColor,
              ),
            ),
            const Spacer(),
            const Text(
              "Become a happy customer",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: GlobalVariables.subTitleColor,
                height: 2,
              ),
            ),
            CustomButton(
              text: "Continue as a Customer",
              gradient: GlobalVariables.buttonGradient,
              elevation: 8,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignInScreen();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
            const Text(
              "Become an expert service provider",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: GlobalVariables.subTitleColor,
                height: 2,
              ),
            ),
            CustomButton(
              text: "Continue as a Partner",
              gradient: GlobalVariables.buttonGradient,
              elevation: 8,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignInPartner();
                    },
                  ),
                );
              },
            ),
            const Spacer(),
            Transform.translate(
              offset: const Offset(0, 40),
              child: Image.asset(
                'assets/images/toolbox.png', // Replace with your image path
                fit: BoxFit.cover,
                height: 180,
                alignment: Alignment.bottomCenter,
              ),
            )
          ],
        ),
      ),
    );
  }
}
