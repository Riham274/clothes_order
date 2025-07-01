import 'package:clothes_order/pages/details.dart';
import 'package:clothes_order/service/database.dart';
import 'package:clothes_order/service/shared_pref.dart';
import 'package:clothes_order/widgets/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool tshirt=false , dress=false , trouser = false , shose=false;//for colors
  Stream? clothesIthemStream; //for receiving data from yhe firebase
  String? userName; 
 
 //getting the data from firebase for home 
  ontheload()async{
    clothesIthemStream= await databasMethods().getClothesItem('T-Shirt');
    String? name = await SharedPreferenceHelper().getUserName();
    setState(() {
      userName=name;
    });
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }
//showing the items vertically
  Widget allItemsVertivally(){
    return StreamBuilder(stream: clothesIthemStream, builder: (context, AsyncSnapshot snapshot){
    return snapshot.hasData? ListView.builder(
      padding: EdgeInsets.zero, //no padding
      itemCount: snapshot.data.docs.length,
      shrinkWrap: true, //حتى توخد اقل حجم بتحتاجه
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index ){
    DocumentSnapshot ds=snapshot.data.docs[index];
    return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(detail: ds['Detail'],name: ds['Name'],price: ds['Price'],image: ds['Image'])));
                        },
                        child: Container(
                   margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child:Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                                   width: 100,
                                   height: 100,
                                   decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   image: DecorationImage(
                                      image: NetworkImage(ds['Image']),
                                      fit: BoxFit.cover),
                            ),  
                            ),
                            SizedBox(width: 20.0,),
                            Column(
                              children: [
                                Container(
                                  width:  MediaQuery.of(context).size.width /2,
                                  child: Text(ds['Name'],style: AppWidget.semiBoldTextFeildStyle(),)),
                                SizedBox(height: 5,),  
                                Container(
                                  width:  MediaQuery.of(context).size.width /2,
                                  child: Text('Bow-tie, long sleeve, chiffon',style: AppWidget.lightlineTextFeildStyle(),)),  
                                SizedBox(height: 5,),  
                                Container(
                                  width:  MediaQuery.of(context).size.width /2,
                                  child: Text("\$"+ds['Price'],style: AppWidget.semiBoldTextFeildStyle(),)),  
                              ],
                            )
                      ],
                    ),
                  ) ,
                  ),
                )
                      );

    }): CircularProgressIndicator();
    });
  }

//showing items horisontally
  Widget allItems(){
    return StreamBuilder(stream: clothesIthemStream, builder: (context, AsyncSnapshot snapshot){
    return snapshot.hasData? ListView.builder(
      padding: EdgeInsets.zero, //no padding
      itemCount: snapshot.data.docs.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index ){
    DocumentSnapshot ds=snapshot.data.docs[index];
    return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(detail: ds['Detail'],name: ds['Name'],price: ds['Price'],image: ds['Image'])));
                        },
                        child: Container(
                          margin: EdgeInsets.all(4),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: EdgeInsets.all(14),
                             child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                   width: 100,
                                   height: 100,
                                   decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   image: DecorationImage(
                                      image: NetworkImage(ds['Image']),
                                      fit: BoxFit.cover),
                            ),  
                            ),
                            Text(ds['Name'],
                            style: AppWidget.semiBoldTextFeildStyle(),),
                  
                            Text('Light and chic',
                            style: AppWidget.lightlineTextFeildStyle(),),
                            
                            Text("\$"+ds['Price'],style: AppWidget.semiBoldTextFeildStyle(),)
                          ],),)
                          ),
                        ),
                      );

    }): CircularProgressIndicator();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
           margin: EdgeInsets.only(top: 8.0, left: 20.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hello, $userName',
                      style:AppWidget.boldTextFeildStyle() ,
                        ),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(color: Colors.black , borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.shopping_cart, color: Colors.white,),)  
                    ],
                  ),
                
                SizedBox(height: 15.0,),
                Text('Hight Quality Clothes',
                    style:AppWidget.headlineTextFeildStyle() ,
                      ),
                Text('Discover and Get Great Clothes',
                    style:AppWidget.lightlineTextFeildStyle() ,
                      ),   
                SizedBox(height: 20.0,),  
                showItem(),
                SizedBox(height: 30.0,),

                Container(
                  height: 200,
                  child: allItems()),
                SizedBox(height: 20.0,),
                allItemsVertivally()
                
              ],),
            
            ),
        ),
      ),
    );
  }
// Showing the list of possible items(t-shirt.....)
  Widget showItem ()
  {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          GestureDetector(
            onTap: () async{
              tshirt=true;
              trouser=false;
              dress=false;
              shose=false;
              clothesIthemStream= await databasMethods().getClothesItem('T-Shirt');
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
            onTap: () async{
              tshirt=false;
              trouser=true;
              dress=false;
              shose=false;
              clothesIthemStream= await databasMethods().getClothesItem('Pants');
              setState(() {
                
              });
            },
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(color: trouser? Colors.black: Colors.white, borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(8),
                child: Image.asset('assest/Trouser.png',height: 50,width: 50,fit: BoxFit.cover,color: trouser? Colors.white: Colors.black,),
              ),
            ),
          ),
          GestureDetector (
            onTap: () async {
              tshirt=false;
              trouser=false;
              dress=true;
              shose=false;
              clothesIthemStream= await databasMethods().getClothesItem('Dress');
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
            onTap: () async{
              tshirt=false;
              trouser=false;
              dress=false;
              shose=true;
              clothesIthemStream= await databasMethods().getClothesItem('Shoes');
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
        );
  }
}

