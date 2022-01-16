import 'package:c_product_flutter/shared/constants/constants.dart';
import 'package:floor/floor.dart';

@Entity(tableName: '$TABLE_NAME')
class AddingRequest {
  @primaryKey
  int? id;

  int? barcodeID;
  int? price;
  int? count;
  String? imagePath;

  AddingRequest({this.id,this.barcodeID, this.price, this.count, this.imagePath});

  AddingRequest.fromJson(Map<String, dynamic> json) {
    barcodeID = json['barcodeID'];
    price = json['price'];
    count = json['count'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barcodeID'] = this.barcodeID;
    data['price'] = this.price;
    data['count'] = this.count;
    data['imagePath'] = this.imagePath;
    return data;
  }
}
