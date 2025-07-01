import 'package:clothes_order/service/auth.dart';
import 'package:clothes_order/service/shared_pref.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String?  name, email;
  String? id;
  
  onthisload()async{
  /* userName = await SharedPreferenceHelper().getUserName();
   userEmail = await SharedPreferenceHelper().getUserEmail();
   UserId = await SharedPreferenceHelper().getUserId();*/

    id= await SharedPreferenceHelper().getUserId();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {
    
    });
  }

  @override
  void initState() {
    onthisload();
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold( // error اول ما يبلش يحمل من عشان ما يعطيfirebase
      body: id==null ? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
          child: Column(children: [
              Stack(children: [
                Container(
                  padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
                  height: MediaQuery.of(context).size.height/4.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(MediaQuery.of(context).size.width, 105.0)
                    )
                  ),
                ),
                Center( child: 
                 Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/6.5),
                  child: Material(
                    elevation: 10.0, //it gives shadows
                    borderRadius: BorderRadius.circular(60),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset("assest/profile.png", height: 120, width: 120, fit: BoxFit.cover,),
                    ),
                  ),
                )),

                Padding(      //padding inside the stack from the top 
                  padding: EdgeInsets.only( top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                      name?? '', //اذا كان الاسم null بيعرض نص فارغ حتى ما ينهار التطبيق
                      style: TextStyle(
                      color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'
                    ),),],
                  ),
                ) 
              ],
            ),

            SizedBox(height: 15.0,),
            //start of the name container
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Row(children: [
                    Icon(Icons.person), SizedBox(width: 20.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,  //to make them above each other 
                      children: [
                      Text("Name", style: TextStyle(color: Colors.black, 
                                                    fontSize: 16.0, 
                                                    fontWeight: FontWeight.w600),),
                      Text(name!, style: TextStyle(color: Colors.black, 
                                                    fontSize: 15.0, 
                                                    fontWeight: FontWeight.w600),),
        
                    ],)
                  ],),),),
              ), //end of name container
        
        
            SizedBox(height: 10.0,),
            //start of the email container
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Row(children: [
                    Icon(Icons.email, ), SizedBox(width: 20.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,  //to make them above each other 
                      children: [
                      Text("Email", style: TextStyle(color: Colors.black, 
                                                    fontSize: 16.0, 
                                                    fontWeight: FontWeight.w600),),
                      Text(email?? '', style: TextStyle(color: Colors.black, 
                                                    fontSize: 15.0, 
                                                    fontWeight: FontWeight.w600),),
        
                    ],)
                  ],
        
                  ),
                ),
              ),
            ), //end of the email container
        
            SizedBox(height: 10.0,),
            //start of the terms container
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Row(children: [
                    Icon(Icons.rule,), SizedBox(width: 20.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,  //to make them above each other 
                      children: [
                      Text("Terms and Conditions", style: TextStyle(color: Colors.black, 
                                                    fontSize: 15.0, 
                                                    fontWeight: FontWeight.w600),),
                      
                    ],)
                  ],
        
                  ),
                ),
              ),
            ), // end of terms container 
        
            SizedBox(height: 10.0,),
            //start of the Delete container
            GestureDetector(
              onTap: (){
                AuthMethods().deleteuser();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 2.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(children: [
                      Icon(Icons.delete, color: Colors.black,), SizedBox(width: 20.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,  //to make them above each other 
                        children: [
                        Text("Delete Account", style: TextStyle(color: Colors.black, 
                                                      fontSize: 15.0, 
                                                      fontWeight: FontWeight.w600),),
                        
                      ],)
                    ],
              
                    ),
                  ),
                ),
              ),
            ), //end of delete container
        
            SizedBox(height: 10.0,),
            //start of the logout container
            GestureDetector(
              onTap: (){
                AuthMethods().SignOut();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 2.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(children: [
                      Icon(Icons.logout, color: Colors.black,), SizedBox(width: 20.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,  //to make them above each other 
                        children: [
                        Text("Log Out", style: TextStyle(color: Colors.black, 
                                                      fontSize: 15.0, 
                                                      fontWeight: FontWeight.w600),),
                   
              
                      ],)
                    ],
              
                    ),
                  ),
                ),
              ),
            ), //end of log out container
        
        
            
            ],
          
          ),
        ),
      ),
    );
  }
}