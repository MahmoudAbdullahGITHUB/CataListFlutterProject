import 'package:c_product_flutter/models/user/LoginResponse.dart';

abstract class ProductLoginStates {}

class ProductLoginInitialState extends ProductLoginStates {}

class ProductLoginLoadingState extends ProductLoginStates {}

class ProductLoginSuccessState extends ProductLoginStates {
  final LoginResponse loginResponse;

  ProductLoginSuccessState(this.loginResponse);

}

class ProductLoginErrorState extends ProductLoginStates {

  final String error;

  ProductLoginErrorState(this.error);
}
