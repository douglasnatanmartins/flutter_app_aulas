import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_aulas/app/data/product_data.dart';

/// Classe ProductModel
class ProductModel {

  ///Instanciando o Firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  ///Save Product
  Future<void> saveProduct() async {

    final productData = ProductData (
      produto: 'Sofa de canto',
      valor: 'R\$ 1.125,00 ',
      qtd: 3
    );

    await _firestore.collection('produto').add(productData.save());
  }

  /// Consulta Unica por ID
  Future<DocumentSnapshot> consulta(String document) async {
    final doc = await _firestore.collection('produto').doc(document).get();
    return doc;
  }


  ///Consulta em lista
  Stream<QuerySnapshot> consultaEmLista(){
    final query = _firestore.collection('produto').snapshots();
    return query;
  }

}