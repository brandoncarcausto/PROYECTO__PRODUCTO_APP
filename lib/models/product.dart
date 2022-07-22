// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);
//todo: Modelo para enviar los datos al firebase base de datos
import 'dart:convert';

class Product {
    Product({
        required this.available,  //requerido
        required this.name,       //requerido
        this.picture,             //opcional
        required this.price,      //requerido
        this.id                   //opcional
    });

    bool available;
    String name;
    String? picture;
    double price;
    String? id;


    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());    //Todo: Manda al servidor

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
    };
Product copy() => Product(
  available: this.available,
  name: this.name,
  picture: this.picture,
  price: this.price, 
  id: this.id,
  );
}
