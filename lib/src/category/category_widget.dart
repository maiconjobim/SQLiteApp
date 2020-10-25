import 'package:flutter/material.dart';
import 'package:sqliteapp/src/db/my_database.dart';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (contex) {
                return AddCategory();
              }));
            },
          )
        ],
        title: Text("Category"),
      ),
      body: StreamBuilder<List<Categorie>>(
        stream: MyDataBase.instance.categoryDAO.listAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) return Container();

          List<Categorie> categories = snapshot.data;

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index].title),
              );
            },
          );
        },
      ),
    );
  }
}

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: Column(
        children: [
          TextField(),
        ],
      ),
    );
  }
}
