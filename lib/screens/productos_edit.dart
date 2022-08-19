
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apis/providers/producto_form_provider.dart';
import 'package:flutter_apis/services/product_services.dart';
import 'package:flutter_apis/ui/input_decorations.dart';
import 'package:flutter_apis/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductoEdit extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProdcutosServicios>(context);

    return ChangeNotifierProvider(
      create: ( _ ) => ProductoFormProvider(productService.selectedProduct),
      child: _ProductosScreenBody( productService: productService),
    );
  }
}

class _ProductosScreenBody extends StatelessWidget {
  const _ProductosScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProdcutosServicios productService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductoFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductoImagen(url: productService.selectedProduct.foto),
                //REGRESAR
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 40, color:Colors.white,),
                    )
                  ),
                  //CAMARA
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () {
                    },
                    icon: const Icon(Icons.camera_alt_outlined, size: 40, color:Colors.white,),
                    )
                  )
              ],
            ),

        _productoForm(),
         const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save_alt_outlined),
        onPressed: ()async{
          if(!productForm.isValidForm()) return;
       await productService.saveOrCreateProduct(productForm.product);
        },
        ),
    );
  }
}

class _productoForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


  final productForm = Provider.of<ProductoFormProvider>(context);
  final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,

      decoration: _decorations(),
      child: Form(
        key: productForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
           const SizedBox(
              height: 10),
              TextFormField(
                initialValue: product.nombre,
                onChanged: ((value) => product.nombre = value),
                validator: (value) {
                  if(value == null || value.length < 1) {
                    return 'Ingrese el nombre producto';
                  }
                },
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Nombre del producto', 
              labelText: 'Nombre:',
              ),
            ),
           const SizedBox(height: 30),

             TextFormField(
               initialValue: '${product.precio}',
               inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
               ],
                onChanged: (value){
                  if(double.tryParse(value) == null){
                    product.precio = 0;                    
                  }
                  else{
                    product.precio = double.parse(value);
                  }
                },
              keyboardType: TextInputType.number,
            decoration: InputDecorations.authInputDecoration(
              hintText: '\$150', 
              labelText: 'Precio:',
              ),
            ),
            const SizedBox(height: 30),

            SwitchListTile.adaptive(
              value: product.disponible,
              title: Text('Disponible'),
              activeColor: Colors.indigo,
              onChanged: productForm.update
              ),

             const SizedBox(height: 30)
          ],
        ),
      ),
      ),
    );
  }

  BoxDecoration _decorations() => BoxDecoration(
    color: Colors.white ,
    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25),  bottomRight: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0,5),
        blurRadius: 5
      )
          ]
  );
}