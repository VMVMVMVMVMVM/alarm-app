
import 'package:alarm_app/alarm_helper.dart';
import 'package:alarm_app/theme.dart';
import 'package:alarm_app/alarm_info.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


class Alarmpage extends StatefulWidget {
  const Alarmpage({Key? key}) : super(key: key);

  @override
  State<Alarmpage> createState() => _AlarmpageState();
}

class _AlarmpageState extends State<Alarmpage> {
  String? _alarmTimeString;
  DateTime? _alarmTime;
  bool _isRepeatSelected = false;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('initialised database');
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.addAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alarm',
            style: TextStyle(
             // backgroundColor: Colors.black,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<AlarmInfo>>(
              future: _alarms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _currentAlarms = snapshot.data; //as List<AlarmInfo>?;

                  return ListView(
                    children: snapshot.data!.map<Widget>((alarm) {
                      var alarmTime =
                      DateFormat('hh:mm aa').format(alarm.alarmDateTime!);
                      var gradientColor = GradientTemplate
                          .gradientTemplate[alarm.gradientColorIndex!].colors;
                      return Container(
                        margin: EdgeInsets.only(
                          bottom: 32,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColor,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.accents.last.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: Offset(
                                4,
                                4,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.label,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Office',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: true,
                                  onChanged: (bool value) {},
                                  activeColor: Colors.white,
                                )
                              ],
                            ),
                            Text(
                              'Mon-Fri',
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  alarmTime,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                ),
                                // Icon(
                                // Icons.keyboard_arrow_down,
                                //size: 30,
                                //color: Colors.white,
                                //),
                                IconButton(
                                  onPressed: () {
                                    deleteAlarm(alarm.id);
                                  },
                                  //_alarmHelper.delete(alarm.id);

                                  icon: Icon(Icons.delete), color: Colors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }).followedBy([
                      if (_currentAlarms!.length < 5)
                        DottedBorder(
                          strokeWidth: 3,
                          color: CustomColors.clockOutline,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(24),
                          dashPattern: [5, 4],
                          child: Container(
                            decoration: BoxDecoration(
                              color: CustomColors.hourHandStatColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(24)),
                            ),
                            width: double.infinity,
                            child: MaterialButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              onPressed: () {
                                _alarmTimeString =
                                    DateFormat('HH:mm').format(DateTime.now());
                                showModalBottomSheet(
                                    useRootNavigator: true,
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24),
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: (context, setModelState) {
                                            return Container(
                                              padding: EdgeInsets.all(32),
                                              child: Column(
                                                children: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      var selectedTime =
                                                      await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                        TimeOfDay.now(),
                                                      );
                                                      if (selectedTime != null) {
                                                        final now = DateTime.now();
                                                        var selectedDateTime =
                                                        DateTime(
                                                          now.year,
                                                          now.month,
                                                          now.day,
                                                          selectedTime.hour,
                                                          selectedTime.minute,
                                                        );
                                                        _alarmTime =
                                                            selectedDateTime;
                                                        setModelState(() {
                                                          _alarmTimeString =
                                                              DateFormat('HH:mm')
                                                                  .format(
                                                                  selectedDateTime);
                                                          //selectedTime.toString();
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      _alarmTimeString!,
                                                      style: TextStyle(
                                                        fontSize: 32,
                                                      ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text('Repeat'),
                                                    trailing: Switch(
                                                      onChanged: (value) {
                                                        setModelState(() {
                                                          _isRepeatSelected = value;
                                                        });
                                                      },
                                                      value: _isRepeatSelected,
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text('Sound'),
                                                    trailing: Icon(
                                                        Icons.arrow_forward_ios),
                                                  ),
                                                  ListTile(
                                                    title: Text('Title'),
                                                    trailing: Icon(
                                                        Icons.arrow_forward_ios),
                                                  ),
                                                  FloatingActionButton.extended(
                                                    onPressed: () {
                                                      onSaveAlarm(
                                                          _isRepeatSelected);
                                                    },
                                                    icon: Icon(Icons.alarm),
                                                    label: Text('Save'),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    });
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Add Alarm',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      else
                        Center(
                            child: Text(
                              'Only 5 alarms allowed!',
                              style: TextStyle(color: Colors.white),
                            )),
                    ]).toList(),
                  );
                }
                return Center(
                  child: Text(
                    'Loading..',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

 // void scheduleAlarm(
    //  DateTime scheduledNotificationDateTime,
     // AlarmInfo alarmInfo, {required bool isRepeating}
    //  ) async {
    //var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //  'alarm_notif',
     // 'alarm_notif',
     // channelAction: 'Channel for Alarm notification',
    //  icon: 'codex_logo',
   //   sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
     // largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
   // );

   // var platformChannelSpecifics = NotificationDetails(
    //  android: androidPlatformChannelSpecifics,
   // );
 // }

  void onSaveAlarm(bool _isRepeating) {
    DateTime? scheduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime!.add(Duration(days: 1));
    var alarmInfo = AlarmInfo(
      title: 'alarm',
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms!.length,
    );
    _alarmHelper.insertAlarm(alarmInfo);
   // if (scheduleAlarmDateTime != null) {
     // scheduleAlarm(
       // scheduleAlarmDateTime,
        //alarmInfo, isRepeating:_isRepeating,
      //);
    //}
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int? id) {
    _alarmHelper.delete(id!);
    loadAlarms();
  }
}
