import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puresofttask1/modules/cubit/state.dart';

import '../../model/sectionModel.dart';
import '../../shared/componant/constant.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit() : super (InitState());
  static HomeCubit get(context)=> BlocProvider.of(context);

  File? pickedImage;
  final ImagePicker picker = ImagePicker();
  bool PickedDone=false;
  Future<File?> getImage() async {
    await picker.getImage(source: ImageSource.gallery).then((value) {
      final pickFile =value ;
      if (pickFile != null) {
        pickedImage=  File(pickFile.path);
        emit(PickedImageDone());
        print(pickFile.path);
      } else {
        print("No Image selected");
      }
    });

  }
  //one signal
  Future <void> initplatformState()async{
    OneSignal.shared.setAppId(ONESIGNALID);
  }
  //dataBase

  late Database database;
  void CreateDB(){
    openDatabase(
      'task.db',
      version:1,
      onCreate: (database, version) {
        print ("data base created");
        database.execute('CREATE TABLE TASKS (id INTEGER PRIMARY KEY,title TEXT,image TEXT)')
            .then((value) {
          print("table creayted");

        }).catchError((error){
          print("error on create: $error");
        });

      },
      onOpen: (database) {
        getDB(database);
        print('database opend');

      },
    ).then((value) {
      database = value;
      emit(CreateDBState());
    });
  }
 List <Section>? sectionData=[];
  void getDB(Database database){
    sectionData=[];
    print("get %%%");
    database.rawQuery('SELECT * FROM TASKS').then((value){
      if(value.isEmpty){print("empty data");}
      value.forEach((element) {
         sectionData?.add(Section.fromJson(element));
         print(sectionData?.last);
      });

    }).whenComplete(() =>
        emit(GetDBState())
    );
  }

  insertToDb({
    required String? title,
    required File? image,
  }) async {
    String? base64img;

    await image?.readAsBytes().then((value){
      if(image!=null){ base64img = base64Encode(value);}
       print(base64img);
    });
    database.transaction((txn) async {
      await txn
          .rawInsert(
        'INSERT INTO TASKS (title,image) VALUES("$title","${base64img??''}")',
      )
          .then((value) {
        print("$value inserted seccessfully");
        getDB(database);
        print("$value inserted seccessfully");
        emit(InsertToDBState());

      }).catchError((error) {
        print("error when insert to table ${error.toString()}");
      });
      return null;
    });
  }
}
// var bytes = await widget.image.readAsBytes();
// var base64img = base64Encode(bytes);