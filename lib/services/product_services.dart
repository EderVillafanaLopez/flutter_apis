
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_apis/models/productos.dart';
import 'package:http/http.dart' as http;

class ProdcutosServicios extends ChangeNotifier{
final String _baseUrl = 'flutterapis-a6880-default-rtdb.firebaseio.com';
final List<Products> productos = [];
 late Products selectedProduct; 

bool isLoading = true;
bool isSaving = false;
ProdcutosServicios(){
loadProductos();
}
Future<List<Products>> loadProductos() async {

isLoading = true;
notifyListeners();

final url = Uri.https(_baseUrl, 'Productos.json');
final resp = await http.get(url);

  final Map<String, dynamic> productosMap =json.decode(resp.body);

  productosMap.forEach((key, value){
 final tempProducto = Products.fromMap(value);
 tempProducto.id = key;
   print(tempProducto);
    productos.add(tempProducto);   
  
  });
    isLoading = false;
    notifyListeners();

  return productos;

}

Future saveOrCreateProduct(Products productos) async {
isSaving = true;
notifyListeners();

if(productos.id == null){
await createProduct( productos);
}
else
{
await updateProduct(productos);
}

isSaving = false;
notifyListeners();

}

Future<String> updateProduct(Products producto) async{
  final url = Uri.https(_baseUrl, 'Productos/${producto.id}.json');
final resp = await http.put(url, body: producto.toJson());
final decodeData = resp.body;

print(decodeData);

//TODO: Actualizar
final index = productos.indexWhere((element) => element.id == producto.id);
productos[index] = producto;

return producto.id!;
}

Future<String> createProduct(Products producto) async{
  final url = Uri.https(_baseUrl, 'Productos.json');
  final resp = await http.post(url, body: producto.toJson());
  final decodeData = json.decode( resp.body);
  producto.id = decodeData['name'];

  productos.add(producto);
    return producto.id!;
}
}