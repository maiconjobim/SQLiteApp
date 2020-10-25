import 'package:moor_flutter/moor_flutter.dart';
import 'package:sqliteapp/src/db/my_database.dart';
part 'category_dao.g.dart';

@UseDao(tables: [Products, Categories])
class CategoryDAO extends DatabaseAccessor<MyDataBase> with _$CategoryDAOMixin {
  Stream<List<Categorie>> listAll() {
    return (select(categories)).watch();
  }

  Future addCategory(Categorie category) {
    return into(categories).insert(category);
  }

  Future updateCategory(Categorie category) {
    return update(categories).replace(category);
  }

  Future removeCategory(id) {
    return (delete(categories)..where((category) => category.id.equals(id)))
        .go();
  }

  CategoryDAO(MyDataBase db) : super(db);
}
