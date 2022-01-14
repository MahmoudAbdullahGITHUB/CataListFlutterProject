import 'dart:io';

import 'package:c_product_flutter/screens/adding-product/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'adding-buttons.dart';
import 'cubit/states.dart';

class AddingBody extends StatelessWidget {
   AddingBody({
    Key? key,
    required this.barCodeController,
    required this.priceController,
    required this.countController,
    required this.cubit,
    required this.state,
  }) : super(key: key);

  final TextEditingController barCodeController;
  final TextEditingController priceController;
  final TextEditingController countController;
  final ProductAddingCubit cubit;
  final ProductAddingStates state;

  String textString = 'Adding Products';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SingleChildScrollView(
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
                controller: barCodeController,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (String value) {
                  print(value);
                },
                onChanged: (String value) {
                  print(value);
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
                controller: priceController,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (String value) {
                  print(value);
                },
                onChanged: (String value) {
                  print(value);
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
                controller: countController,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (String value) {
                  print(value);
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
              Center(
                  child: AddingButtons(
                      cubit: cubit,
                      color: Colors.deepOrange.shade500,
                      text: 'Add Product',
                      onPress: () {
                        cubit.cubitAddProduct(
                          barcodeId: int.parse(barCodeController.text),
                          price: int.parse(priceController.text),
                          count: int.parse(countController.text),
                        );
                        if(state is ProductAddingSuccessState){
                          textString = 'Successful';
                          barCodeController.text = '';
                          priceController.text = '';
                          countController.text = '';
                        }
                      })),
              Center(
                child: AddingButtons(
                  color: Colors.deepPurpleAccent.shade700,
                  cubit: cubit,
                  text: 'Upload Image',
                  onPress: () async {
                    File image;
                    final ImagePicker _picker = ImagePicker();
                    var imagePicker =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (imagePicker != null) {
                      image = File(imagePicker.path);
                      cubit.cubitUploadImage(image);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
