import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier{

  final String _baseUrl = 'flutter-varios2-3bd7f-default-rtdb.firebaseio.com';
  final List<Product> products = [];         // TOMAR EN CUENTA
  late Product selectedProduct;

  File? newPictureFile;


  
  bool isLoading=true;
  bool isSaving=true;

  ProductsService(){   //constructor
    this.loadProducts();
  }

  Future<List<Product>>loadProducts() async {

    this.isLoading=true;
    notifyListeners();

    final url=Uri.https(_baseUrl,'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic>productsMap=json.decode(resp.body);

    productsMap.forEach((key, value) { 
      final tempProduct=Product.fromMap(value);
      tempProduct.id=key;
      this.products.add(tempProduct);
    });

    this.isLoading = false;
    notifyListeners();
    
    return this.products;
  }



  //todo CREAR O GUARDAR PRODUCTO

  Future saveOrCreateProduct(Product product) async{

    isSaving=true;
    notifyListeners();

    if(product.id==null){
      await this.createProduct(product);
    }else{

    await this.updateProduct(product);
    }

    isSaving=false;
    notifyListeners();

  }

  Future<String>updateProduct(Product product)async{

    final url=Uri.https(_baseUrl,'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodedData=resp.body;
    print(decodedData);

    //todo actualizar
    final index=this.products.indexWhere((element) => element.id==product.id);
    this.products[index]=product;

    return product.id!;

  }


  //todo: CREACION DE PRODUCTO

  Future<String>createProduct(Product product)async{

    final url=Uri.https(_baseUrl,'products.json');
    final resp = await http.post(url, body: product.toJson()); //POST, ENVIAR AL FIREBASE
    final decodedData=json.decode(resp.body);

    product.id=decodedData['name'];

    this.products.add(product);

    return product.id!;

  }



void updateSelectedProductImage(String path){

  this.selectedProduct.picture=path;
  this.newPictureFile=File.fromUri(Uri(path: path));

  notifyListeners();
}


// todo: ENVIO DE IMAGEN AL SERVIDOR CLOUDINARY

Future<String?> uploadImage()async{
  if(this.newPictureFile==null) return null;

  this.isSaving=true;
  notifyListeners();

  final url=Uri.parse('https://api.cloudinary.com/v1_1/dvsq2kgxe/image/upload?upload_preset=wcr2nson');

  final imageUploadRequest = http.MultipartRequest('POST', url);

  final file = await http.MultipartFile.fromPath('file',newPictureFile!.path);

  imageUploadRequest.files.add(file);

  final streamResponse=await imageUploadRequest.send();
  final resp=await http.Response.fromStream(streamResponse);

  if (resp.statusCode !=200 && resp.statusCode !=201){
    print('algo salió mal');
    print(resp.body);
    return null;
  }

  this.newPictureFile=null;

  final decodedData=json.decode(resp.body);
  return decodedData['secure_url'];

} 
}