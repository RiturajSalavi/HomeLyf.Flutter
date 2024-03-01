import 'package:flutter/material.dart';
import 'package:homelyf_services/models/partner.dart';

class PartnerProvider extends ChangeNotifier {
  Partner _partner = Partner(
    id: '',
    name: '',
    email: '',
    mobile: '',
    otp: '',
    aadharCard: '',
    address: '',
    experience: '',
    password: '',
    type: '',
    token: '',
    serviceCategory: [],
  );

  Partner get partner => _partner;

  void setPartner(String partner) {
    _partner = Partner.fromJson(partner);
    notifyListeners();
  }

  void setPartnerFromModel(Partner partner) {
    _partner = partner;
    notifyListeners();
  }
}
