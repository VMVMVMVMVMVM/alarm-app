


import 'package:alarm_app/alarm_info.dart';
import 'package:alarm_app/enums.dart';
import 'package:alarm_app/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock, title: 'Clock', imageSource: 'assets/Clock1.png'),
  MenuInfo(MenuType.alarm, title: 'Alarm', imageSource: 'assets/alarm.png'),
  //MenuInfo(MenuType.timer, title: 'Timer', imageSource: 'assets/timer.png'),
  //MenuInfo(MenuType.stopwtch,
    //  title: 'Stopwatch', imageSource: 'assets/stopwatch.png'),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
      alarmDateTime:DateTime.now().add(Duration(hours: 1)),
      title: 'Office',gradientColorIndex: 0
  ),
  AlarmInfo(
      alarmDateTime:DateTime.now().add(Duration(hours: 2)),
      title: 'Sport',gradientColorIndex: 1
  ),
];
