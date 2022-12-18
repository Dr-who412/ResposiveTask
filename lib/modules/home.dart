import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../shared/componant/componant.dart';
import 'addSection.dart';
import 'cubit/homeCubit.dart';
import 'cubit/state.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);

  @override
  List banners = [
    "img.png",
    "img_1.png",
    "img_2.png",
  ];

   @override
   Widget build(BuildContext context) {
     bool isPortrait =
         MediaQuery.of(context).orientation == Orientation.portrait;

     return Scaffold(
         appBar: AppBar(
           title: Text("${MediaQuery.of(context).orientation}"),
           backgroundColor: Colors.indigo,
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
                             : MediaQuery.of(context).size.width,
                         errorBuilder: (BuildContext context,
                             Object exception, StackTrace? stackTrace) {
                           return Image.asset(
                             'assets/slider/avr.png',
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
                         : MediaQuery.of(context).size.height / 3,
                     aspectRatio: 1,
                     viewportFraction: isPortrait ? 0.7 : .5,
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
               BlocConsumer<HomeCubit, HomeState>(
                 listener: (context, state) {
                   // TODO: implement listener
                   if(state is GetDBState) {
                     print("state $state");

                   }
                 },
                 buildWhen: (pre,state){
                   if(state is GetDBState){
                     print("state $state");
                     return true ;
                   }
                   return false ;
                 },
                 builder: (context, state) {
                   var cubit=HomeCubit.get(context);

                   print(cubit.sectionData?.length);
                   return cubit.sectionData!.isNotEmpty? StaggeredGrid.count(
                       crossAxisCount: isPortrait ? 2 : 4,
                       children: cubit.sectionData!.map((element) {
                         return StaggeredGridTile.count(
                           crossAxisCellCount: (isPortrait &&
                               (cubit.sectionData?.length)! % 2 != 0 &&
                                   element == cubit.sectionData?.last)
                               ? 2
                               : 1,
                           mainAxisCellCount: 1,
                           child: Padding(
                               padding: const EdgeInsets.all(22.0),
                               child: gridItem(
                                   image:element.image.toString(),
                                   lable:
                                       "${element.title}"),
                         ),
                           );

                       }).toList()
                   ):Column(
                     children: [
                       SizedBox(height: 120,),
                       Text("Empty",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.black26)),
                     ],
                   );
                 },
               ),
             ],
           ),
         ),
         floatingActionButton: FloatingActionButton(
           onPressed: () {
             Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => AddSection(),
                 ));
           },
           elevation: 4,
           child: Icon(Icons.add),
           backgroundColor: Colors.indigo,
         ),
       );



   }
}

