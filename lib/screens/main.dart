import 'dart:io';

import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/cart.dart';
import 'package:active_ecommerce_flutter/screens/category_list.dart';
import 'package:active_ecommerce_flutter/screens/home.dart';
import 'package:active_ecommerce_flutter/screens/profile.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Main extends StatefulWidget {
  Main({Key key, go_back = true}) : super(key: key);

  bool go_back;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
  var _children = [
    Home(),
    CategoryList(
      is_base_category: true,
    ),
    Home(),
    Cart(has_bottomnav: true),
    Profile()
  ];

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  void initState() {
    // TODO: implement initState
    //re appear statusbar in case it was not there in the previous page
    is_wholesale.load();
    setState(() {});
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        } else {
          showExitPopup(context);
        }
        return widget.go_back;
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          extendBody: true,
          body: _children[_currentIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          //specify the location of the FAB
          floatingActionButton: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom ==
                0.0, // if the kyeboard is open then hide, else show
            child: FloatingActionButton(
              // focusElevation: 1,
              // backgroundColor: MyTheme.accent_color,
              backgroundColor: Colors.white,
              onPressed: () {},
              tooltip: "start FAB",
              child: Container(
                  // decoration: BoxDecoration(
                  //     border: Border.all(
                  //   color: Color(0xff354f5d),
                  //   width: 1,
                  // )
                  // ),
                  margin: EdgeInsets.all(0.0),
                  child: IconButton(
                      icon: new Image.asset(
                        'assets/square_logo.png',
                        fit: BoxFit.fitWidth,
                      ),
                      tooltip: 'Action',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Filter(
                            selected_filter: "sellers",
                          );
                        }));
                      })),
              elevation: 0.0,
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 5,

            // color: Colors.transparent,
            color: Color(0xffe6e9eb),
            clipBehavior: Clip.antiAlias,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: onTapped,
                currentIndex: _currentIndex,
                backgroundColor: Colors.white.withOpacity(0.7),
                fixedColor: MyTheme.accent_color,
                unselectedItemColor: Color.fromRGBO(153, 153, 153, 1),
                // selectedItemColor: Theme.of(context).accentColor,
                items: [
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/home.png",
                        color: _currentIndex == 0
                            ? MyTheme.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                      label: "Home"
                      // label: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     AppLocalizations.of(context)
                      //         .main_screen_bottom_navigation_home,
                      //     style: TextStyle(fontSize: 12),
                      //   ),
                      // )
                      ),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/categories.png",
                        color: _currentIndex == 1
                            ? MyTheme.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                      label: "Categories"
                      // label: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     AppLocalizations.of(context)
                      //         .main_screen_bottom_navigation_categories,
                      //     style: TextStyle(fontSize: 12),
                      //   ),
                      // )
                      ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.circle,
                      color: Colors.transparent,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/cart.png",
                        color: _currentIndex == 3
                            ? MyTheme.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                      label: "Cart"
                      // label: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     is_wholesale.$ == 1
                      //         ? "WSale Cart"
                      //         : AppLocalizations.of(context)
                      //             .main_screen_bottom_navigation_cart,
                      //     style: TextStyle(fontSize: 12),
                      //   ),
                      // )
                      ),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/profile.png",
                        color: _currentIndex == 4
                            ? MyTheme.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                      label: "Profile"
                      // label: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     AppLocalizations.of(context)
                      //         .main_screen_bottom_navigation_profile,
                      //     style: TextStyle(fontSize: 12),
                      //   ),
                      // )
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to exit?"),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: Text("Yes"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade800),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child:
                            Text("No", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
