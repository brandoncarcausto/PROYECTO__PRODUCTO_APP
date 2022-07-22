import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';

import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';



class HomeScreen extends StatelessWidget{
  @override
  Widget build (BuildContext context){

    final productsService=Provider.of<ProductsService>(context);

    if(productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),  //Barra de arriba de la interfaz de los listados de productos
      ),

      // todo: Lista de productos
      body: ListView.builder(
        itemCount: productsService.products.length, //Lista solo los productos que se creen
        itemBuilder: (BuildContext context, int index) => GestureDetector( 
          onTap: (){
            productsService.selectedProduct=productsService.products[index].copy(); //crea una copia del producto
            Navigator.pushNamed(context, 'product'); //todo: PASA A LA PAGINA PPRESIONANDO LA IMAGEN
          },
          child: ProductCard(
            product: productsService.products[index],
          ),
        )
      ),



      //todo: ICONO DE CREAR
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            
            //AL presionar la funcion del icono crear
            productsService.selectedProduct=new Product(
              available: false,
              name: '',
              price: 0
              );
            Navigator.pushNamed(context, 'product');
          },
        ),

      );
  }
}