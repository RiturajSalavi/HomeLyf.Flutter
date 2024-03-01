import 'package:flutter/material.dart';
import 'package:homelyf_services/common/widgets/custom_button.dart';
import 'package:homelyf_services/features/account/services/account_services.dart';
import 'package:homelyf_services/providers/partner_provider.dart';
import 'package:provider/provider.dart';

class PartnerScreen extends StatefulWidget {
  static const String routeName = '/partner-screen';
  const PartnerScreen({super.key});

  @override
  State<PartnerScreen> createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  @override
  Widget build(BuildContext context) {
    final partner = Provider.of<PartnerProvider>(context).partner;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text(partner.toJson()),
          CustomButton(
            text: 'Log Out',
            onTap: () => AccountServices().logOut(context),
            height: 30,
          ),
        ],
      ),
    );
  }
}
