import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/dbHelper.dart';
import '../models/product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State<ProductAdd> {
  var dbHelper = DbHelper();

  TextEditingController textProductName = TextEditingController();
  TextEditingController textDescription = TextEditingController();
  TextEditingController textUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            buildProductNameField(),
            SizedBox(height: 10.0),
            buildDescriptionField(),
            SizedBox(height: 10.0),
            buildUnitPriceField(),
            SizedBox(height: 20.0),
            buildSaveButton(),
          ],
        ),
      ),
    );
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

  Widget buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        addProduct();
      },
      child: Text("Add Product", style: TextStyle(fontSize: 16.0)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  void addProduct() async {
    if (textProductName.text.isEmpty || textUnitPrice.text.isEmpty) {
      showErrorMessage(context, "Product Name and Unit Price cannot be empty!");
      return;
    }
    double? unitPrice = double.tryParse(textUnitPrice.text);
    if (unitPrice == null) {
      showErrorMessage(
          context, "Invalid Unit Price! Please enter a valid number.");
      return;
    }

    var result = await dbHelper.insert(Product(
      productName: textProductName.text,
      description: textDescription.text,
      unitPrice: unitPrice,
    ));

    if (result != null) {
      showSuccessMessage(context, "Product Added Successfully");
    } else {
      showErrorMessage(context, "Failed to Add Product, Try Again!!");
    }

    Navigator.pop(context, true);
  }

  void showErrorMessage(BuildContext context, String message) {
    var alert = SnackBar(
      content: Text(message,style: TextStyle(
          color: Colors.white
      ),),
      backgroundColor: Colors.red[600],
    );
    ScaffoldMessenger.of(context).showSnackBar(alert);
  }

  void showSuccessMessage(BuildContext context, String message) {
    var alert = SnackBar(
      content: Text(message,style: TextStyle(
        color: Colors.white
      ),),
      backgroundColor: Colors.teal,
    );
    ScaffoldMessenger.of(context).showSnackBar(alert);
  }
}
