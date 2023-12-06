import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:muzammil_apis/Models/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //   //API
  List<PostModel>  postList = []; //Array ka name nhi is liay cusotm list banani paraygi

   Future<List<PostModel>> getPostApi() async{
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      var data = jsonDecode(response.body.toString()); //Api k response m body ati h


      if(response.statusCode==200){  //when response is successfull then 200
      postList.clear(); //hot relaod nhi hogi dobara
      for (Map<String, dynamic> i in data) {
        postList.add(PostModel.fromJson(i));

      }
      return postList;
      }
    else{
      return postList;
    }
   }
   //
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
//List ka size screen s ziada h to hamnau screen ko bata dia h
 //k screen ki sari length occupy karlaye , always wrap it          
          Expanded( 
            child: FutureBuilder(
              future: getPostApi(), 
              builder: (context, snapshot){
            
                if(!snapshot.hasData){
                  return const SpinKitFadingCube(size: 20,color: Colors.purple,);
                }
                else{
                 return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index){
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text('Title\n'+postList[index].title.toString()), concatenation
                      Text('Title',style: Theme.of(context).textTheme.bodyLarge,),
                           Text(postList[index].title.toString(),style: Theme.of(context).textTheme.bodySmall,),
                     Text('Description',style: Theme.of(context).textTheme.bodyLarge),
                            Text(postList[index].body.toString(),style: Theme.of(context).textTheme.bodySmall,),
                            //
                  //  Text(postList[index].userId.toString(),style: Theme.of(context).textTheme.bodySmall,),
                            ],
                          ),
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
//  const spinkit = SpinKitRotatingCircle(
//   color: Colors.white,
//   size: 50.0,
// );













