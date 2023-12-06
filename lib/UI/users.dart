import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:muzammil_apis/Models/users_model.dart';

class UsersApiScreen extends StatefulWidget {
  const UsersApiScreen({super.key});

  @override
  State<UsersApiScreen> createState() => _UsersApiScreenState();
}

class _UsersApiScreenState extends State<UsersApiScreen> {
  //API IMPLEMENTATION
  List<UsersModel> UserList = [];  //UserModel is model class name

  Future<List<UsersModel>> getUserApi()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

          var data = jsonDecode(response.body.toString()); //Api k response m body ati h

      if(response.statusCode==200){
         UserList.clear(); //hot relaod nhi hogi dobara
      for (Map<String, dynamic> i in data) {
        UserList.add(UsersModel.fromJson(i));
      }
      return UserList;
      }
      else{
        return UserList;
      }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: getUserApi(),
             builder: (context, snapshot){
              if(!snapshot.hasData){
                return const SpinKitFadingCube(size: 20, color: Colors.red,);
              }
              return ListView.builder(
                itemCount: UserList.length,
                itemBuilder: (context, index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                 children: [
                  Text('Name:', style: Theme.of(context).textTheme.displaySmall,),
                  Text(snapshot.data![index].name.toString() , style: Theme.of(context).textTheme.bodyMedium,),
                      ],),
                      //
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                 children: [
                  Text('Email:', style: Theme.of(context).textTheme.displaySmall,),
                  Text(snapshot.data![index].email.toString() , style: Theme.of(context).textTheme.bodyMedium,),
                      ],),
            //Adress
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                 children: [
         Text('Adress:', style: Theme.of(context).textTheme.displaySmall,),
        Text(snapshot.data![index].address!.suite.toString()+
        // snapshot.data![index].address!.street.toString()+
        snapshot.data![index].address!.city.toString(),style:Theme.of(context).textTheme.bodyMedium,) ,
                      ],),
                      //PHONE
         Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                 children: [
                  Text('phone:', style: Theme.of(context).textTheme.displaySmall,),
                  Text(snapshot.data![index].phone.toString() , style: Theme.of(context).textTheme.bodyMedium,),
                      ],),
                      //Website
         Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                 children: [
                  Text('Website:', style: Theme.of(context).textTheme.displaySmall,),
                  Text(snapshot.data![index].website.toString() , style: Theme.of(context).textTheme.bodyMedium,),
                      ],),
                      //Company
         Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                 children: [
                  Text('Company:', style: Theme.of(context).textTheme.displaySmall,),
                  Text(snapshot.data![index].company!.name.toString() , style: Theme.of(context).textTheme.bodyMedium,),
                      ],),
            

                          // Text('Name:    '+snapshot.data![index].name.toString() , style: Theme.of(context).textTheme.bodyMedium,),
                          // Text('Email:   '+snapshot.data![index].email.toString()),
                          //adress
                          // Text('Adress:   '+snapshot.data![index].address!.street.toString()),
                          // Text(snapshot.data![index].address!.suite.toString()),
                          // Text(snapshot.data![index].address!.city.toString()),
                          //
                          // Text(snapshot.data![index].phone.toString()),
                          // Text(snapshot.data![index].website.toString()),
                          // Text(snapshot.data![index].company!.name.toString()),
                      
                        ],
                      ),
                    ),
                  );
                  
                });
          
             }),
        )
      ]),
    );
  }
}


    //CAN ALSO USE RICHTEXT
            //               RichText(
            //                 text: TextSpan(
            //                   children: [
            //                     TextSpan(
            //              text:'NAME:        ', style: Theme.of(context).textTheme.displaySmall,
            //              ),
            //               TextSpan(
            //  text: snapshot.data![index].name.toString() , style: Theme.of(context).textTheme.bodyMedium,
            //                     )
            //                   ],
            //                 ),
            //                 ),
                            //