import 'dart:async';
import 'dart:io';

import 'package:c_product_flutter/local/AppDatabase.dart';
import 'package:c_product_flutter/models/Adding/request.dart';
import 'package:c_product_flutter/screens/adding-product/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';

import 'adding-buttons.dart';
import 'cubit/states.dart';

class AddingBody extends StatefulWidget {
  AddingBody({
    Key? key,
    required this.barCodeController,
    required this.priceController,
    required this.countController,
    required this.cubit,
    required this.state,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController barCodeController;
  final TextEditingController priceController;
  final TextEditingController countController;
  final ProductAddingCubit cubit;
  final ProductAddingStates state;
  final GlobalKey<FormState> formKey;

  @override
  State<AddingBody> createState() => _AddingBodyState();
}

class _AddingBodyState extends State<AddingBody> {
  String textString = 'Adding Products';
  ConnectivityResult myResult = ConnectivityResult.none;
  late StreamSubscription mySubscription;
  bool isConnected = false;
  List<AddingRequest> myProductsList = <AddingRequest>[];

  void CheckMyNetworkConnection() async {
    /** get the current state of network */
    // myResult = await Connectivity().checkConnectivity();

    /** get the state of network when it's changed */
    mySubscription =
        Connectivity().onConnectivityChanged.listen((result) async {
      myResult = result;

      if (myResult == ConnectivityResult.wifi ||
          myResult == ConnectivityResult.mobile) {
        isConnected = true;
        print('Connected');
        localNotification("Connected", Colors.green);
        await getAllProductsFromDB();
        print('length ${myProductsList.length}');
        if (myProductsList.length > 0) {
          /** insert the first item from db*/
          addProductToDatabase(
            myProductsList[0].barcodeID,
            myProductsList[0].price,
            myProductsList[0].count,
          );

          deleteAllProductsFromDB();

        }
      } else {
        isConnected = false;
        print('ya 3am leeeeh ${myResult}');
        localNotification("No connection", Colors.red);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print('it\'s allowed');
    CheckMyNetworkConnection();
  }

  @override
  void dispose() {
    mySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textString,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  controller: widget.barCodeController,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                  onChanged: (String value) {
                    print(value);
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'please enter value';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'barcodeID',
                    prefixIcon: Icon(
                      Icons.format_list_numbered_rounded,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: widget.priceController,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (String value) {
                    print(int.parse(value) + 4);
                  },
                  onChanged: (String value) {
                    print(value);
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'please enter value';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'price',
                    prefixIcon: Icon(
                      Icons.attach_money,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: widget.countController,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'please enter value';
                    }
                  },
                  onChanged: (String value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'count',
                    prefixIcon: Icon(
                      Icons.qr_code_rounded,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                // Center(
                //     child: AddingButtons(
                //         cubit: cubit,
                //         color: Colors.deepOrange.shade500,
                //         text: 'Add Product',
                //         onPress: () async {
                //           cubit.cubitAddProduct(
                //             barcodeId: int.parse(barCodeController.text),
                //             price: int.parse(priceController.text),
                //             count: int.parse(countController.text),
                //           );
                //           if (state is ProductAddingSuccessState) {
                //             textString = 'Successful';
                //             barCodeController.text = '';
                //             priceController.text = '';
                //             countController.text = '';
                //           }
                //
                //           AddingRequest addRM =
                //               AddingRequest(barcodeID: 1, price: 10, count: 20);
                //
                //           final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
                //
                //           final productDao = database.personDao;
                //
                //           await productDao.insertProduct(addRM);
                //           // final result = await productDao.findPersonById(1);
                //
                //         })),
                /** Create Add Products */
                Center(
                  child: ConditionalBuilder(
                    condition: widget.state is! ProductAddingLoadingState,
                    builder: (context) => AddingButtons(
                        cubit: widget.cubit,
                        color: Colors.deepOrange.shade500,
                        text: 'Add Product To Server or DB ',
                        onPress: () async {
                          int c = int.parse(widget.barCodeController.text) + 3;
                          print(
                              'isConnected $isConnected ${widget.barCodeController.text} +1');

                          if (widget.formKey.currentState!.validate()) {
                            print('isConnected $isConnected');
                            if (isConnected) {
                              addProductToServer();
                            } else {
                              addProductToDatabase(
                                  int.parse(widget.barCodeController.text),
                                  int.parse(widget.priceController.text),
                                  int.parse(widget.countController.text));
                            }
                          }
                        }),
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                /** Read Get Floor Products */
                Center(
                  child: ConditionalBuilder(
                    condition: widget.state is! ProductAddingLoadingState,
                    builder: (context) => AddingButtons(
                        cubit: widget.cubit,
                        color: Colors.red.shade500,
                        text: 'Get Floor Products',
                        onPress: () async {
                          await getAllProductsFromDB();
                        }),
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                /** Delete Floor Products */
                Center(
                  child: ConditionalBuilder(
                    condition: widget.state is! ProductAddingLoadingState,
                    builder: (context) => AddingButtons(
                        cubit: widget.cubit,
                        color: Colors.grey.shade600,
                        text: 'Delete Floor Products',
                        onPress: () async {
                          deleteAllProductsFromDB();
                        }),
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                /** Upload Image*/
                Center(
                  child: ConditionalBuilder(
                    condition:
                        widget.state is! ProductAddingUploadImLoadingState,
                    builder: (context) => AddingButtons(
                      color: Colors.deepPurpleAccent.shade700,
                      cubit: widget.cubit,
                      text: 'Upload Image',
                      onPress: () async {
                        File image;
                        final ImagePicker _picker = ImagePicker();
                        var imagePicker = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (imagePicker != null) {
                          image = File(imagePicker.path);
                          widget.cubit.cubitUploadImage(image);
                        }
                      },
                    ),
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addProductToServer() {
    widget.cubit.cubitAddProduct(
      barcodeId: int.parse(widget.barCodeController.text),
      price: int.parse(widget.priceController.text),
      count: int.parse(widget.countController.text),
    );

    if (widget.state is ProductAddingSuccessState) {
      textString = 'Successful';
      widget.barCodeController.text = '';
      widget.priceController.text = '';
      widget.countController.text = '';
    }
  }

  void addProductToDatabase(int? barCode, int? price, int? count) async {
    /** adding in database */
    AddingRequest addRM = AddingRequest(
      barcodeID: barCode,
      price: price,
      count: count,
    );

    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final productDao = database.personDao;

    await productDao.insertProduct(addRM);

    widget.barCodeController.text = '';
    widget.priceController.text = '';
    widget.countController.text = '';

    barCode = price = count = null;
    localNotification('Added To Database',Colors.grey);
  }

  void deleteAllProductsFromDB() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final productDao = database.personDao;

    await productDao.deleteAllProducts();

    print('deleted products');
    localNotification('Deleted From Database',Colors.grey);
  }

  Future<void> getAllProductsFromDB() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final productDao = database.personDao;
    myProductsList = await productDao.findAllProducts();

    print('all ${myProductsList.length}');

    // localNotification('Getting From Database',Colors.grey);
  }

  void localNotification(String text, Color color) {
    showSimpleNotification(
      Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      background: color,
    );
  }
}
