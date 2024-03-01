import 'package:homelyf_services/common/widgets/loader.dart';
import 'package:homelyf_services/features/home/services/home_services.dart';
import 'package:homelyf_services/features/product_details/screens/product_details_screen.dart';
import 'package:homelyf_services/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  @override
  void dispose() {
    // Cancel any ongoing processes (e.g., timers, animations) and clean up resources.
    isDisposed = true;
    super.dispose();
  }

  void fetchDealOfDay() async {
    try {
      if (!isDisposed) {
        product = await homeServices.fetchDealOfDay(context: context);
        if (!isDisposed) {
          // Check if the widget is still mounted before calling setState
          setState(() {});
        }
      }
    } catch (e) {
      // Handle errors appropriately
    }
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        product!.images[0],
                        height: 200,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        '\$100',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: const Text(
                        'Rivaan',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map(
                              (e) => ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  e,
                                  fit: BoxFit.cover,
                                  height: 100,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
