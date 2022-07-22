import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

// todo: INTERFZ DE LISTA DE PRODUCTOS
class ProductCard extends StatelessWidget {
  
  final Product product;

  const ProductCard({
  Key? key,
  required this.product
  }) : super(key: key);

  // Contenedores, cuadros del producto
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(), // BOXDECORATION --------------
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [

            //EXTRAE WIDGET, IMAGEN DEL PRODUCTO
            _BackgroundImage(product.picture),

            //DETALLES DEL PRODUCTO
            _ProductDetails(
              title: product.name,
              subTitle: product.id!,
            ),

            //PRECIO DEL PRODUCTO
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(product.price)
            ),

            //NO DISPONIBLE, DISPONIBLE
            if(!product.available)
              Positioned(
                top: 0,
                left: 0,
                child: _NotAvaliable()
              ),



        ],
      ),
    ),
  );
}


//DECORACION DEL CONTENEDOR PRODUCTO
BoxDecoration _cardBorders() => BoxDecoration(    //BOXDECORATION ----------
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,7),
        blurRadius: 10
      )
    ]
  );
}


class _PriceTag extends StatelessWidget {

  final double price;

  const _PriceTag (this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:10),
          child: Text('\$$price', style:TextStyle(color:Colors.white, fontSize: 20))
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ),
    );
  }
}

//NO DISPONIBLE, DISPONIBLE
class _NotAvaliable extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No disponible',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      ),
    );

  }
}


//DERALLES DEL PRODUCTO
class _ProductDetails extends StatelessWidget {

  final String title;
  final String subTitle;

  const _ProductDetails({
    required this.title,
    required this.subTitle

  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),                  //_buildBoxDecoration
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

          Text(
              subTitle,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            
          ],
        ),
      ),
    );
  }
  BoxDecoration _buildBoxDecoration() => BoxDecoration(     //_buildBoxDecoration DECORACION DE DETALLES DEL PRODUCTO
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft:Radius.circular(25), topRight: Radius.circular(25))
  );
}

//IAMGEN DEL PRODUCTO
class _BackgroundImage extends StatelessWidget {

  final String? url;
  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url==null
        
        //SINO HAY IMAGEN
        ? Image(
          image: AssetImage('assets/no-image.png'),
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