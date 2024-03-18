import 'package:homelyf_services/res/widgets/skeleton.dart';
import 'package:homelyf_services/utils/global_variables.dart';
import 'package:homelyf_services/utils/routes/routes_name.dart';
import 'package:homelyf_services/view/home/widgets/address_box.dart';
import 'package:homelyf_services/view/home/widgets/carousel_image.dart';
import 'package:homelyf_services/view/home/widgets/deal_of_day.dart';
import 'package:homelyf_services/view/home/widgets/top_categories.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, RoutesName.searchScreen, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(60),
      //   child: AppBar(
      //     flexibleSpace: Container(
      //       decoration: const BoxDecoration(
      //         gradient: GlobalVariables.appBarGradient,
      //       ),
      //     ),
      //     title: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Expanded(
      //           child: Container(
      //             height: 42,
      //             margin: const EdgeInsets.only(left: 15),
      //             child: Material(
      //               borderRadius: BorderRadius.circular(18),
      //               elevation: 1,
      //               child: TextFormField(
      //                 onFieldSubmitted: navigateToSearchScreen,
      //                 decoration: InputDecoration(
      //                   prefixIcon: InkWell(
      //                     onTap: () {},
      //                     child: const Padding(
      //                       padding: EdgeInsets.only(
      //                         left: 6,
      //                       ),
      //                       child: Icon(
      //                         Icons.search_rounded,
      //                         color: Colors.black,
      //                         size: 23,
      //                       ),
      //                     ),
      //                   ),
      //                   filled: true,
      //                   fillColor: Colors.white,
      //                   contentPadding: const EdgeInsets.only(top: 10),
      //                   border: const OutlineInputBorder(
      //                     borderRadius: BorderRadius.all(
      //                       Radius.circular(50),
      //                     ),
      //                     borderSide: BorderSide.none,
      //                   ),
      //                   enabledBorder: const OutlineInputBorder(
      //                     borderRadius: BorderRadius.all(
      //                       Radius.circular(50),
      //                     ),
      //                     borderSide: BorderSide(
      //                       color: Color.fromARGB(0, 255, 255, 255),
      //                       width: 1,
      //                     ),
      //                   ),
      //                   hintText: 'Search Services',
      //                   hintStyle: const TextStyle(
      //                     fontWeight: FontWeight.w500,
      //                     fontSize: 17,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         Container(
      //           color: Colors.transparent,
      //           height: 42,
      //           margin: const EdgeInsets.symmetric(horizontal: 10),
      //           child: const Icon(Icons.mic, color: Colors.black, size: 25),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const AddressBox(),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 1,
                          child: TextFormField(
                            onFieldSubmitted: navigateToSearchScreen,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.search_rounded,
                                  color: GlobalVariables.secondaryColor,
                                  size: 20,
                                ),
                              ),
                              filled: true,
                              fillColor: GlobalVariables.textFieldBackground,
                              contentPadding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                  color: GlobalVariables.textFieldBorder,
                                  width: 1,
                                ),
                              ),
                              hintText: 'Search Services',
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   color: Colors.transparent,
                    //   height: 42,
                    //   margin: const EdgeInsets.symmetric(horizontal: 10),
                    //   child:
                    //       const Icon(Icons.mic, color: Colors.black, size: 25),
                    // ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: _isLoading
              ? const NewsCardSkelton()
              : const Column(
                  children: [
                    // AddressBox(),
                    SizedBox(height: 10),
                    TopCategories(),
                    SizedBox(height: 10),
                    CarouselImage(),
                    DealOfDay(),
                  ],
                ),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: _isLoading
      //       ? const NewsCardSkelton()
      //       : const Column(
      //           children: [
      //             AddressBox(),
      //             SizedBox(height: 10),
      //             TopCategories(),
      //             SizedBox(height: 10),
      //             CarouselImage(),
      //             DealOfDay(),
      //           ],
      //         ),
      // ),
    );
  }
}

class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Skeleton(height: 30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: List.generate(
                5, // Adjust the number of skeletons you want to display
                (index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: CircleSkeleton(
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Skeleton(height: 200),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Skeleton(height: 30, width: 150),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Skeleton(height: 150, width: 150),
            ),
          ),
        ],
      ),
    );
  }
}
