import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {
  static const String routeName = '/services-screen';

  const ServicesScreen({super.key});
  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modal Bottom Sheet Example'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open Bottom Sheet'),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 300,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Transform.translate(
                            offset: const Offset(-10, -50),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 18,
                                child: IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.black, size: 20),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Add your widgets here
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
