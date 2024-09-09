import 'package:flutter/material.dart';
import 'package:product_manager/data/dbHelper.dart';
import 'package:product_manager/screens/product_detail.dart';
import '../models/product.dart';
import 'ProductAdd.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList> {
  var dbHelper = DbHelper();
  late List<Product> products = [];
  int productCount = 0;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products List"),
        backgroundColor: Colors.teal,
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        onPressed: () {
          goToProductAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Add new product",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
      itemCount: productCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.blueGrey.shade900,
          elevation: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.shopping_bag, color: Colors.teal),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Name: " +
                        (this.products[position].productName ?? "Unnamed"),
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
            Text(
              "Product Price: " +
                  (this.products[position].unitPrice != null
                      ? this.products[position].unitPrice!.toString() + " \$"
                      : "No Price"),

                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
              subtitle: Text(
                "Product Description: " +
                    (this.products[position].description ?? "No Description"),
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12.0,
                ),
              ),
              onTap: () {
                goToDetail(this.products[position]);
              },
            ),
          ),
        );
      },
    );
  }

  void goToProductAdd() async {
    bool? result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null && result) {
      getProducts();
    }
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        this.products = data;
        productCount = data.length;
      });
    });
  }

  void goToDetail(Product product) async {
    bool? result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail(product)));
    if (result != null && result) {
      getProducts();
    }
  }
}
