import 'package:active_ecommerce_flutter/screens/career.dart';
import 'package:active_ecommerce_flutter/screens/cart.dart';
import 'package:active_ecommerce_flutter/screens/change_language.dart';
import 'package:active_ecommerce_flutter/screens/common_webview_screen.dart';
import 'package:active_ecommerce_flutter/screens/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:active_ecommerce_flutter/screens/main.dart';
import 'package:active_ecommerce_flutter/screens/profile.dart';
import 'package:active_ecommerce_flutter/screens/order_list.dart';
import 'package:active_ecommerce_flutter/screens/wishlist.dart';

import 'package:active_ecommerce_flutter/screens/login.dart';
import 'package:active_ecommerce_flutter/screens/messenger_list.dart';
import 'package:active_ecommerce_flutter/screens/wallet.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/helpers/auth_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({
    Key key,
  }) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  onTapLogout(context) async {
    AuthHelper().clearUserData();

    // var logoutResponse = await AuthRepository().getLogoutResponse();
    //
    // if (logoutResponse.result == true) {
    //   ToastComponent.showDialog(logoutResponse.message, context,
    //       gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    //
    //   Navigator.push(context, MaterialPageRoute(builder: (context) {
    //     return Login();
    //   }));
    // }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Login();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xffe6e9eb),
        child: Directionality(
          textDirection:
              app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
          child: Container(
            padding: EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  is_logged_in.$ == true
                      ? ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              AppConfig.BASE_PATH + "${avatar_original.$}",
                            ),
                          ),
                          title: Text(
                            "${user_name.$}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            //if user email is not available then check user phone if user phone is not available use empty string
                            "${user_email.$ != "" && user_email.$ != null ? user_email.$ : user_phone.$ != "" && user_phone.$ != null ? user_phone.$ : ''}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                      : Text(
                          AppLocalizations.of(context)
                              .main_drawer_not_logged_in,
                          style: TextStyle(
                              // color: Color.fromRGBO(153, 153, 153, 1),
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                  Divider(),
                  // ListTile(
                  //     visualDensity:
                  //         VisualDensity(horizontal: -4, vertical: -4),
                  //     leading: Image.asset("assets/language.png",
                  //         height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                  //     title: Text(
                  //         AppLocalizations.of(context)
                  //             .main_drawer_change_language,
                  //         style: TextStyle(
                  //             // color: Color.fromRGBO(153, 153, 153, 1),
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 14)),
                  //     onTap: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return ChangeLanguage();
                  //       }));
                  //     }),
                  ListTile(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset("assets/home.png",
                          height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                      title: Text(AppLocalizations.of(context).main_drawer_home,
                          style: TextStyle(
                              // color: Color.fromRGBO(153, 153, 153, 1),
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Main();
                        }));
                      }),
                  is_logged_in.$ == true
                      ? ListTile(
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          leading: Image.asset("assets/profile.png",
                              height: 16,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                          title: Text(
                              AppLocalizations.of(context).main_drawer_profile,
                              style: TextStyle(
                                  // color: Color.fromRGBO(153, 153, 153, 1),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Profile(show_back_button: true);
                            }));
                          })
                      : Container(),
                  is_logged_in.$ == true
                      ? ListTile(
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          leading: Image.asset("assets/order.png",
                              height: 16,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                          title: Text(
                              AppLocalizations.of(context).main_drawer_orders,
                              style: TextStyle(
                                  // color: Color.fromRGBO(153, 153, 153, 1),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return OrderList(from_checkout: false);
                            }));
                          })
                      : Container(),
                  is_logged_in.$ == true
                      ? ListTile(
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          leading: Image.asset("assets/heart.png",
                              height: 16,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                          title: Text(
                              AppLocalizations.of(context)
                                  .main_drawer_my_wishlist,
                              style: TextStyle(
                                  // color: Color.fromRGBO(153, 153, 153, 1),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Wishlist();
                            }));
                          })
                      : Container(),
                  (is_logged_in.$ == true)
                      ? ListTile(
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          leading: Image.asset("assets/chat.png",
                              height: 16,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                          title: Text(
                              AppLocalizations.of(context).main_drawer_messages,
                              style: TextStyle(
                                  // color: Color.fromRGBO(153, 153, 153, 1),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MessengerList();
                            }));
                          })
                      : Container(),
                  // is_logged_in.$ == true
                  //     ? ListTile(
                  //         visualDensity:
                  //             VisualDensity(horizontal: -4, vertical: -4),
                  //         leading: Image.asset("assets/wallet.png",
                  //             height: 16,
                  //             color: Color.fromRGBO(153, 153, 153, 1)),
                  //         title: Text(
                  //             AppLocalizations.of(context).main_drawer_wallet,
                  //             style: TextStyle(
                  //                 // color: Color.fromRGBO(153, 153, 153, 1),
                  //                 color: Colors.black,
                  //                 fontWeight: FontWeight.w600,
                  //                 fontSize: 14)),
                  //         onTap: () {
                  //           Navigator.push(context,
                  //               MaterialPageRoute(builder: (context) {
                  //             return Wallet();
                  //           }));
                  //         })
                  //     : Container(),
                  is_logged_in.$ == true
                      ? ListTile(
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          leading: Image.asset("assets/cart.png",
                              height: 16,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                          title: Text(
                              // AppLocalizations.of(context).main_drawer_wallet,
                              is_wholesale.$ == 1 ? "Wholesale Cart" : "Cart",
                              style: TextStyle(
                                  // color: Color.fromRGBO(153, 153, 153, 1),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Cart(has_bottomnav: false);
                            }));
                          })
                      : Container(),
                  Divider(height: 24),
                  is_logged_in.$ == false
                      ? ListTile(
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          leading: Image.asset("assets/login.png",
                              height: 16,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                          title: Text(
                              AppLocalizations.of(context).main_drawer_login,
                              style: TextStyle(
                                  // color: Color.fromRGBO(153, 153, 153, 1),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Login();
                            }));
                          })
                      : Container(),
                  ListTile(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset("assets/success.png",
                          height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                      title: Text("Career",
                          style: TextStyle(
                              // color: Color.fromRGBO(153, 153, 153, 1),
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                      onTap: () {
                        // onTapLogout(context);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return CommonWebviewScreen(
                        //     url: "${AppConfig.RAW_BASE_URL}/career-page",
                        //     page_name: "Career",
                        //   );
                        // }));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Career()));
                      }),
                  ListTile(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset("assets/support.png",
                          height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                      title: Text("Customer Care",
                          style: TextStyle(
                              // color: Color.fromRGBO(153, 153, 153, 1),
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                      onTap: () {
                        // onTapLogout(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CommonWebviewScreen(
                            url: "${AppConfig.RAW_BASE_URL}/customer-care-page",
                            page_name: "Customer Care",
                          );
                        }));
                      }),
                  ListTile(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset("assets/contract.png",
                          height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                      title: Text("Terms and Conditions",
                          style: TextStyle(
                              // color: Color.fromRGBO(153, 153, 153, 1),
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                      onTap: () {
                        // onTapLogout(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsAndConditions()));
                      }),
                  ListTile(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset("assets/product-return.png",
                          height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                      title: Text(
                          AppLocalizations.of(context)
                              .product_details_screen_return_policy,
                          style: TextStyle(
                              // color: Color.fromRGBO(153, 153, 153, 1),
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                      onTap: () {
                        // onTapLogout(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CommonWebviewScreen(
                            url: "${AppConfig.RAW_BASE_URL}/return-refund-page",
                            page_name: AppLocalizations.of(context)
                                .product_details_screen_return_policy,
                          );
                        }));
                      }),
                  ListTile(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      leading: Image.asset("assets/livechat.png",
                          height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                      title: Text("Live Chat",
                          style: TextStyle(
                              // color: Color.fromRGBO(153, 153, 153, 1),
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                      onTap: () {
                        // onTapLogout(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CommonWebviewScreen(
                            url:
                                "https://tawk.to/chat/6279dce87b967b11798e8f24/1g2m0drql",
                            page_name: "Live Chat",
                          );
                        }));
                      }),
                  is_logged_in.$ == true
                      ? ListTile(
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          leading: Image.asset("assets/logout.png",
                              height: 16,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                          title: Text(
                              AppLocalizations.of(context).main_drawer_logout,
                              style: TextStyle(
                                  // color: Color.fromRGBO(153, 153, 153, 1),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          onTap: () {
                            onTapLogout(context);
                          })
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
