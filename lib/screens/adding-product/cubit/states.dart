import 'package:c_product_flutter/models/products/ProductsResponse.dart';

abstract class ProductAddingStates {}

class ProductAddingInitialState extends ProductAddingStates {}

class ProductAddingLoadingState extends ProductAddingStates {}

class ProductAddingUploadImLoadingState extends ProductAddingStates {}

class ProductAddingSuccessState extends ProductAddingStates {
  // final ProductsResponse productsResponse;
  //
  // ProductAddingSuccessState(this.productsResponse);

}

class ProductAddingErrorState extends ProductAddingStates {
  final String error;

  ProductAddingErrorState(this.error);
}

class ProductAddingNetworkSuccessState extends ProductAddingStates {}

class ProductAddingNetworkFailedState extends ProductAddingStates {}
