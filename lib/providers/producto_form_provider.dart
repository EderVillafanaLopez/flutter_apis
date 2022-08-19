import 'package:flutter/material.dart';
import 'package:flutter_apis/models/models.dart';

class ProductoFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey =  GlobalKey<FormState>();
Products product;

ProductoFormProvider(this.product);

update(bool value){
  product.disponible = value;
  notifyListeners();
}

bool isValidForm(){
  print(product.nombre);
  print(product.precio);
  print(product.disponible);
  return formKey.currentState?.validate() ?? false;
}

}