import 'package:clothes_order/widgets/widget_support.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool tshirt=false , dress=false , trouser = false , shose=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 8.0, right: 20.0 , left: 20.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Hello Areen',
            style:AppWidget.boldTextFeildStyle() ,
              ),
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(color: Colors.black , borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.shopping_cart, color: Colors.white,),)  
          ],
        ),
        SizedBox(height: 20.0,),
        Text('Hight Quality Clothes',
            style:AppWidget.headlineTextFeildStyle() ,
              ),
        Text('Discover and Get Great Clothes',
            style:AppWidget.lightlineTextFeildStyle() ,
              ),   
        SizedBox(height: 20.0,),  
        showItem(),
        SizedBox(height: 20.0,),
        Row(children: [
          Container(
            child: Column(),)
        ],)
      ],),),
    );
  }

  Widget showItem ()
  {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          GestureDetector(
            onTap: () {
              tshirt=true;
              trouser=false;
              dress=false;
              shose=false;
              setState(() {
                
              });
            },
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(color: tshirt? Colors.black: Colors.white, borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(8),
                child: Image.asset('assest/T-Shirt.png',height: 50,width: 50,fit: BoxFit.cover,color: tshirt? Colors.white: Colors.black,),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              tshirt=false;
              trouser=true;
              dress=false;
              shose=false;
              setState(() {
                
              });
            },
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(color: trouser? Colors.purple: Colors.white, borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(8),
                child: Image.asset('assest/Trouser.png',height: 50,width: 50,fit: BoxFit.cover,color: trouser? Colors.black: Colors.purple,),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              tshirt=false;
              trouser=false;
              dress=true;
              shose=false;
              setState(() {
                
              });
            },
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(color: dress? Colors.black: Colors.white, borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(8),
                child: Image.asset('assest/Dress.png',height: 50,width: 50,fit: BoxFit.cover,color: dress? Colors.white: Colors.black,),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              tshirt=false;
              trouser=false;
              dress=false;
              shose=true;
              setState(() {
                
              });
            },
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(color: shose? Colors.black: Colors.white, borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(8),
                child: Image.asset('assest/Shose.png',height: 50,width: 50,fit: BoxFit.cover,color: shose? Colors.white: Colors.black,),
              ),
            ),
          ),
        ],
        )  ;
  }
}

