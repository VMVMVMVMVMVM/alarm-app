import 'package:alarm_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'alarm_page.dart';
import 'package:alarm_app/alarm_page.dart';
import 'package:alarm_app/clock_page.dart';
import 'package:alarm_app/data.dart';
import 'package:alarm_app/enums.dart';
import 'package:alarm_app/menu_info.dart';
import 'package:alarm_app/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor:CustomColors.secHandColor,
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuInfo) =>
                    buildMenuButton(currentMenuInfo as MenuInfo))
                .toList(),
          ),
          VerticalDivider(
            color: Colors.white,
            thickness: 1,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
                builder: (BuildContext context, MenuInfo value, Widget? child) {
              if (value.menuType == MenuType.clock)
                return ClockPage();
              else
                (value.menuType == MenuType.alarm);
              return Alarmpage();
              // else
              //   return Container(
              //     child: RichText(
              //       text: TextSpan(
              //         style: TextStyle(fontSize: 20),
              //         children: <TextSpan>[
              //           TextSpan(text: 'Upcoming Tutorial\n'),
              //           TextSpan(
              //             text: value.title,
              //             style: TextStyle(
              //               fontSize: 48,
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget? child) {
        return TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(12),
              backgroundColor: currentMenuInfo.menuType == value.menuType
                  ? Colors.white54
                  : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              )),
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: [
              Image.asset(
                currentMenuInfo.imageSource,
                height: 50,
                width: 50,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                currentMenuInfo.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
//'assets/Clock1.png'
