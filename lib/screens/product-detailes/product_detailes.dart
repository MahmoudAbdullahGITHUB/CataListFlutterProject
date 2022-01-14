import 'package:c_product_flutter/models/products/ProductsResponse.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  static const routName = '/details-screen';
  AllProducts? myAllProducts;

  ProductDetails([this.myAllProducts]) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          color: Colors.grey[300],
          child: Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1, //                   <--- border width here
                    ),
                  ),
                  child: Image.network(
                    '${myAllProducts?.barecodeImage}',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 30,),
                Text('productName :    ${myAllProducts?.productName}',style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text('barCode :         ${myAllProducts?.barCode}',style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text('barcodeName :     ${myAllProducts?.barcodeName}',style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
