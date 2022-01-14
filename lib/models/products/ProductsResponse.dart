class ProductsResponse {
  String? message;
  bool? isSuccess;
  Response? response;

  ProductsResponse({this.message, this.isSuccess, this.response});

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isSuccess = json['isSuccess'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }
}

class Response {
  Categories? categories;

  Response({this.categories});

  Response.fromJson(Map<String, dynamic> json) {
    categories = json['categories'] != null
        ? new Categories.fromJson(json['categories'])
        : null;
  }
}

class Categories {
  List<AllProducts>? allProducts;

  Categories({this.allProducts});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['allProducts'] != null) {
      allProducts = <AllProducts>[];
      json['allProducts'].forEach((v) {
        allProducts!.add(new AllProducts.fromJson(v));
      });
    }
  }
}

class AllProducts {
  int? productID;
  String? productName;
  String? barcodeName;
  String? barCode;
  String? barecodeImage;
  int? barCodeID;

  AllProducts(
      {this.productID,
      this.productName,
      this.barcodeName,
      this.barCode,
      this.barecodeImage,
      this.barCodeID});

  AllProducts.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    productName = json['productName'];
    barcodeName = json['barcodeName'];
    barCode = json['barCode'];
    barecodeImage = json['barecodeImage'];
    barCodeID = json['barCodeID'];
  }
}
