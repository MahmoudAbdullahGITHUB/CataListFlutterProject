import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:c_product_flutter/models/Adding/request.dart';
import 'package:c_product_flutter/models/Adding/response.dart';
import 'package:c_product_flutter/network/local/cache_helper.dart';
import 'package:c_product_flutter/network/remote/dio_helper.dart';
import 'package:c_product_flutter/screens/adding-product/cubit/states.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

class ProductAddingCubit extends Cubit<ProductAddingStates> {
  ProductAddingCubit() : super(ProductAddingInitialState());

  static ProductAddingCubit get(context) => BlocProvider.of(context);

  AddingResponse? addingResponse;
  String? token = CacheHelper.getCacheData(key: 'token');


  void cubitAddProduct({
    @required int? barcodeId,
    @required int? price,
    @required int? count,
  }) {
    emit(ProductAddingLoadingState());

    print('tok $token');
    AddingRequest addingRequest = AddingRequest(
      barcodeID: barcodeId,
      price: price,
      count: count,
      imagePath: '',
    );
    List<AddingRequest> list = [addingRequest];
    dynamic toJsonMap = jsonEncode(list);

    DioHelper.postData2(
            path: ApiDataAndEndPoints.addProductUrl,
            data: toJsonMap,
            token: 'Bearer $token')
        .then((value) {
      print(value.data);

      Map<String, dynamic> myMap = value.data;
      addingResponse = AddingResponse.fromJson(myMap);
      print('you make greatness bro =  ${addingResponse?.response?.message}');

      emit(ProductAddingSuccessState());
    }).catchError((error) {
      print('error $error yes-------- $token');
      emit(ProductAddingErrorState(error.toString()));
    });
  }

  void cubitUploadImage(File file) async {
    emit(ProductAddingUploadImLoadingState());
    print('non');
    Map<String, dynamic> map = Map<String, dynamic>();
    map['image'] = file;

    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    DioHelper.postData2(
      path: ApiDataAndEndPoints.uploadFileUrl,
      data: formData,
      token: 'Bearer $token',
    ).then((value) {
      emit(ProductAddingSuccessState());

      print('ay haga ');
      print(value.data);
    }).catchError((error) {
      print('ay haga 2');
      print('error $error yes-------- $token');
      emit(ProductAddingErrorState(error.toString()));
    });

    // response = await dio.post(path, data: formData);
    // return response.data['id'];
  }

  // void checkNetworkConnection() async{
  //   ConnectivityResult myresult = ConnectivityResult.none;
  //   StreamSubscription mysubscription;
  //
  //   /** get the current state of network */
  //   myresult = await Connectivity().checkConnectivity();
  //
  //   print('ooooooooooooohhhhhhhhhhhh');
  //
  //   /** get the state of network when it's changed */
  //   mysubscription = Connectivity().onConnectivityChanged.listen((result) {
  //     myresult = result;
  //     print('ayyyyyyyyyyyyyyyeeeeeeeehhhhhhhh');
  //   });
  //
  //   if (myresult == ConnectivityResult.wifi) {
  //     print('Wifi');
  //     emit(ProductAddingNetworkSuccessState());
  //     showSimpleNotification(Text("this is a message from simple notification"),
  //         background: Colors.green);
  //   } else if (myresult == ConnectivityResult.mobile) {
  //     print('ya 3am');
  //     emit(ProductAddingNetworkSuccessState());
  //     showSimpleNotification(Text("this is a message from simple notification"),
  //         background: Colors.green);
  //   } else {
  //     print('ya 3am leeeeh ${myresult}');
  //     emit(ProductAddingNetworkFailedState());
  //     showSimpleNotification(Text("this is a message from simple notification"),
  //         background: Colors.red);
  //   }
  // }
}
