
import 'package:c_product_flutter/models/products/ProductsResponse.dart';
import 'package:c_product_flutter/screens/product-detailes/product_detailes.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
    required this.myAllProducts,
  }) : super(key: key);

  final List<AllProducts>? myAllProducts;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: myAllProducts?.length,
          padding: const EdgeInsets.all(20.0),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Material(
                  color: Colors.grey[300],
                  child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.list),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetails(myAllProducts?[index])),
                          );
                        },
                      ),
                      trailing: Text(
                        '${myAllProducts?[index].productName}',
                        style: TextStyle(
                            color: Colors.black, fontSize: 15),
                      ),
                      title: Text(
                        '${myAllProducts?[index].productID}',
                      )),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
          }),
    );
  }
}
