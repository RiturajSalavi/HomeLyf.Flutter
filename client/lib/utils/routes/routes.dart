import 'package:flutter/material.dart';
import 'package:homelyf_services/choose_role_screen.dart';
import 'package:homelyf_services/models/order.dart';
import 'package:homelyf_services/models/product.dart';
import 'package:homelyf_services/res/widgets/bottom_bar.dart';
import 'package:homelyf_services/services_screen.dart';
import 'package:homelyf_services/splash_screen.dart';
import 'package:homelyf_services/utils/routes/routes_name.dart';
import 'package:homelyf_services/view/address/screens/address_screen.dart';
import 'package:homelyf_services/view/admin/screens/add_product_screen.dart';
import 'package:homelyf_services/view/admin/screens/admin_screen.dart';
import 'package:homelyf_services/view/auth/screens/forgot_password_screen.dart';
import 'package:homelyf_services/view/auth/screens/signin_screen.dart';
import 'package:homelyf_services/view/auth/screens/signup_screen.dart';
import 'package:homelyf_services/view/home/screens/category_deals_screen.dart';
import 'package:homelyf_services/view/home/screens/home_screen.dart';
import 'package:homelyf_services/view/order_details/screens/order_details.dart';
import 'package:homelyf_services/view/partner/screens/forgot_password_partner.dart';
import 'package:homelyf_services/view/partner/screens/partner_screen.dart';
import 'package:homelyf_services/view/partner/screens/signin_partner.dart';
import 'package:homelyf_services/view/partner/screens/signup_partner.dart';
import 'package:homelyf_services/view/product_details/screens/product_details_screen.dart';
import 'package:homelyf_services/view/search/screens/search_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesName.chooseRoleScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ChooseRoleScreen());

      case RoutesName.signin:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignInScreen());

      case RoutesName.signinPartner:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignInPartner());

      case RoutesName.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());

      case RoutesName.signupPartner:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpPartner());

      case RoutesName.adminScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AdminScreen());

      case RoutesName.forgotPassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgotPasswordScreen());

      case RoutesName.forgotPasswordPartner:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgotPasswordPartner());

      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesName.partnerScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PartnerScreen());

      case RoutesName.bootomBar:
        return MaterialPageRoute(
            builder: (BuildContext context) => const BottomBar());

      case RoutesName.servicesScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => ServicesScreen());

      case RoutesName.addProduct:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddProductScreen());

      case RoutesName.categoryDeals:
        var category = settings.arguments as String?;
        return MaterialPageRoute(
            builder: (BuildContext context) => CategoryDealsScreen(
                  category: category ?? "",
                ));

      case RoutesName.searchScreen:
        var searchQuery = settings.arguments as String;
        return MaterialPageRoute(
            builder: (BuildContext context) => SearchScreen(
                  searchQuery: searchQuery,
                ));

      case RoutesName.productDetails:
        var product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (BuildContext context) => ProductDetailScreen(
            product: product,
          ),
        );

      case RoutesName.address:
        var totalAmount = settings.arguments as String;
        return MaterialPageRoute(
          builder: (BuildContext context) => AddressScreen(
            totalAmount: totalAmount,
          ),
        );

      case RoutesName.orderDetails:
        var order = settings.arguments as Order;
        return MaterialPageRoute(
          builder: (BuildContext context) => OrderDetailScreen(
            order: order,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No route defined.'),
              ),
            );
          },
        );
    }
  }
}
