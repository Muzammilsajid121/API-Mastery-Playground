import 'dart:io';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class UploadImageApiScreen extends StatefulWidget {
  const UploadImageApiScreen({super.key});

  @override
  State<UploadImageApiScreen> createState() => _UploadImageApiScreenState();
}

class _UploadImageApiScreenState extends State<UploadImageApiScreen> {
  //
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  //Func to pick image
  Future getImage() async{
    final PickedFile  = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if(PickedFile!= null){
      image=File(PickedFile.path);
      setState(() {
        
      });

    }else{
    print('No image Selected');
    }
  }
  //Func to upload image on server
  Future<void> uploadImage()async{
    setState(() {
      showSpinner =true;
    });
    var Stream = http.ByteStream(image!.openRead());
    Stream.cast();

    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');

    var requestOnServer = new http.MultipartRequest('POST', uri);
    requestOnServer.fields['title'] = 'Static title';

    var multiport = new http.MultipartFile(
      'image',
       Stream,
      length);

      requestOnServer.files.add(multiport);
      var response = await requestOnServer.send();

      if(response.statusCode==200){
        print('Image Upload');
        setState(() {
      showSpinner =false;
    });
      }
      else{
        print("Failde To Upload On Server");
        setState(() {
      showSpinner =false;
    });
      }
  }
  //
  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title:const  Text("Upload Image"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            InkWell(
              onTap: getImage,
              child: Container(
                color: Colors. amber,
              child: image==null? Center(child: Text("Pick Image"),):
              Container(child: Center(child:
               Image.file(File(image!.path).absolute,
              height: 150,width: 150,fit: BoxFit.cover,
              ),),)
              ),
            ),
            SizedBox( height: MediaQuery.of(context).size.height *0.2,),
            //BUTTON
            SizedBox(width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  uploadImage();
                },
               child: Text('Upload')),
            )
      
          ],
        ),
      ),
    );
  }
}