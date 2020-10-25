import 'package:moor_flutter/moor_flutter.dart';
import 'package:sqliteapp/src/db/my_database.dart';
part 'product_dao.g.dart';

@UseDao(tables: [Products, Categories])
class ProductDAO extends DatabaseAccessor<MyDataBase> with _$ProductDAOMixin {
  ProductDAO(MyDataBase db) : super(db);
}
