import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../shared/componant/componant.dart';

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
  List<Widget> icons = [
    Icon(Icons.person, color: Colors.lightBlueAccent),
    Icon(Icons.edit_notifications_outlined, color: Colors.lightBlueAccent),
    Icon(Icons.note_add, color: Colors.lightBlueAccent),
    Icon(Icons.sticky_note_2_sharp, color: Colors.lightBlueAccent),
    Icon(Icons.web, color: Colors.lightBlueAccent),
    Icon(Icons.calendar_month_outlined, color: Colors.lightBlueAccent),
    Icon(Icons.headphones, color: Colors.lightBlueAccent),
  ];
  List labelText = [
    "ولي الامر",
    "طلب مقابلة",
    "طلب توظيف",
    "نماذج",
    "روابط عامة",
    "رزنامة عامة",
    "تواصل معنا",
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${MediaQuery.of(context).orientation}"),
          leading: IconButton(
              icon: Icon(Icons.change_circle_outlined), onPressed: () {}),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
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
                      .map((element) => Card(
                        margin: EdgeInsets.symmetric(vertical: 6),

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/slider/${element}',
                            width: isPortrait
                                ? MediaQuery.of(context).size.width
                                : MediaQuery.of(context).size.width ,
                            errorBuilder: (BuildContext context,
                                Object exception,
                                StackTrace? stackTrace) {
                              return Image.asset(
                                'assets/slider/img.png',
                                color: Colors.black26,
                              );
                            },
                            fit: BoxFit.fill,
                          ),
                        ),
                      ))
                      .toList(),
                  options: CarouselOptions(
                    height: isPortrait
                        ? MediaQuery.of(context).size.height / 5
                        : MediaQuery.of(context).size.height/ 3,
                    aspectRatio:  1,
                    viewportFraction: isPortrait? 0.7:.5,
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
              StaggeredGrid.count(
                  crossAxisCount: isPortrait?2:4,
                  children: icons.map((element) {
                    return StaggeredGridTile.count(
                      crossAxisCellCount: (isPortrait&&icons.length % 2 != 0 && element == icons.last)? 2: 1,
                      mainAxisCellCount: 1,
                      child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: gridItem(
                              icon: element,
                              lable: "${labelText[icons.indexOf(element)]}")),
                    );
                  }).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
