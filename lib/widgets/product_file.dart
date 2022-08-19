import 'package:flutter/material.dart';
import 'package:flutter_apis/models/models.dart';

class ProductoCard extends StatelessWidget {

  final Products products;

  const ProductoCard({
    Key? key, 
 required this.products}) 
 : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _decorations(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _image(products.foto),

            _Detalles(
              nombre: products.nombre,
            subnombre: products.id!,
            ),

            Positioned(
              top: 0,
              right: 0,
              child: _Price(
                products.precio
              )
              ),

              if(!products.disponible)
               Positioned(
              top: 0,
              left: 0,
              child: _disponible()),
          ],
        ),
      ),
    );
  }

  BoxDecoration _decorations() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
       BoxShadow(
        color: Colors.black,
        offset: Offset(0, 7),
        blurRadius: 20,
      )
    ]
  );
}

class _disponible extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          'No Disponible',
          style: TextStyle(color: Colors.white, fontSize: 20),          
        ),
        ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: BorderRadius.only( topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      ),
    );
  }
}

class _Price extends StatelessWidget {

  final double precio;

  const _Price(
     this.precio);
  @override
  Widget build(BuildContext context) {
    return Container(

      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$$precio', style: const TextStyle(color: Colors.white, fontSize: 20))
           ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ), 
    );
  }
}

class _Detalles extends StatelessWidget {
    final String nombre;
    final String subnombre;

  const _Detalles({
   required this.nombre, 
    required this.subnombre
    });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration:  _BuildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
             Text(
              nombre, 
            style: TextStyle(fontSize:20, color: Colors.white, fontWeight: FontWeight.bold ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            ),
            Text(
            subnombre, 
            style: TextStyle(fontSize:20, color: Colors.white ),
            ),
          ],
        ),
       ),
    );
  }

  BoxDecoration _BuildBoxDecoration() =>  const BoxDecoration(

    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))

  );
}

class _image extends StatelessWidget {
  final String? url;
  const _image(this.url);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
      child: url == null 
      ?
      Image(image: AssetImage('assets/no-image.png'),
      fit: BoxFit.cover,
      )
      :
      FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'), 
        image: NetworkImage(url!),
        fit: BoxFit.cover,
        ),
),
    );
  }
}
