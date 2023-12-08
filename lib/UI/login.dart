import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:muzammil_apis/UI/signup.dart';

// email:    eve.holt@reqres.in
// password: cityslicka
// post api doesn't need models

class LoginApiScreen extends StatefulWidget {
  const LoginApiScreen({super.key});
  @override
  State<LoginApiScreen> createState() => _SugnupScreenState();
}

class _SugnupScreenState extends State<LoginApiScreen> {
  //CONTROLLERS
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //FUNC
  void login(String email, password) async{
    try{
      Response response = await post(
        Uri.parse('https://reqres.in/api/login'),
        //
        body:{
          'email':email, //function parameters value 
          'password': password
        }
      );
      //just to print on console
      if(response.statusCode==200){
        var data = jsonDecode(response.body);
        if (kDebugMode) {
          print(data);
        }
        if (kDebugMode) {
          print('account login Successfully');
        }

      }else{
        if (kDebugMode) {
          print('Account failed to login');
        }
      }

    }
    catch(e){
      if (kDebugMode) {
        print(e.toString());
      }

    }

  }
  //
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const  Text('Login'),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height *0.2,
            ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              border:const  OutlineInputBorder(),
              hintText: "Email",hintStyle: Theme.of(context).textTheme.bodyMedium
            ),
          ),
          //
          SizedBox(height: MediaQuery.of(context).size.height *0.02,),
          
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              border:const  OutlineInputBorder(),
              hintText: "Password",hintStyle: Theme.of(context).textTheme.bodyMedium
            ),
          ),
          //Sizedbox
          SizedBox(height: MediaQuery.of(context).size.height *0.02,),
          
          SizedBox(
            height: MediaQuery.of(context).size.height *0.05,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.lightBlueAccent
              ),
              onPressed: (){
               login(emailController.text.toString(), passwordController.text.toString());
              },
               child: Text('Login',style:Theme.of(context).textTheme.bodyMedium ,)
               ),
          ),
          //
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text('Dont have an account:',style: Theme.of(context).textTheme.bodyMedium,),

          SizedBox(
            height: MediaQuery.of(context).size.height *0.10
          ),
          InkWell(child: Text('Signup',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.blue),),
          
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => SignupApiScreen()));
          },
          ),
            ],
          )
        
        ]),
      ),
    );
  }
}