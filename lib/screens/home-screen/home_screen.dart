import 'package:c_product_flutter/models/products/ProductsResponse.dart';
import 'package:c_product_flutter/models/user/LoginResponse.dart';
import 'package:c_product_flutter/network/local/cache_helper.dart';
import 'package:c_product_flutter/screens/adding-product/adding_product.dart';
import 'package:c_product_flutter/screens/drawer_navigation/drawer_navigation_screen.dart';
import 'package:c_product_flutter/screens/home-screen/cubit/cubit.dart';
import 'package:c_product_flutter/screens/home-screen/cubit/states.dart';
import 'package:c_product_flutter/screens/login-screen/login_screen.dart';
import 'package:c_product_flutter/screens/product-detailes/product_detailes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home-body.dart';

class HomeScreen extends StatelessWidget {
  static const routName = '/home-screen';
  User? user;
  HomeScreen([this.user]) : super();
  List<AllProducts>? myAllProducts;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProductGettingCubit(),
      child: BlocConsumer<ProductGettingCubit, ProductGettingStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ProductGettingCubit cubit = ProductGettingCubit.get(context);
            if (state is ProductGettingInitialState) {
              String? token = CacheHelper.getCacheData(key: 'token');

              cubit.getProducts(token: 'Bearer $token');
            }
            if (state is ProductGettingSuccessState) {
              if (state.productsResponse.message == 'Success') {
                myAllProducts =
                    state.productsResponse.response?.categories?.allProducts;
                print(myAllProducts?.length);
              }
            }
            return Scaffold(
              drawer: DrawerNavigationScreen(user),
              appBar: AppBar(
                title: Text('HomeScreen'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      CacheHelper.removeCacheData(key: 'token').then((value) {
                        if (value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        }
                      });
                    },
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddingProduct()),
                  );
                },
                backgroundColor: Colors.deepOrange,
                child: const Icon(Icons.add),
              ),
              body: HomeBody(myAllProducts: myAllProducts),
            );
          }),
    );
  }

  Widget buildContainer(String productName) {
    return Container(
      height: 50,
      child: Center(
          child: Text(
        '$productName',
        style: TextStyle(fontSize: 20),
      )),
      color: Colors.blueGrey,
    );
  }
}
