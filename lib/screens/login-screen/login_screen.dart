import 'package:c_product_flutter/network/local/cache_helper.dart';
import 'package:c_product_flutter/screens/home-screen/home_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  static const routName = '/login-screen';

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProductLoginCubit(),
      child: BlocConsumer<ProductLoginCubit, ProductLoginStates>(
        listener: (context, state) {
          if (state is ProductLoginSuccessState) {
            if (state.loginResponse.message == 'Success') {
              print(state.loginResponse.message);
              print(state.loginResponse.response?.user?.token);

              CacheHelper.saveCacheData(
                      key: 'token',
                      value: state.loginResponse.response!.user!.token)
                  .then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(state.loginResponse.response?.user)),
                );
              });
            } else {
              print(state.loginResponse.message);
            }
          }
        },
        builder: (context, state) {
          ProductLoginCubit cubit = ProductLoginCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (String value) {
                          print(value);
                        },
                        onChanged: (String value) {
                          print(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        onFieldSubmitted: (String value) {
                          print(value);
                        },
                        onChanged: (String value) {
                          print(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.blue,
                        child: ConditionalBuilder(
                          condition: state is! ProductLoginLoadingState,
                          builder: (context) => MaterialButton(
                            onPressed: () {
                              cubit.userLogin(
                                userName: emailController.text,
                                password: passwordController.text,
                              );

                              print(emailController.text);
                              print(passwordController.text);
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Register Now',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}