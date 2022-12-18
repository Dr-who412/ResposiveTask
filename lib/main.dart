import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puresofttask1/modules/cubit/homeCubit.dart';
import 'package:puresofttask1/shared/blocObserver.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'modules/home.dart';

// Platform  Firebase App Id
// web       1:997717290609:web:2c7e863c423bf8695475d0
// android   1:997717290609:android:de8ad656a60472415475d0
// ios       1:997717290609:ios:8be639719066724e5475d0
//997717290609
//AAAA6EyVrnE:APA91bHbu2K_Sh8SKKnOVyBAmd8rvBCpCjxtnj5pt2j3vQQeMu2AMRfgDevc7UuGMhrrJ02V44JfX0usDAi1Tv9519c2yV9jzWOK5Fqx_gbo-kHmLKrsUCro2Gs1XTn7xgaYQJXFov1m
//Your App ID: d45c1d03-9667-4efb-a4ed-86ebbdc1bb06

void main() async {
  BlocOverrides.runZoned(() {},
    blocObserver: MyBlocObserver(),
  );
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..CreateDB()..initplatformState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}

