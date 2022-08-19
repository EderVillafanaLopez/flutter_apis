// To parse this JSON data, do
//
//     final products = productsFromMap(jsonString);

import 'dart:convert';

class Products {
    Products({
       required this.precio,
       required this.disponible,
        this.foto,
       required this.nombre,
       this.id,
    });

    double precio;
    bool disponible;
    String? foto;
    String nombre;
    String? id;

    factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Products.fromMap(Map<String, dynamic> json) => Products(
        precio: json["Precio"].toDouble(),
        disponible: json["disponible"],
        foto: json["foto"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "Precio": precio,
        "disponible": disponible,
        "foto": foto,
        "nombre": nombre,
    };

    Products copy() => Products( 
      disponible: this.disponible,
      nombre: this.nombre,
      foto: this.foto,
      precio: this.precio,
      id: this.id
    );
}