import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:muzammil_apis/Models/photos_model.dart';
import 'package:muzammil_apis/Models/products_model.dart';

class ProductsApiScreen extends StatefulWidget {
  const ProductsApiScreen({super.key});

  @override
  State<ProductsApiScreen> createState() => _ProductsApiScreenState();
}

class _ProductsApiScreenState extends State<ProductsApiScreen> {

  //API IMPLEMENTATION very Complex
  //Array nhi is liay no list
  Future<ProductsModel> getProductsApi()async{
    final response = await http.get(Uri.parse('https://webhook.site/46cd8ff7-d746-4267-9663-6180c971364f'));

    var data = jsonDecode(response.body.toString());

      if(response.statusCode==200){
        return ProductsModel.fromJson(data);
      }else{
        return ProductsModel.fromJson(data);
        
      }
    }
  //
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Expanded(
            //productsmodel passed in futurebuilder
            child: FutureBuilder<ProductsModel>(
              future: getProductsApi(),
               builder: (context, snapshot){
                if(!snapshot.hasData){
                return const  SpinKitFadingCube(color: Colors.purple, size: 20,);
                }
                else{
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length, //No
                    itemBuilder: (context, index){

                      return Column(
                        children: [
                          //TRYYYYYY
                          ListTile(
                 title: Text(snapshot.data!.data![index].shop!.name.toString()),
                 subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                 leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    snapshot.data!.data![index].shop!.image.toString(),

                  ),
                 ),

                          ),
                          Container(
                            height: MediaQuery.of(context).size.height *.3,
                            width: MediaQuery.of(context).size.width *.1,

                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.data![index].images!.length,
                              itemBuilder: (context, index2){ //index2 becuz name should be seprate
                                return Container(
                           height: MediaQuery.of(context).size.height *.25,
                            width: MediaQuery.of(context).size.width *.1,

                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:NetworkImage(snapshot.data!.data![index].images![index2].url.toString()) )
                            ),
                                );

                              }),
                          ),
                          
                        ],
                      );
            
                    });
                }
               }),
          )
        ],
      ),
    );
  }
}