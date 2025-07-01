import 'package:clothes_order/pages/bottomnav.dart';
import 'package:clothes_order/pages/signup.dart';
import 'package:clothes_order/service/database.dart';
import 'package:clothes_order/service/shared_pref.dart';
import 'package:clothes_order/widgets/widget_support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
String email='',password='';
final _formkey = GlobalKey<FormState>();

TextEditingController useremailcontroller =TextEditingController(); //حتى اتحكم بالنص يلي بيدخله اليوزر بالحقول
TextEditingController userpasswordcontroller =TextEditingController();

//بنادي لما المستخدم يضغط على كبسة login 
userLogin()async{
  try{
    UserCredential userCredential = await FirebaseAuth.instance // متغير بحفظ فيه المعلومات الي دخلت فيها
        .signInWithEmailAndPassword(email: email, password: password);

    User? firebaseUser = userCredential.user;  //.user => بترجع المستخدم الي دخل حاليا

    if (firebaseUser != null) {
        String userId = firebaseUser.uid;
        databasMethods dbMethods = databasMethods(); // dbMethods => عشان اطلب بيانات المستخدم 

        var user =  await dbMethods.getUserData(userId);
        await SharedPreferenceHelper().saveUserId(userId); //خزن بيانات المستخدم وحتى لو سكر التطبيق بضل متزكر
        await SharedPreferenceHelper().saveUserEmail(useremailcontroller.text); // جيب التكست الي كتبه داخل الايميل
        await SharedPreferenceHelper().saveUserName(user!['Name'] ?? 'Null'); // اليوزر هو ماب اذا كانت مش فاضية رجعلي الاسم

        
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => BottomNav()),
      );
    }
  }on FirebaseAuthException catch(e){
    String msg = 'Incorrect username or password. Please try again.';
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg,
        style: TextStyle(fontSize: 12, color: Colors.white),), backgroundColor: Colors.red,),);

        return;  // يعني وقف تنفيذ واطلع لانه تسجيل الدخول فشل فمش لازم اروح عالصفحة التالية
  }
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack( // ستاك يعني حط العناصر فوق بعض طبقات مش تحت بعض متل العمود 
          children: [
        Container( // اول طبقة بنفسجية 
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/2,
          color: Color.fromARGB(255, 143, 52, 107),
        ),

        Container( // الطبقة البيضا
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3), //تنزل من فوق 
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white, 
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: Text(" "),
        ) ,

        Container( // الشعار والفورم الي فوق الخلفيتين
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

            Material( // فورم تسجيل الدخول
              elevation: 5.0, //ظل
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
              width: MediaQuery.of(context).size.width/1.5,
              height: MediaQuery.of(context).size.height/2,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(height: 20.0,),
                    Text("LogIn", style: AppWidget.boldTextFeildStyle(),),
                     SizedBox(height: 20.0,),
                
                   TextFormField(
                    controller: useremailcontroller,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Please Enter Email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                    hintText: 'Email', 
                    hintStyle: AppWidget.semiBoldTextFeildStyle(), 
                    prefixIcon: Icon(Icons.email_outlined)),
                   ),
                
                  SizedBox(height: 20.0,),
                
                  TextFormField(
                    controller: userpasswordcontroller,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password', 
                    hintStyle: AppWidget.semiBoldTextFeildStyle(), 
                    prefixIcon: Icon(Icons.password_outlined)),
                  ),
                
                SizedBox(height: 10.0,),
                
                
                 GestureDetector(
                  onTap: (){
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        email=useremailcontroller.text;
                        password=userpasswordcontroller.text;
                      });
                      userLogin();
                    }
                    
                  },
                   child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      width: 200,
                      decoration: BoxDecoration(color: Color.fromARGB(255, 111, 14, 72), borderRadius:  BorderRadius.circular(20)),
                      child: Center(
                        child: Text("LOGIN", style: TextStyle(
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
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
              },
              child: Text("Don't have an account? Sign up",
               style: AppWidget.semiBoldTextFeildStyle(),))   
                 ],) 
           
        ,)
      ],),),
    );
  }
}