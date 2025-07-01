import 'package:clothes_order/service/database.dart';
import 'package:clothes_order/service/shared_pref.dart';
import 'package:clothes_order/widgets/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id;
  int total = 0; 
  Stream? clothesStream;

  ontheload()async{
   id= await SharedPreferenceHelper().getUserId();
   if(id != null){
    clothesStream= await databasMethods().getClothesCart(id! ); 
   setState(() {
  
     });          
   }
  }

  @override
  void initState() {
     ontheload();
    super.initState();
  } 
   
    Widget itemcart(){
    return StreamBuilder(
      stream: clothesStream, 
      builder: (context, AsyncSnapshot snapshot){
      
     if (!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
      // نحسب المجموع المشتريات
      int calculatedTotal = 0;
      for (var doc in snapshot.data.docs) {
        calculatedTotal += int.parse(doc['Total']);
      }

      // نفذ السطر بعد ماالبرنتمج يخلص من تنفيذ الشاشة الحالية
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          total = calculatedTotal;
        });
      });
      return ListView.builder(
      padding: EdgeInsets.zero, //no padding
      itemCount: snapshot.data.docs.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index ){
    DocumentSnapshot ds=snapshot.data.docs[index];
    total= total+int.parse(ds['Total']);
    return Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Material(
              elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child:Container(
            decoration: BoxDecoration(borderRadius:BorderRadius.circular(10) ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(ds["Quantity"]), 
                    ),
                ),

                SizedBox(width: 20.0,),

                ClipRRect(//to make circuler image
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                  ds["Image"], 
                  height: 90, 
                  width: 90, 
                  fit: BoxFit.cover,) , 
                  
                ),
                SizedBox(width: 20.0,),

                Column(
                  children: [
                    Text(ds["Name"],
                    style: AppWidget.semiBoldTextFeildStyle(),
                    ),
                    Text('\$'+ds["Total"],
                    style: AppWidget.semiBoldTextFeildStyle(),
                    ),
                  ],
                ) 
              ],
            ),
          ) ,
          ),
          );
    });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
                elevation: 2.0,
                child: Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Center(
                        child: Text(
                      "Clothes Cart",
                      style: AppWidget.headlineTextFeildStyle(),
                    )
                  )
               )
             ),
          SizedBox(height: 20.0,),

          Container(
            height: MediaQuery.of(context).size.height/2,
            child: itemcart(), 
          ),
          Spacer(),
          Divider(), //the line under the item
          Padding( 
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Price", 
              style: AppWidget.boldTextFeildStyle(),
              ),

              Text(
              "\$"+ total.toString(), 
              style: AppWidget.semiBoldTextFeildStyle(),
              )
            ],
          ), 
          ),
          SizedBox(height: 5.0,),
          GestureDetector(
            onTap: () {
              
            },
            child:  Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10) ),
            margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom:10.0 ),
            child: Center(
              child: Text("CheckOut", style: TextStyle(color:Colors.white, fontSize: 20.0 , fontWeight:FontWeight.bold),),
            )
            
          ) ,
          ),
         
          ],
        ),
      ),
    );
  }
}