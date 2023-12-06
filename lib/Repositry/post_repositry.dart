// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:muzammil_apis/Models/post_model.dart';


// class PostRepositry{

//   Future<PostModel> fetchgetPostApi() async{
  
//      String url = 'https://jsonplaceholder.typicode.com/posts';

//     final response = await http.get(Uri.parse(url));

//     if (kDebugMode) {
//       print(response.body);
//     }

//     if(response.statusCode==200){  //when response is successfull then 200
//       final body = jsonDecode(response.body); //Api k response m body ati h
//       return PostModel.fromJson(body);  //TopNewsHeadlinesModel is coming from model clasee
//     }
//     throw Exception("error");
//   }

  
//   }