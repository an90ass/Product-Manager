class Product{
  int? id;
  String? productName;
  String? description;
  double? unitPrice;

  Product.withId({this.id,this.productName,this.description,this.unitPrice});
  Product({this.productName,this.description,this.unitPrice});

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["productName"]=productName;
    map["description"]=description;
    map["unitPrice"]=unitPrice;
    if(id!=null){
      map["id"]=id;
    }
    return map;
  }
  // Product.fromObject(dynamic o){
  //   this.id = int.tryParse(o["id"]);
  //   this.productName = o["productName"];
  //   this.description = o["description"];
  //   this.unitPrice = double.tryParse(o["unitPrice"].toString());
  // }
  Product.fromObject(dynamic o) {
    // Handle cases where `id` might be an int or a string
    this.id = o["id"] is int ? o["id"] : int.tryParse(o["id"].toString());

    this.productName = o["productName"];
    this.description = o["description"];

    // Handle cases where `unitPrice` might be an int or a double
    if (o["unitPrice"] is int) {
      this.unitPrice = (o["unitPrice"] as int).toDouble();
    } else if (o["unitPrice"] is double) {
      this.unitPrice = o["unitPrice"];
    } else {
      this.unitPrice = double.tryParse(o["unitPrice"].toString());
    }
  }

}
