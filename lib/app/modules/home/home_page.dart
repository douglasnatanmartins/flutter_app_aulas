import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_aulas/app/data/product_data.dart';
import 'package:flutter_app_aulas/app/product_model/product_model.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  String resultProduto;
  String resultValor;

  @override
  void initState() {
    super.initState();
    resultProduto ='';
    resultValor = '';
  }

  @override
  Widget build(BuildContext context) {
    print('reconstruiu');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Teste Increment Firebase'
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   'Produto:',
                 ),
                 const SizedBox(width: 5,),
                 Text(
                   resultProduto,
                 ),
               ],
             ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Valor:',
                  ),
                  const SizedBox(width: 5,),
                  Text(
                      resultValor,
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    final doc = await ProductModel().consulta('59KX1aIRPmV6L0n2IOPC');
                    ProductData produtct = ProductData.fromDocument(doc);

                    setState(() {
                      resultProduto = produtct.produto;

                      resultValor = produtct.valor;

                    });
                  },
                  child: Text(
                    'Consulta',
                  )
              ),
              ElevatedButton(
                  onPressed: () async {
                    await ProductModel().saveProduct();
                  },
                  child: Text(
                    'Insert',
                  )
              ),
              const SizedBox(height: 25),


              ///List de Dados.
              StreamBuilder<QuerySnapshot>(
                stream: ProductModel().consultaEmLista(),
                builder: (_, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {

                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.size,
                        itemBuilder: (_, index){
                          final listDoc = snapshot.data.docs;
                          ProductData product = ProductData.fromDocument(listDoc[index]);

                          return Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ID:',
                                    ),
                                    const SizedBox(width: 5,),
                                    Text(
                                      product.id,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Produto:',
                                    ),
                                    const SizedBox(width: 5,),
                                    Text(
                                      product.produto,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Valor:',
                                    ),
                                    const SizedBox(width: 5,),
                                    Text(
                                      product.valor,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Quantidade:',
                                    ),
                                    const SizedBox(width: 5,),
                                    Text(
                                      product.qtd.toString(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
