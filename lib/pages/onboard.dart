import 'package:clothes_order/pages/signup.dart';
import 'package:clothes_order/widgets/content_model.dart';
import 'package:clothes_order/widgets/widget_support.dart';
import 'package:flutter/material.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;       //to keeo track of the current slide
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);   //start from the first page 
    super.initState();
  }

  @override
  void dispose() {         //clean the controller when the page is destroyed 
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(    //creates a swipeable horizontal list
                controller: _controller,
                itemCount: contents.length,   //num of pages  from the List made in content_model page
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (BuildContext context, i) {
                  return 
                     Column(
                      children: [
                        Image.asset(
                          contents[i].image,    
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          contents[i].title,
                          style: AppWidget.headlineTextFeildStyle(),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          contents[i].description,
                          style: AppWidget.lightlineTextFeildStyle(),
                        )
                      ],
                    );
                  
                }),
          ),
           Row(
              mainAxisAlignment: MainAxisAlignment.center,  //● ○ ○   ← This tells the user they’re on page 1 of 3
              children: List.generate(
                contents.length,
                (index) => buildDot(index),
              ),
            ),
          
          GestureDetector(
            onTap: () {
              if (currentIndex == contents.length - 1) {
                Navigator.pushReplacement(     //replace the current screen 
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              }
              _controller.nextPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn);
            },
            child: Container(
              decoration: BoxDecoration(color: const Color.fromARGB(255, 111, 14, 72), borderRadius: BorderRadius.circular(20)),
              height: 40,
              margin: EdgeInsets.all(30),
              width: double.infinity,       //take up all the available horizontal space
              child: Center(
                child: Text(
                 currentIndex == contents.length - 1?"Start Shopping" : "Next",
                  style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold ,fontFamily: "Poppins"),
                ),
              ),
            ),
          )
          

        ],
      ),
    );
  }

  
  Container buildDot(int index) {
    return Container(
      height: 8.0,
      width: currentIndex == index ? 18 : 7,   //if = make it 18 else 7 
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.black38),
    );
  }
}