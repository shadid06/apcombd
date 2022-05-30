import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/login.dart';
import 'package:active_ecommerce_flutter/screens/messenger_list.dart';
import 'package:flutter/material.dart';

class LiveChat extends StatefulWidget {
  const LiveChat({Key key}) : super(key: key);

  @override
  State<LiveChat> createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 250,
      right: 0,
      child: GestureDetector(
        onTap: () {
          if (is_logged_in == true) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MessengerList();
            }));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Login();
            }));
          }
        },
        child: RotatedBox(
          quarterTurns: -3,
          child: Container(
            height: 30,
            width: 120,
            decoration: BoxDecoration(
                color: MyTheme.accent_color,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: RichText(
                text: TextSpan(
                  text: 'Live Chat  ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  children: [
                    WidgetSpan(
                      child: RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.message,
                            color: Colors.amber,
                            size: 20,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
