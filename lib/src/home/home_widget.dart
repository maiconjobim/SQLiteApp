import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:sqliteapp/src/category/category_widget.dart';
import 'package:sqliteapp/src/db/dao/product_dao.dart';
import 'package:sqliteapp/src/db/my_database.dart';
import 'package:sqliteapp/src/home/add_product.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (contex) {
                return CategoryWidget();
              }));
            },
          )
        ],
        title: Text("App with SQLite"),
      ),
      body: StreamBuilder<List<ProductWithNameCategory>>(
        stream: MyDataBase.instance.productDAO.listAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();

          List<ProductWithNameCategory> products = snapshot.data;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(products[index].product.title),
                subtitle: Text("${products[index].name}"),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddProduct();
              },
            ),
          );
        },
      ),
    );
  }
}
