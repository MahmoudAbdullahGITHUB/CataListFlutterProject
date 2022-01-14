import 'package:c_product_flutter/models/products/ProductsResponse.dart';

abstract class ProductGettingStates {}

class ProductGettingInitialState extends ProductGettingStates {}

class ProductGettingLoadingState extends ProductGettingStates {}

class ProductGettingSuccessState extends ProductGettingStates {
  final ProductsResponse productsResponse;

  ProductGettingSuccessState(this.productsResponse);

}

class ProductGettingErrorState extends ProductGettingStates {

  final String error;

  ProductGettingErrorState(this.error);
}
