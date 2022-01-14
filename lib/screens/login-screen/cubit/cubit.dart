import 'dart:convert';

import 'package:c_product_flutter/models/user/LoginResponse.dart';
import 'package:c_product_flutter/network/remote/dio_helper.dart';
import 'package:c_product_flutter/screens/login-screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductLoginCubit extends Cubit<ProductLoginStates> {
  ProductLoginCubit() : super(ProductLoginInitialState());

  static ProductLoginCubit get(context) => BlocProvider.of(context);

  LoginResponse? loginResponse;

  void userLogin({
    @required String? userName,
    @required String? password,
  }) {
    emit(ProductLoginLoadingState());

    DioHelper.postData(
      path: ApiDataAndEndPoints.loginUrl,
      data: {
        'userName': userName,
        'password': password,
        'langID': 1,
      },
    ).then((value) {
      print(value.data);

      Map<String,dynamic> myMap= value.data;
      // print('myMap = $myMap');
      loginResponse = LoginResponse.fromJson(myMap);
      print('you make greatness bro =  ${loginResponse?.response?.user?.fullName}');
      emit(ProductLoginSuccessState(loginResponse!));
    }).catchError((error) {
      print('error $error');
      emit(ProductLoginErrorState(error.toString()));
    });
  }
}
