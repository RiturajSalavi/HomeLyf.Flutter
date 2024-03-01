// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:homelyf_services/choose_role_screen.dart';
import 'package:homelyf_services/common/widgets/bottom_bar.dart';
import 'package:homelyf_services/common/widgets/liquid_loader.dart';
import 'package:homelyf_services/constants/global_variables.dart';
import 'package:homelyf_services/features/admin/screens/admin_screen.dart';
import 'package:homelyf_services/features/auth/services/auth_service.dart';
import 'package:homelyf_services/features/partner/screens/partner_screen.dart';

import 'package:homelyf_services/features/partner/services/partner_auth_service.dart';
import 'package:homelyf_services/providers/partner_provider.dart';
import 'package:homelyf_services/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash-screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService authService = AuthService();
  final PartnerAuthService partnerAuthService = PartnerAuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
    partnerAuthService.getPartnerData(context);
    _naviagtetohome();
  }

  _naviagtetohome() async {
    await Future.delayed(const Duration(milliseconds: 100), () {});
    await Future.wait([
      partnerAuthService.getPartnerData(context),
      authService.getUserData(context),
    ]);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return FutureBuilder(
            future: partnerAuthService.getPartnerData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (Provider.of<PartnerProvider>(context)
                    .partner
                    .token
                    .isNotEmpty) {
                  return const PartnerScreen();
                } else if (Provider.of<UserProvider>(context)
                    .user
                    .token
                    .isNotEmpty) {
                  return Provider.of<UserProvider>(context).user.type == 'user'
                      ? const BottomBar()
                      : const AdminScreen();
                } else {
                  return const ChooseRoleScreen();
                }
              } else {
                return const LiquidLoader();
              }
            },
          );
        },
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // Image.asset(
          //   'assets/images/top_roller.png', // Replace with your image path
          //   fit: BoxFit.fill,
          //   height: 70,
          //   width: MediaQuery.of(context).size.width,
          //   alignment: Alignment.topLeft,
          // ),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          Center(
            child: Image.asset(
              'assets/images/logo2.png', // Replace with your image path
              fit: BoxFit.cover,
              height: 120,
            ),
          ),

          const Align(
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text(
                  "Homelyf\nServices",
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    color: GlobalVariables.titleColor,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: const Color.fromARGB(255, 73, 104, 141),
            height: 3,
            width: 100,
          ),
          const SizedBox(
            height: 12,
          ),
          const Align(
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text(
                  "Where Comfort\nMeets Convenience!",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: GlobalVariables.titleColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const Spacer(),
          Transform.translate(
            offset: const Offset(0, 40),
            child: Image.asset(
              'assets/images/toolbox.png',
              fit: BoxFit.cover,
              height: 200,
              alignment: Alignment.bottomCenter,
            ),
          )
        ],
      ),
    );
  }
}
