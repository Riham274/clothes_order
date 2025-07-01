import 'dart:io';

import 'package:clothes_order/pages/bottomnav.dart';
import 'package:clothes_order/pages/login.dart';
import 'package:clothes_order/service/database.dart';
import 'package:clothes_order/service/shared_pref.dart';
import 'package:clothes_order/widgets/widget_support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 String email='',name='',password='';
 //manage the text inputs for each field
 TextEditingController namecontroller = TextEditingController();
 TextEditingController emailcontroller = TextEditingController();
 TextEditingController passwordcontroller = TextEditingController();

 final _formkey = GlobalKey<FormState>();

registration()async{
if(password!=null)
{
  try{
    //UserCredential is a datatype (a class) provided by the Firebase Authentication package in Flutter.
    //when calling createUserWithEmailAndPassword => it creats object of type UserCredential
    UserCredential userCredential = await FirebaseAuth.instance
    .createUserWithEmailAndPassword(email: email, password: password);
    ScaffoldMessenger.of(context).showSnackBar((SnackBar(
      backgroundColor: Colors.purpleAccent,
      content: Text('Registered Successfully',
      style:TextStyle(fontSize: 20) ,))));

      String? Id= FirebaseAuth.instance.currentUser?.uid.toString();
      Map<String,dynamic> addUserInfo={
        "Name": namecontroller.text,
        "Email": emailcontroller.text,
        "Id": Id,
      };
      
      await databasMethods().addUserDetails(addUserInfo, Id!);
      await SharedPreferenceHelper().saveUserName(namecontroller.text);
      await SharedPreferenceHelper().saveUserEmail(emailcontroller.text);
      await SharedPreferenceHelper().saveUserId(Id);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNav()));  //show the bottom nav after this 

  }on FirebaseAuthException catch(e){  //fire base exceptions in auth
  
    if(e.code=='weak-password'){
      ScaffoldMessenger.of(context).showSnackBar((SnackBar(
        backgroundColor: Colors.purpleAccent,
        content: Text('Password Provided is too weak',
        style:TextStyle(fontSize: 18) ,))));

    }
    else if(e.code=='email-already-in-use'){
      ScaffoldMessenger.of(context).showSnackBar((SnackBar(
        backgroundColor: Colors.purpleAccent,
        content: Text('Account Already exsists',
        style:TextStyle(fontSize: 18) ,))));

    }
  }
}
 }
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/2,
          color: Color.fromARGB(255, 143, 52, 107),
        ),

        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white, 
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: Text(" "),
        ) ,

        Container(
         margin: EdgeInsets.only(top: 10.0),
          child:
          Column( children: [
            Center(
              child: 
                Image.asset("assest/logo.png",
                width: 200,
                height: 130,
                 fit: BoxFit.cover,),
                 ),
            SizedBox(height: 10.0,) ,

            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
              width: MediaQuery.of(context).size.width/1.5,
              height: MediaQuery.of(context).size.height/1.8,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(height: 10.0,),
                    Text("SignUp", style: AppWidget.boldTextFeildStyle(),),
                   
                
                    SizedBox(height: 10.0,),
                
                   TextFormField(
                    controller: namecontroller,
                    validator:(value){
                      if(value==null || value.isEmpty){
                        return 'Please Enter Name';
                      }
                      return null;
                    } ,
                    decoration: InputDecoration(
                    hintText: 'Name', 
                    hintStyle: AppWidget.semiBoldTextFeildStyle(), 
                    prefixIcon: Icon(Icons.person)),
                   ),
                    SizedBox(height: 10.0,),
                
                
                   TextFormField(
                    controller: emailcontroller,
                    validator:(value){
                      if(value==null || value.isEmpty){
                        return 'Please Enter E-mail';
                      }
                      return null;
                    } ,
                    decoration: InputDecoration(
                    hintText: 'Email', 
                    hintStyle: AppWidget.semiBoldTextFeildStyle(), 
                    prefixIcon: Icon(Icons.email_outlined)),
                   ),
                
                  SizedBox(height: 10.0,),
                
                  TextFormField(
                    controller: passwordcontroller,
                    validator:(value){
                      if(value==null || value.isEmpty){
                        return 'Please Enter Password';
                      }
                      return null;
                    } ,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password', 
                    hintStyle: AppWidget.semiBoldTextFeildStyle(), 
                    prefixIcon: Icon(Icons.password_outlined)),
                  ),
            
                SizedBox(height: 10.0,),
                    
                GestureDetector(
                  onTap: ()async{
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        email=emailcontroller.text;
                        name=namecontroller.text;
                        password=passwordcontroller.text;
                      });
                      registration();
                    }
                  },
                   child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      width: 200,
                      decoration: BoxDecoration(color:Color.fromARGB(255, 111, 14, 72), borderRadius:  BorderRadius.circular(20)),
                      child: Center(
                        child: Text("SIGN UP", style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ppoppins1',
                          fontSize: 18.0,
                          fontWeight:  FontWeight.bold
                        ),),
                      ),
                    ),
                                   ),
                 ),
                          
                  ],
                ),
              ),
            ) ,
            ),
            SizedBox(height: 10.0),

            GestureDetector(
              onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=> LogIn()));},
              child: Text("Already have an account? LogIn", style: AppWidget.semiBoldTextFeildStyle(),)  
,
            )],),)
             ],),),
    );
  }
}