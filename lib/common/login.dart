import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../feature/cured_opration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controller=TextEditingController();
  TextEditingController _controller1=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100,),

            Image.asset("assets/login.jpg",height: 250,width: 250,),
            SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.only(left: 40,right: 40),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                            hintText: 'Email...',
                            labelText: 'Email',
                            prefixIcon:Icon(Icons.email_rounded) ),
                      ),
                      SizedBox(height: 6,),
                      TextField(
                        controller: _controller1,
                        decoration: InputDecoration(
                            hintText: 'Password...',
                            labelText: 'Password',

                            prefixIcon: Icon(Icons.lock)
                        ),
                      ),
                      SizedBox(height: 6,),
                      Padding(
                        padding:EdgeInsets.only(left:150,),
                        child: TextButton(
                          onPressed: (){},
                          child: Text('Froget Password?',style: TextStyle(color: Colors.black87),),

                        ),

                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 70,),
            SizedBox(
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green.shade50,
                ),
                onPressed: (){

                  FirebaseAuth.instance.createUserWithEmailAndPassword(email:_controller.text, password:_controller1.text).then((value){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CuredOpration()));
                  }).onError((error, stackTrace) {
                    AlertDialog(
                      title: Text(error.toString()),
                    );

                    print(error);});

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CuredOpration()));
                },
                child: Text('Sign in',style: TextStyle(color: Colors.black87),),
              ),
            )
          ],
        ),
      ),

    );
  }
}
