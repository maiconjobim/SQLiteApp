import 'package:moor_flutter/moor_flutter.dart';
import 'package:sqliteapp/src/db/dao/product_dao.dart';

import 'dao/category_dao.dart';
part 'my_database.g.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idCategory => integer()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get quantity => integer()();
  IntColumn get price => integer()();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
}

@UseMoor(tables: [Products, Categories])
class MyDataBase extends _$MyDataBase {
  static MyDataBase instance = MyDataBase._internal();

  ProductDAO productDAO;
  CategoryDAO categoryDAO;

  MyDataBase._internal()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: "products.sqlite")) {
    productDAO = ProductDAO(this);
    categoryDAO = CategoryDAO(this);
  }

  @override
  int get schemaVersion => 1;
}
