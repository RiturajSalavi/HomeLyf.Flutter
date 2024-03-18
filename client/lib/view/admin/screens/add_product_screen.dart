import 'dart:io';

import 'package:homelyf_services/res/widgets/custom_button.dart';
import 'package:homelyf_services/res/widgets/custom_textfield.dart';
import 'package:homelyf_services/utils/global_variables.dart';
import 'package:homelyf_services/view/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  bool _showImageError = false;
  String category = 'Cleaning';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Cleaning',
    'Plumbing',
    'Electrician',
    'Gardening',
    'Carpentry'
  ];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        images: images,
      );
    }
  }

  void selectImages() async {
    List<XFile> pickedImages = [];
    final picker = ImagePicker();
    try {
      pickedImages = await picker.pickMultiImage(); // Pick multiple images
    } catch (e) {
      print(e); // Handle any potential exceptions
    }

    if (!mounted) return;

    setState(() {
      images = pickedImages.map((XFile image) => File(image.path)).toList();
      if (images.isNotEmpty) {
        _showImageError = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? (kIsWeb
                        ? SizedBox(
                            height: 200,
                            child: PageView.builder(
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                return Image.network(images[index].path);
                              },
                            ),
                          )
                        : CarouselSlider(
                            items: images.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200,
                            ),
                          ))
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                Visibility(
                  visible: _showImageError,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 8.0),
                    child: Text(
                      'Please select at least one image.',
                      style: TextStyle(
                        color: Color.fromARGB(
                            255, 180, 4, 36), // Change color as needed
                        fontSize: 12.0, // Adjust font size as needed
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: productNameController,
                  hintText: 'Enter Product Name',
                  labelText: 'Product Name',
                  customValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Product Name';
                    }
                    String namePattern = r'^[a-zA-Z0-9\ ]{1,30}$';
                    RegExp regExp = RegExp(namePattern);

                    if (!regExp.hasMatch(value)) {
                      return 'Please enter a valid product name, only letters(a-z, A-Z) and numbers are allowed.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: descriptionController,
                  hintText: 'Enter Description',
                  labelText: 'Description',
                  maxLines: 7,
                  customValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Product Description';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: priceController,
                  hintText: 'Enter Price',
                  labelText: 'Price',
                  customValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Price';
                    }
                    String namePattern = r'^\d{1,10}(\.\d{1,2})?$';
                    RegExp regExp = RegExp(namePattern);

                    if (!regExp.hasMatch(value)) {
                      return 'Please enter a valid price.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: quantityController,
                  hintText: 'Enter Quantity',
                  labelText: 'Quantity',
                  customValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Quantity';
                    }
                    String namePattern = r'^\d{1,5}$';
                    RegExp regExp = RegExp(namePattern);

                    if (!regExp.hasMatch(value)) {
                      return 'Please enter a valid quantity.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style:
                              const TextStyle(color: GlobalVariables.textColor),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Sell',
                  onTap: () {
                    if (images.isEmpty) {
                      setState(() {
                        _showImageError = true;
                      });
                    }
                    if (_addProductFormKey.currentState!.validate()) {
                      sellProduct();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
