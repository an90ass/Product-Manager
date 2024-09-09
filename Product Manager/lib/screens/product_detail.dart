
import 'package:flutter/material.dart';
import 'package:product_manager/data/dbHelper.dart';

import '../models/product.dart';

class ProductDetail extends StatefulWidget{
  Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }

}
enum Options {delete,update}
class _ProductDetailState extends State {
  Product product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();

  TextEditingController textProductName = TextEditingController();
  TextEditingController textDescription = TextEditingController();
  TextEditingController textUnitPrice = TextEditingController();

  @override
  void initState() {
    textProductName.text = product.productName!;
    textDescription.text=product.description!;
    textUnitPrice.text = product.unitPrice!.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Product details: ${product.productName}",
        style: TextStyle(
          color: Colors.white
        ),),
        actions: [
          PopupMenuButton<Options>(
            onSelected: selectProses,
            itemBuilder: (BuildContext context)=><PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Delete"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Update"),
              ),            ],
          )
        ],
      ),
      body: Padding(
    padding: EdgeInsets.all(20.0),
    child: Column(
    children: [
    buildProductNameField(),
    SizedBox(height: 10.0), // Add space between input fields
    buildDescriptionField(),
    SizedBox(height: 10.0),
    buildUnitPriceField(),
    SizedBox(height: 20.0),
    ]
    ),
    )
    );

  }

  void selectProses(Options options) async {
    switch (options) {
      case Options.delete:
        if (product.id != null) {
          await dbHelper.delete(product.id!);
          var alert = SnackBar(
            content: Text("Product Deleted Successfully"),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(alert);
          Navigator.pop(context, true);
        } else {
          var alert = SnackBar(
            content: Text("Failed to delete: Product ID is null"),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(alert);
        }
        break;
      case Options.update:
        await dbHelper.update(Product.withId(id: product.id,productName:textProductName.text,description: textDescription.text,unitPrice: double.tryParse(textUnitPrice.text) ));
        if (product.id != null) {
        var alert = SnackBar(
          content: Text("Product Updated Successfully"),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(alert);
        Navigator.pop(context, true);
    } else {
    var alert = SnackBar(
    content: Text("Failed to Update, Try Again!!"),
    backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(alert);
    }
    break;


      default:
        break;
    }
  }

  Widget buildProductNameField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Product Name",
        hintText: "Example: Phone",
        labelStyle: TextStyle(color: Colors.teal),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2.0),
        ),
      ),
      controller: textProductName,
    );
  }

  Widget buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Description",
        hintText: "Example: A smartphone",
        labelStyle: TextStyle(color: Colors.teal),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2.0),
        ),
      ),
      controller: textDescription,

    );
  }

  Widget buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Unit Price",
        hintText: "Example: 500",
        labelStyle: TextStyle(color: Colors.teal),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2.0),
        ),
      ),
      controller: textUnitPrice,
      keyboardType: TextInputType.number,
    );
  }

}




