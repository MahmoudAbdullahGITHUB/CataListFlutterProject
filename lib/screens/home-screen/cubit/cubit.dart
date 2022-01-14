import 'dart:convert';

import 'package:c_product_flutter/models/products/ProductsResponse.dart';
import 'package:c_product_flutter/models/user/LoginResponse.dart';
import 'package:c_product_flutter/network/remote/dio_helper.dart';
import 'package:c_product_flutter/screens/home-screen/cubit/states.dart';
import 'package:c_product_flutter/screens/login-screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductGettingCubit extends Cubit<ProductGettingStates> {
  ProductGettingCubit() : super(ProductGettingInitialState());

  static ProductGettingCubit get(context) => BlocProvider.of(context);

  ProductsResponse? productsResponse;

  void getProducts({
    @required String? token,
  }) {
    emit(ProductGettingLoadingState());
    DioHelper.getData(path: ApiDataAndEndPoints.getProductsUrl, token: token)
        .then((value) {
      Map<String,dynamic> myMap= value.data;

      productsResponse = ProductsResponse.fromJson(myMap);

      print(productsResponse?.response?.categories?.allProducts?[0].productName);

      emit(ProductGettingSuccessState(productsResponse!));

    }).catchError((error) {
      print('error $error');
      emit(ProductGettingErrorState(error.toString()));
    });
  }
}
