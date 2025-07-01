import 'package:clothes_order/pages/home.dart';
import 'package:clothes_order/pages/order.dart';
import 'package:clothes_order/pages/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0; // رقم الصفحة الحالية (0 = home، 1 = order، 2 = profile)
  late List<Widget> pages;   
  late Home homepage; //object from each class(page)
  late Profile profile;
  late Order order;

  @override
   void initState() {
    homepage = Home();
    order = Order();
    profile = Profile();
    pages = [ homepage,  order, profile];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
     bottomNavigationBar: CurvedNavigationBar(  //عشان الشكل يكون منحني
          height: 50,
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: Duration(milliseconds: 500), //مدة الحركة لما انتقل بين الايقونات
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },

          items: [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),

            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
    
            Icon(
              Icons.person_outline,
              color: Colors.white,
            )
          ]
          ),
    body: pages[currentTabIndex], 
    );
  }
}