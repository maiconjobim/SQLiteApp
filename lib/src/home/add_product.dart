import 'package:flutter/material.dart';
import 'package:sqliteapp/src/db/my_database.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  int catetgoryValue = null;
  Product product = Product(quantity: 10, price: 1000);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: " Product Title",
                ),
                onSaved: (value) {
                  product = product.copyWith(title: value);
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Product Description",
                ),
                onSaved: (value) {
                  product = product.copyWith(description: value);
                },
              ),
              StreamBuilder<List<Categorie>>(
                  stream: MyDataBase.instance.categoryDAO.listAll(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    var list = snapshot.data;
                    return DropdownButtonFormField(
                      hint: Text("Select Category"),
                      value: catetgoryValue,
                      items: list
                          .map((category) => DropdownMenuItem(
                                child: Text(category.title),
                                value: category.id,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          catetgoryValue = value;
                        });
                      },
                      onSaved: (id) {
                        product = product.copyWith(idCategory: id);
                      },
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () async {
                  _formKey.currentState.save();
                  print(product.toJson());
                  await MyDataBase.instance.productDAO.addProduct(product);
                  Navigator.pop(context);
                },
                child: Text("Save Product"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
