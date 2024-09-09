import 'package:flutter/material.dart';
import 'package:product_manager/screens/product_list.dart';

void main() {
  runApp( MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductList(),
        debugShowCheckedModeBanner: false
    );
  }
}