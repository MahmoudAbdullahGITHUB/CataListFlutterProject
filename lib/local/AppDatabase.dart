import 'package:c_product_flutter/local/ProductDao.dart';
import 'package:c_product_flutter/models/Adding/request.dart';
import 'package:floor/floor.dart';

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

/**
 * must import this part and it must have the same name of your database
 * in our case here AppDatabase like abstract class below AppDatabase class
 * and then run this commend on terminal
 * " flutter packages pub run build_runner build "
 */
part 'AppDatabase.g.dart'; // the generated code will be there

@Database(version: 1, entities: [AddingRequest])
abstract class AppDatabase extends FloorDatabase {
  ProductDao get personDao;
}
