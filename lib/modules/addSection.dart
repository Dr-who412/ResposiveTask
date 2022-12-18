import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puresofttask1/modules/cubit/homeCubit.dart';

import '../shared/sqfl/sqflDB.dart';
import 'cubit/state.dart';

class AddSection extends StatelessWidget {
   AddSection({Key? key}) : super(key: key);
var textController= TextEditingController();
var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

     return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is InsertToDBState){
            HomeCubit.get(context).pickedImage=null;
            textController.text='';
          }
          if(state is GetDBState){
            HomeCubit.get(context).pickedImage=null;
            textController.text='';
          }
        },
        builder: (context, state) {
          var cubit=HomeCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Card(
                    elevation: 8,
                    margin: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 90),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                cubit.pickedImage==null
                                    ? Image.asset(
                                    "assets/avr.png", fit: BoxFit.cover)
                                    : Image.file(cubit.pickedImage!, fit: BoxFit.cover),
                                CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: IconButton(
                                        onPressed: () {
                                          cubit.getImage();
                                          print("object");
                                        },
                                        splashColor: Colors.transparent,
                                        icon: Icon(
                                          Icons.add_a_photo,
                                          color: Colors.black45,))),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              controller: textController,
                              maxLines: 1,
                              validator: (value){
                                if (value!.trim().isEmpty){
                                  return "can't be empty";

                                }
                                return null; 
                              },
                              decoration: InputDecoration(
                                  focusColor: Colors.black38,
                                  border: InputBorder.none,
                                  hintText: "section",
                                  hintStyle: TextStyle(color: Colors.black38)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                             if (formKey.currentState!.validate()) {
                              cubit.insertToDb(title: textController.text,image: cubit.pickedImage);
                             }
                            },
                            elevation: 4,
                            backgroundColor: Colors.indigo,
                            child: Text("add"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
  }
}

