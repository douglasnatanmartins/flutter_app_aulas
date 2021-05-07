import 'package:cloud_firestore/cloud_firestore.dart';

/// Modelo de dados (PRODUTO)/ Objeto
class ProductData {


  /// Construtor para Inserir dados no Firebase.
  ProductData({this.produto, this.valor, this.qtd, this.id});

  String id;
  String produto;
  String valor;
  int qtd;

  ///Construtor para Ler dados do Firebase.
  ProductData.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    produto = doc['produto'] as String;
    valor = doc['valor'] as String;
    qtd = doc['quantidade'] as int;
  }

  ///Mapa de dados para agilizar a utilização.
  Map<String, dynamic> save(){
    final data = {
      'produto' : produto,
      'valor' : valor,
      'quantidade' : qtd
    };
    return data;
  }

}