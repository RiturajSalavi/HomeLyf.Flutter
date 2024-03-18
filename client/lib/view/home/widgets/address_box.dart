import 'package:homelyf_services/res/app_colors.dart';
import 'package:homelyf_services/utils/routes/routes_name.dart';
import 'package:homelyf_services/view_model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    // return Container(
    //   height: 40,
    //   decoration: const BoxDecoration(
    //     gradient: LinearGradient(
    //       colors: [
    //         Color.fromARGB(255, 213, 222, 239),
    //         Color.fromARGB(255, 213, 222, 239),
    //       ],
    //       stops: [0.5, 1.0],
    //     ),
    //   ),
    //   padding: const EdgeInsets.only(left: 10),
    //   child: Row(
    //     children: [
    //       const Icon(
    //         Icons.location_on_outlined,
    //         size: 20,
    //       ),
    //       Expanded(
    //         child: Padding(
    //           padding: const EdgeInsets.only(left: 5),
    //           child: Text(
    //             'Delivery to ${user.name} - ${user.address}',
    //             style: const TextStyle(
    //               fontWeight: FontWeight.w500,
    //             ),
    //             overflow: TextOverflow.ellipsis,
    //           ),
    //         ),
    //       ),
    //       const Padding(
    //         padding: EdgeInsets.only(
    //           left: 5,
    //           top: 2,
    //         ),
    //         child: Icon(
    //           Icons.arrow_drop_down_outlined,
    //           size: 18,
    //         ),
    //       )
    //     ],
    //   ),
    // );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left side with two lines of text
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutesName.address,
                  arguments: '20',
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'My Home',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w800,
                              color: AppColors.titleColor),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                            top: 2,
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 18,
                            color: AppColors.textColor,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Text(
                        'Delivery to ${user.name} - ${user.address}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ClipOval(
              child: Image.network(
                'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg?auto=compress&cs=tinysrgb&w=600', // Replace with your image URL
                width: 50, // Adjust size as needed
                height: 100, // Adjust size as needed
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
