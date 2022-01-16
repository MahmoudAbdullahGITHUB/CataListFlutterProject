import 'dart:io';

import 'package:c_product_flutter/screens/adding-product/cubit/cubit.dart';
import 'package:c_product_flutter/screens/adding-product/cubit/states.dart';
import 'package:c_product_flutter/screens/adding-product/adding_body.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';

class AddingProduct extends StatefulWidget {
  static const routName = '/adding_product-screen';

  AddingProduct({Key? key}) : super(key: key);

  @override
  State<AddingProduct> createState() => _AddingProductState();
}

class _AddingProductState extends State<AddingProduct> {
  var barCodeController = TextEditingController();
  var priceController = TextEditingController();
  var countController = TextEditingController();
  var imageController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        home: BlocProvider(
          create: (BuildContext context) => ProductAddingCubit(),
          child: BlocConsumer<ProductAddingCubit, ProductAddingStates>(
              listener: (context, state) {
                // if (state is ProductAddingNetworkSuccessState) {
                //   print('yes ');
                //   showSimpleNotification(Text("this is a message from simple notification"),
                //       background: Colors.green);
                // } else if (state is ProductAddingNetworkFailedState) {
                //   print('so why ');
                //   showSimpleNotification(Text("this is a message from simple notification"),
                //       background: Colors.red);
                // }
              },
              builder: (context, state) {
                ProductAddingCubit cubit = ProductAddingCubit.get(context);
                return Scaffold(
                  appBar: AppBar(),
                  body: AddingBody(
                    barCodeController: barCodeController,
                    priceController: priceController,
                    countController: countController,
                    cubit: cubit,
                    state: state,
                    formKey: formKey,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
