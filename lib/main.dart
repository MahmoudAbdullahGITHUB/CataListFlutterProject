import 'package:bloc/bloc.dart';
import 'package:c_product_flutter/screens/adding-product/adding_product.dart';
import 'package:c_product_flutter/screens/home-screen/home_screen.dart';
import 'package:c_product_flutter/screens/login-screen/login_screen.dart';
import 'package:c_product_flutter/screens/product-detailes/product_detailes.dart';
import 'package:c_product_flutter/shared/bloc_observer.dart';
import 'package:c_product_flutter/utils/theme.dart';
import 'package:flutter/material.dart';

import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  String? token = CacheHelper.getCacheData(key: 'token');
  // print('token0 = $token');

  /** this below lines only to see the current state of your bloc*/
  BlocOverrides.runZoned(
        () {
          runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {
  // final String parentToken;
  // MyApp( String myToken) : parentToken = myToken;

  @override
  Widget build(BuildContext context) {
    String? token = CacheHelper.getCacheData(key: 'token');

    // print('token1 = ${token}');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      // themeMode:
      // AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
      home: token != null ? HomeScreen(): LoginScreen(),

      routes: {
        LoginScreen.routName: (_) => LoginScreen(),
        HomeScreen.routName:  (_) => HomeScreen(),
        ProductDetails.routName:  (_) => ProductDetails(),
        AddingProduct.routName:  (_) => AddingProduct(),


      },
    );
  }
}

