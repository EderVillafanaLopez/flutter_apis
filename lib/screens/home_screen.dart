import 'package:flutter/material.dart';
import 'package:flutter_apis/models/models.dart';
import 'package:flutter_apis/screens/screens.dart';
import 'package:flutter_apis/services/product_services.dart';
import 'package:flutter_apis/widgets/product_file.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

final productosServices = Provider.of<ProdcutosServicios>(context);

    if(productosServices.isLoading ) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),

      ),
      body: ListView.builder(
        itemCount: productosServices.productos.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            productosServices.selectedProduct = productosServices.productos[index].copy();
           Navigator.pushNamed(context, 'product');
          },
         child: ProductoCard(
          products: productosServices.productos[index],
         ),
         ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), 
        onPressed: (){
           productosServices.selectedProduct = Products(
            disponible: true, 
            nombre: '', 
            precio: 0, 
            );
          Navigator.pushNamed(context, 'product');
        }, 
      ),
   );
  }
}