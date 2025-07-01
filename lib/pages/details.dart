import 'package:clothes_order/service/database.dart';
import 'package:clothes_order/service/shared_pref.dart';
import 'package:clothes_order/widgets/widget_support.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  String image, name, detail, price;
  Details({required this.detail,required this.image,required this.name,required this.price});
  //this is a constructor that recieves information from the home page
 

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1  , total=0;    // a:quantity of items  , total=total price a*price
  String? id;

  ontheload()async{
    id= await  SharedPreferenceHelper().getUserId();
    setState(() {
      
    });
  }
  
  @override
  void initState() {    //Called when the screen is created
    super.initState();
    ontheload();
    total=int.parse(widget.price); //it has to be ready becouse it is an int
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0 ),
        
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                   Navigator.pop(context);   //whan tapped Go back to the previous screen
                },
                child : Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
                )
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.image), // it will get the image from the details , widget=> a reference to the parent class instance (details)
                    fit: BoxFit.cover
                    )
                ),
              ),
              SizedBox(height: 15.0,),
              
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name, 
                        style: AppWidget.boldTextFeildStyle()
                        ),
                         
                    ],
                  ),
                  Spacer(),  //takes the empty space 
                  GestureDetector(        //remove item and decrement the price 
                    onTap: () {
                      if (a > 1) {
                         --a;
                         total=total-int.parse(widget.price);
                      }        
                      setState(() {
                        
                      });
                    },
                    child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Icon(Icons.remove, color: Colors.white,
                    ),
                  ),
                  ),
                  
                  
                  SizedBox(width: 20.0,),
                  Text(a.toString(), style: AppWidget.semiBoldTextFeildStyle(),), 
                  SizedBox(width: 20.0,),
                  GestureDetector(       //increment quantity and price
                    onTap: () {
                      ++a;
                      total=total+int.parse(widget.price);
                      setState(() {
                        
                      });
                    },
                    child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ) ,
                  )  
                ],
              ),
              SizedBox(width: 20.0,),
              Text(widget.detail,
              maxLines: 3,
              style: AppWidget.lightlineTextFeildStyle(),
              ),
              SizedBox(height: 20.0,),
              Row(children: [
                Text("Delivery Time" ,style: AppWidget.boldTextFeildStyle(),),
                SizedBox(width: 25.0,),
                Icon(Icons.alarm, color: Colors.black54,),
                SizedBox(width: 5.0,),
                Text("3-5 days", style: AppWidget.semiBoldTextFeildStyle(),)
              ],),
              //SizedBox(height: 50.0,),
              Spacer(),
              Padding(
                padding:EdgeInsets.only(bottom: 20.0 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Price", style: AppWidget.semiBoldTextFeildStyle(),),
                      Text('\$'+total.toString(), style: AppWidget.headlineTextFeildStyle(),)
                  ],
                  ),
                  GestureDetector(
              onTap: () async {
                 final success = await databasMethods().addClothestoCart({
                          'Name': widget.name,
                          'Quantity': a.toString(),
                          'Total': total.toString(),
                          'Image': widget.image,
                          'PricePerItem': widget.price,
                         }, id!);

  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added to cart successfully')));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to add to cart')));
  }
},
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Add to cart", style: TextStyle(color: Colors.white ,fontSize: 16.0 , fontFamily: 'Poppins'),),
                          SizedBox(width: 40.0,),
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.grey, borderRadius: BorderRadius.circular(8)
                            ),
                            child: Icon(Icons.shopping_cart_checkout_outlined, color: Colors.white,),
                          )
                        ],
                      ) ,
                    ),
                  )
                ],
                ) ,
                ),
              
              
            ],
          ),
        
      ),
    );
  }
}