import 'package:homelyf_services/choose_role_screen.dart';
import 'package:homelyf_services/common/widgets/bottom_bar.dart';
import 'package:homelyf_services/features/address/screens/address_screen.dart';
import 'package:homelyf_services/features/admin/screens/add_product_screen.dart';
import 'package:homelyf_services/features/admin/screens/admin_screen.dart';
import 'package:homelyf_services/features/auth/screens/auth_screen.dart';
import 'package:homelyf_services/features/auth/screens/forgot_password_screen.dart';
import 'package:homelyf_services/features/auth/screens/signin_screen.dart';
import 'package:homelyf_services/features/auth/screens/signup_screen.dart';
import 'package:homelyf_services/features/home/screens/category_deals_screen.dart';
import 'package:homelyf_services/features/home/screens/home_screen.dart';
import 'package:homelyf_services/features/order_details/screens/order_details.dart';
import 'package:homelyf_services/features/partner/screens/forgot_password_partner.dart';
import 'package:homelyf_services/features/partner/screens/partner_screen.dart';
import 'package:homelyf_services/features/partner/screens/signin_partner.dart';
import 'package:homelyf_services/features/partner/screens/signup_partner.dart';
import 'package:homelyf_services/features/product_details/screens/product_details_screen.dart';
import 'package:homelyf_services/features/search/screens/search_screen.dart';
import 'package:homelyf_services/models/order.dart';
import 'package:homelyf_services/models/product.dart';
import 'package:flutter/material.dart';
import 'package:homelyf_services/services_screen.dart';
import 'package:homelyf_services/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case SplashScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SplashScreen(),
      );

    case ChooseRoleScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ChooseRoleScreen(),
      );

    case SignInScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignInScreen(),
      );

    case SignInPartner.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignInPartner(),
      );

    case SignUpScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpScreen(),
      );

    case SignUpPartner.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpPartner(),
      );

    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );

    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ForgotPasswordScreen(),
      );

    case ForgotPasswordPartner.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ForgotPasswordPartner(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case PartnerScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PartnerScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );

    case ServicesScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ServicesScreen(),
      );

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String?;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category ?? "",
        ),
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );

    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );

    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );

    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
