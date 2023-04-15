import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:alarm_app/enums.dart';
import 'package:alarm_app/home_page.dart';
import 'package:alarm_app/menu_info.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async{

  WidgetsFlutterBinding.ensureInitialized();



  //var initializationSettingsAndroid = AndroidInitializationSettings('codex_logo');
  //var initializationSettings = InitializationSettings(android: initializationSettingsAndroid,);
  //flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // var initializationSettingsAndroid = AndroidInitializationSettings('codex_logo');
  // var initializationSettingsIOS = IOSInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //     onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});
  // var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: ' + payload);
  //   }
  // });
  runApp (MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(MenuType.clock, imageSource: '', title: ''),
        child: HomePage(),
      ),
  ),
    );
  }


