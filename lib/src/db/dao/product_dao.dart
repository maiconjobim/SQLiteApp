import 'package:moor_flutter/moor_flutter.dart';
import 'package:sqliteapp/src/db/my_database.dart';
part 'product_dao.g.dart';

class ProductWithNameCategory {
  final Product product;
  final String name;

  ProductWithNameCategory(this.product, this.name);
}

@UseDao(tables: [Products, Categories])
class ProductDAO extends DatabaseAccessor<MyDataBase> with _$ProductDAOMixin {
  Stream<List<ProductWithNameCategory>> listAll() {
    return customSelect(
      "SELECT products.*,categories.title as name FROM products INNER JOIN categories ON products.id_category = categories.id",
      readsFrom: {products, categories},
    ).watch().map((rows) {
      return rows
          .map((row) => ProductWithNameCategory(
              Product.fromData(row.data, db), row.readString('title')))
          .toList();
    });
  }

  Future addProduct(Product product) {
    return into(products).insert(product);
  }

  Future updateProduct(Product product) {
    return update(products).replace(product);
  }

  Future removeProduct(id) {
    return (delete(products)..where((product) => product.id.equals(id))).go();
  }

  ProductDAO(MyDataBase db) : super(db);
}
