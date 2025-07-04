import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFeildStyle(){
    return TextStyle(
          color: Colors.black,
          fontSize: 20.0 , 
          fontWeight: FontWeight.bold, 
          fontFamily: 'Poppins');
  }
    static TextStyle headlineTextFeildStyle(){
    return TextStyle(
          color: Colors.black,
          fontSize: 24.0 , 
          fontWeight: FontWeight.bold, 
          fontFamily: 'Poppins');
  }
    static TextStyle lightlineTextFeildStyle(){
    return TextStyle(
          color: Colors.black38,
          fontSize: 15.0 , 
          fontWeight: FontWeight.w500, 
          fontFamily: 'Poppins');
  }
   static TextStyle semiBoldTextFeildStyle(){
    return TextStyle(
          color: Colors.black,
          fontSize: 14.0 , 
          fontWeight: FontWeight.bold, 
          fontFamily: 'Poppins');
  }
}