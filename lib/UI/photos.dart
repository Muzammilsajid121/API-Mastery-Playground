import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:muzammil_apis/Models/photos_model.dart';


class PhotoApiScreen extends StatefulWidget {
  const PhotoApiScreen({super.key});

  @override
  State<PhotoApiScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PhotoApiScreen> {
  //   //API
  List<PhotosModel>  photosList = []; //Array ka name nhi is liay cusotm list banani paraygi

   Future<List<PhotosModel>> getPhotosApi() async{
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

      var data = jsonDecode(response.body.toString()); //Api k response m body ati h


      if(response.statusCode==200){  //when response is successfull then 200
      photosList.clear(); //hot relaod nhi hogi dobara
      for (Map<String, dynamic> i in data) {
        photosList.add(PhotosModel.fromJson(i));

      }
      return photosList;
      }
    else{
      return photosList;
    }
   }
   //
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [    
          Expanded( 
            child: FutureBuilder(
              future: getPhotosApi(), 
              builder: (context, AsyncSnapshot<List<PhotosModel>>snapshot){
            
                if(!snapshot.hasData){
                  return const SpinKitFadingCube(size: 20,color: Colors.purple,);
                }
                else{
                 return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index){
                      //
                    //  print('Image URL: ${snapshot.data![index].thumbnailUrl}');
                      return ListTile(
                        title: Text(snapshot.data![index].title.toString()),
                        leading: 
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://via.placeholder.com/150/54176f'
                            // snapshot.data![index].url.toString(),scale: 1.0,
                          ) ,
                        ),
                      
                      );
                    }
                    );
                }
            
              }
              ),
          )
        ],
      ),
    );
  }
}