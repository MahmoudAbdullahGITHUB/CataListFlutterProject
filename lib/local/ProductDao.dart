import 'package:c_product_flutter/models/Adding/request.dart';
import 'package:c_product_flutter/shared/constants/constants.dart';
import 'package:floor/floor.dart';

@dao
abstract class ProductDao {
  @Query('SELECT * FROM $TABLE_NAME')
  Future<List<AddingRequest>> findAllProducts();

  @Query('DELETE FROM $TABLE_NAME')
  Future<void> deleteAllProducts();

  // @Query('SELECT * FROM $TABLE_NAME WHERE id = :id')
  // Stream<AddingRequest?> findProductById(int id);

  // @Query('SELECT * FROM $TABLE_NAME')
  // Future<List<AddingRequest>?> getAllProducts();

  @insert
  Future<void> insertProduct(AddingRequest addingRequest);

}