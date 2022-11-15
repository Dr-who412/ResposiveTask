import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List banners = [
    "img.png",
    "img_1.png",
    "img_2.png",
  ];
  List<Widget> icons=[
    Icon(Icons.person,color: Colors.lightBlueAccent),
    Icon(Icons.edit_notifications_outlined,color: Colors.lightBlueAccent),
    Icon(Icons.note_add,color: Colors.lightBlueAccent),
    Icon(Icons.sticky_note_2_sharp,color: Colors.lightBlueAccent),
    Icon(Icons.web,color: Colors.lightBlueAccent),
    Icon(Icons.calendar_month_outlined,color: Colors.lightBlueAccent),
    Icon(Icons.headphones,color: Colors.lightBlueAccent),
  ];
  List<Widget> labelText=[
    Text("ولي الامر"),
    Text("طلب مقابلة"),
    Text("طلب توظيف"),
    Text("نماذج"),
    Text("روابط عامة"),
    Text("رزنامة عامة"),
    Text("تواصل معنا"),
  ];
  @override
  Widget build(BuildContext context) {
    bool isPortrait=MediaQuery.of(context).orientation == Orientation.portrait;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${MediaQuery.of(context).orientation}"),
          leading: IconButton(icon: Icon(Icons.change_circle_outlined),onPressed:(){} ),
          actions: [
        IconButton(icon: Icon(Icons.exit_to_app),onPressed:(){
          SystemNavigator.pop();
        })
        ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CarouselSlider(
                  items: banners
                      .map((element) => Container(
                            margin: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 6,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/slider/${element}',
                                   width: isPortrait? MediaQuery.of(context).size.width:
                                MediaQuery.of(context).size.width/3,
                                  errorBuilder: (BuildContext context,
                                      Object exception, StackTrace? stackTrace) {
                                    return Image.asset(
                                      'assets/slider/img.png',
                                      color: Colors.black26,
                                    );
                                  },
                                  fit: BoxFit.fill,

                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height:  isPortrait? MediaQuery.of(context).size.height/5:
                  MediaQuery.of(context).size.height/3,
                    aspectRatio: 10 / 9,
                    viewportFraction: .8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 2),
                    autoPlayCurve: Curves.easeInOutBack,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection:Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isPortrait?2:4,
                ),
                  itemCount: 7,
                  itemBuilder: (BuildContext context,int index)=>  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                     elevation: 6.7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.lightBlueAccent,

                          ),
                          shape: BoxShape.circle,
                            color: Colors.white,
                            ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            icons[index],
                            SizedBox(height: 4,),
                            labelText[index],
                          ],
                        ),
                      ),
                    ),
                  ),),
            ],
          ),
        ),
      ),
    );
  }
}
