import 'package:active_ecommerce_flutter/data_model/ask_quotation_response.dart';
import 'package:active_ecommerce_flutter/helpers/value_checker_helper.dart';
import 'package:active_ecommerce_flutter/screens/shipping_info.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/ui_sections/drawer.dart';
import 'package:flutter/widgets.dart';
import 'package:active_ecommerce_flutter/repositories/cart_repository.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:toast/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Cart extends StatefulWidget {
  Cart({Key key, this.has_bottomnav}) : super(key: key);
  final bool has_bottomnav;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _mainScrollController = ScrollController();
  TextEditingController quatityController = TextEditingController();
  var _shopList = [];
  bool _isInitial = true;
  var _cartTotal = 0.00;
  var _cartTotalString = ". . .";
  var cartIndexPrice;
  var cartIndexPriceBeforeAskQuotation;
  var cartPressCheck = 0;
  AskQuotationResponse quotationResponse;
  var askQuotationCounter = 0;
  var shippingCounter = 1;
  var previousTotoal;
  var totalPriceDIfferenceCounter = 0;
  bool isQuotationReceived = false;
  String quantityByTextField;
  String hintText = 'hint';
  List<String> hintList = [];
  FocusNode focusNode = FocusNode();
  var _qntyController = <TextEditingController>[];
  bool flag = true;
  int buttonCounter = 0;
  int quantityCounter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*print("user data");
    print(is_logged_in.$);
    print(access_token.value);
    print(user_id.$);
    print(user_name.$);*/
    // cartIndexPriceBeforeAskQuotation.load();
    // print(cartIndexPriceBeforeAskQuotation.$);
    buttonCounter = 0;

    askQuotationCounter_saved.load();
    print(askQuotationCounter_saved.$);
    if (is_logged_in.$ == true) {
      fetchData();
    }

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
      } else {
        hintText = '';
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    _mainScrollController.dispose();
  }

  // void setFocus() {
  //   FocusScope.of(context).requestFocus(focusNode);
  // }
  void nothing() {
    print("Nothing");
  }

  fetchData() async {
    var cartResponseList =
        await CartRepository().getCartResponseList(user_id.$);

    if (cartResponseList != null && cartResponseList.length > 0) {
      _shopList = cartResponseList;
    }
    _isInitial = false;
    flag = true;

    print('qntyc: $quantityCounter');
    print(flag);
    getSetCartTotal();
    // if (askQuotationCounter_saved.$ == "1") {
    //   if (previousTotalSaved.$ != _cartTotal) {
    //     totalPriceDIfferenceCounter++;
    //     shippingCounter--;
    //     //ValueCheckerHelper().clearAskQuotationCounter();
    //   }
    // }

    if (is_wholesale.$ == 1 &&
        askQuotationCounter_saved.$ == 1 &&
        cartResponseList.length == 0) {
      ValueCheckerHelper().clearAskQuotationCounter();
      setState(() {});
    }
    if (askQuotationCounter_saved.$ == 1) {
      fetchSummary();
    }
    setState(() {});
    // print(totalPriceDIfferenceCounter);
    // print(shippingCounter);
  }

  fetchSummary() async {
    var cartSummaryResponse = await CartRepository().getCartSummaryResponse();

    if (cartSummaryResponse != null) {
      isQuotationReceived = cartSummaryResponse.result;
      // ValueCheckerHelper().clearAskQuotationCounter();
      // ToastComponent.showDialog(cartSummaryResponse.message, context,
      //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      setState(() {});
    }
  }

  getSetCartTotal() {
    _cartTotal = 0.00;
    if (_shopList.length > 0) {
      _shopList.forEach((shop) {
        if (shop.cart_items.length > 0) {
          shop.cart_items.forEach((cartItem) {
            _cartTotal += (cartItem.price + cartItem.tax) * cartItem.quantity;
            _cartTotalString = "${cartItem.currency_symbol}$_cartTotal";
            // _qntyController[].text = cart_item.quantity.toString();
            // _qntyController.addAll(cart_item.quantity.text);
            print(quatityController.text);
          });
        }
      });
    }
    print('cart total: $_cartTotal');

    setState(() {});
  }

  partialTotalString(index) {
    var partialTotal = 0.00;
    var partialTotalString = "";
    if (_shopList[index].cart_items.length > 0) {
      _shopList[index].cart_items.forEach((cartItem) {
        partialTotal += (cartItem.price + cartItem.tax) * cartItem.quantity;
        partialTotalString = "${cartItem.currency_symbol}$partialTotal";
        hintList.add(cartItem.quantity.toString());
      });
    }

    return partialTotalString;
  }

  onField(sellerIndex, itemIndex) {
    if (_shopList[sellerIndex].cart_items[itemIndex].quantity <
        _shopList[sellerIndex].cart_items[itemIndex].upper_limit) {
      _shopList[sellerIndex].cart_items[itemIndex].quantity = quatityController;
      getSetCartTotal();
      setState(() {});
    } else {
      ToastComponent.showDialog(
          "${AppLocalizations.of(context).cart_screen_cannot_order_more_than} ${_shopList[sellerIndex].cart_items[itemIndex].upper_limit} ${AppLocalizations.of(context).cart_screen_items_of_this}",
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
    }
  }

  onQuantityIncrease(sellerIndex, itemIndex) {
    if (_shopList[sellerIndex].cart_items[itemIndex].quantity <
        _shopList[sellerIndex].cart_items[itemIndex].upper_limit) {
      _shopList[sellerIndex].cart_items[itemIndex].quantity++;

      getSetCartTotal();
      setState(() {});
    } else {
      ToastComponent.showDialog(
          "${AppLocalizations.of(context).cart_screen_cannot_order_more_than} ${_shopList[sellerIndex].cart_items[itemIndex].upper_limit} ${AppLocalizations.of(context).cart_screen_items_of_this}",
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
    }
  }

  onQuantityTextFeild(sellerIndex, itemIndex, String controller) {
    setState(() {});
    if (_shopList[sellerIndex].cart_items[itemIndex].quantity <
        _shopList[sellerIndex].cart_items[itemIndex].upper_limit) {
      _shopList[sellerIndex].cart_items[itemIndex].quantity =
          int.parse(controller);
      getSetCartTotal();
      setState(() {});
    } else {
      ToastComponent.showDialog(
          "${AppLocalizations.of(context).cart_screen_cannot_order_more_than} ${_shopList[sellerIndex].cart_items[itemIndex].upper_limit} ${AppLocalizations.of(context).cart_screen_items_of_this}",
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
    }
  }

  onQuantityDecrease(sellerIndex, itemIndex) {
    if (_shopList[sellerIndex].cart_items[itemIndex].quantity >
        _shopList[sellerIndex].cart_items[itemIndex].lower_limit) {
      _shopList[sellerIndex].cart_items[itemIndex].quantity--;

      getSetCartTotal();
      setState(() {});
    } else {
      ToastComponent.showDialog(
          "${AppLocalizations.of(context).cart_screen_cannot_order_more_than} ${_shopList[sellerIndex].cart_items[itemIndex].lower_limit} ${AppLocalizations.of(context).cart_screen_items_of_this}",
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
    }
  }

  onPressDelete(cartId) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.only(
                  top: 16.0, left: 2.0, right: 2.0, bottom: 2.0),
              content: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  AppLocalizations.of(context).cart_screen_sure_remove_item,
                  maxLines: 3,
                  style: TextStyle(color: MyTheme.font_grey, fontSize: 14),
                ),
              ),
              actions: [
                FlatButton(
                  child: Text(
                    AppLocalizations.of(context).cart_screen_cancel,
                    style: TextStyle(color: MyTheme.medium_grey),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
                FlatButton(
                  color: MyTheme.soft_accent_color,
                  child: Text(
                    AppLocalizations.of(context).cart_screen_confirm,
                    style: TextStyle(color: MyTheme.dark_grey),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    confirmDelete(cartId);
                  },
                ),
              ],
            ));
  }

  confirmDelete(cartId) async {
    var cartDeleteResponse =
        await CartRepository().getCartDeleteResponse(cartId);

    if (cartDeleteResponse.result == true) {
      ToastComponent.showDialog(cartDeleteResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

      reset();
      fetchData();
    } else {
      ToastComponent.showDialog(cartDeleteResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    }
  }

  sendQuotation() async {
    quotationResponse = await CartRepository().askQuotation();

    if (quotationResponse.result == true) {
      ToastComponent.showDialog(quotationResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

      reset();
      fetchData();
    } else {
      ToastComponent.showDialog(quotationResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    }
    askQuotationCounter_saved.load();
    previousTotalSaved.load();
  }

  onPressUpdate() {
    process(mode: "update");
  }

  onPressProceedToShipping() {
    process(mode: "proceed_to_shipping");
  }

  process({mode}) async {
    var cartIds = [];
    var cartQuantities = [];
    if (_shopList.length > 0) {
      _shopList.forEach((shop) {
        if (shop.cart_items.length > 0) {
          shop.cart_items.forEach((cartItem) {
            cartIds.add(cartItem.id);
            cartQuantities.add(cartItem.quantity);
          });
        }
      });
    }

    if (cartIds.length == 0) {
      ToastComponent.showDialog(
          AppLocalizations.of(context).cart_screen_cart_empty, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }

    var cartIdsString = cartIds.join(',').toString();
    var cartQuantitiesString = cartQuantities.join(',').toString();

    print(cartIdsString);
    print(cartQuantitiesString);

    var cartProcessResponse = await CartRepository()
        .getCartProcessResponse(cartIdsString, cartQuantitiesString);

    if (cartProcessResponse.result == false) {
      ToastComponent.showDialog(cartProcessResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      ToastComponent.showDialog(cartProcessResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

      if (mode == "update") {
        reset();
        fetchData();
      } else if (mode == "proceed_to_shipping") {
        buttonCounter++;
        setState(() {});

        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => ShippingInfo()));
        // buttonCounter == 1
        //     ?

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ShippingInfo();
        })).then((value) {
          onPopped(value);
        });
        // : nothing();
      }
    }
  }

  reset() {
    _shopList = [];
    _isInitial = true;
    _cartTotal = 0.00;
    _cartTotalString = ". . .";

    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchData();
  }

  onPopped(value) async {
    reset();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.has_bottomnav);
    //  return Directionality(
    //   textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          drawer: MainDrawer(),
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          body: Stack(
            children: [
              RefreshIndicator(
                color: MyTheme.accent_color,
                backgroundColor: Colors.white,
                onRefresh: _onRefresh,
                displacement: 0,
                child: CustomScrollView(
                  controller: _mainScrollController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: buildCartSellerList(),
                        ),
                        Container(
                          height: widget.has_bottomnav ? 140 : 100,
                        )
                      ]),
                    )
                  ],
                ),
              ),

              //have to check here ask for quation active or inactive
              // is_wholesale.$ == "1"
              //     ? Container()
              //     :

              Align(
                alignment: Alignment.bottomCenter,
                child: buildBottomContainer(),
              )
            ],
          )),
    );
  }

  Container buildBottomContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        /*border: Border(
                  top: BorderSide(color: MyTheme.light_grey,width: 1.0),
                )*/
      ),

      height: widget.has_bottomnav ? 200 : 120,
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: MyTheme.soft_accent_color),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        AppLocalizations.of(context).cart_screen_total_amount,
                        style:
                            TextStyle(color: MyTheme.font_grey, fontSize: 14),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: is_wholesale.$ == 1
                          ? Text(
                              askQuotationCounter_saved.$ != 1
                                  ? "Ask for Quotation"
                                  : askQuotationCounter_saved.$ == 1 &&
                                          isQuotationReceived == true
                                      ? _cartTotalString
                                      : "Quotation asked successfully",
                              style: TextStyle(
                                  color: MyTheme.accent_color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600))
                          : Text("$_cartTotalString",
                              style: TextStyle(
                                  color: MyTheme.accent_color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 32) * (1 / 3),
                    height: 38,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: MyTheme.textfield_grey, width: 1),
                        borderRadius: app_language_rtl.$
                            ? const BorderRadius.only(
                                topLeft: const Radius.circular(0.0),
                                bottomLeft: const Radius.circular(0.0),
                                topRight: const Radius.circular(8.0),
                                bottomRight: const Radius.circular(8.0),
                              )
                            : const BorderRadius.only(
                                topLeft: const Radius.circular(8.0),
                                bottomLeft: const Radius.circular(8.0),
                                topRight: const Radius.circular(0.0),
                                bottomRight: const Radius.circular(0.0),
                              )),
                    child: FlatButton(
                      minWidth: MediaQuery.of(context).size.width,
                      //height: 50,
                      color: MyTheme.light_grey,
                      shape: app_language_rtl.$
                          ? RoundedRectangleBorder(
                              borderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(0.0),
                              bottomLeft: const Radius.circular(0.0),
                              topRight: const Radius.circular(8.0),
                              bottomRight: const Radius.circular(8.0),
                            ))
                          : RoundedRectangleBorder(
                              borderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(8.0),
                              bottomLeft: const Radius.circular(8.0),
                              topRight: const Radius.circular(0.0),
                              bottomRight: const Radius.circular(0.0),
                            )),
                      child: Text(
                        AppLocalizations.of(context).cart_screen_update_cart,
                        style: TextStyle(
                            color: MyTheme.medium_grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        onPressUpdate();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 32) * (2 / 3),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: MyTheme.textfield_grey, width: 1),
                        borderRadius: app_language_rtl.$
                            ? const BorderRadius.only(
                                topLeft: const Radius.circular(8.0),
                                bottomLeft: const Radius.circular(8.0),
                                topRight: const Radius.circular(0.0),
                                bottomRight: const Radius.circular(0.0),
                              )
                            : const BorderRadius.only(
                                topLeft: const Radius.circular(0.0),
                                bottomLeft: const Radius.circular(0.0),
                                topRight: const Radius.circular(8.0),
                                bottomRight: const Radius.circular(8.0),
                              )),
                    child: FlatButton(
                      minWidth: MediaQuery.of(context).size.width,
                      //height: 50,
                      color: MyTheme.accent_color,
                      shape: app_language_rtl.$
                          ? RoundedRectangleBorder(
                              borderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(8.0),
                              bottomLeft: const Radius.circular(8.0),
                              topRight: const Radius.circular(0.0),
                              bottomRight: const Radius.circular(0.0),
                            ))
                          : RoundedRectangleBorder(
                              borderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(0.0),
                              bottomLeft: const Radius.circular(0.0),
                              topRight: const Radius.circular(8.0),
                              bottomRight: const Radius.circular(8.0),
                            )),
                      child: Text(
                        AppLocalizations.of(context)
                            .cart_screen_proceed_to_shipping,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed:
                          is_wholesale.$ == 1 && isQuotationReceived == false
                              ? () {
                                  ToastComponent.showDialog(
                                      "you can ship only after getting quotation",
                                      context,
                                      gravity: Toast.CENTER,
                                      duration: Toast.LENGTH_LONG);
                                }
                              : () {
                                  if (flag) {
                                    flag = false;

                                    onPressProceedToShipping();
                                  }
                                },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
// backgroundColor: Colors.white,
      backgroundColor: MyTheme.appBarColor,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState.openDrawer();
        },
        child: Builder(
          builder: (context) => Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 0.0),
            child: Container(
              child: Image.asset(
                'assets/hamburger.png',
                height: 16,
                color: MyTheme.dark_grey,
              ),
            ),
          ),
        ),
      ),
      title: Text(
        AppLocalizations.of(context).cart_screen_shopping_cart,
        style: TextStyle(
          fontSize: 16,
          // color: MyTheme.accent_color
          color: MyTheme.appBarTextColor,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  buildCartSellerList() {
    if (is_logged_in.$ == false) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context).cart_screen_please_log_in,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else if (_isInitial && _shopList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildListShimmer(item_count: 5, item_height: 100.0));
    } else if (_shopList.length > 0) {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: _shopList.length,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 0.0, top: 16.0),
                  //   child: Row(
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //         child: Text(
                  //           _shopList[index].name,
                  //           style: TextStyle(color: MyTheme.font_grey),
                  //         ),
                  //       ),
                  //       Spacer(),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //         child: Text(
                  //           partialTotalString(index),
                  //           style: TextStyle(
                  //               color: MyTheme.accent_color, fontSize: 14),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  buildCartSellerItemList(index),
                  SizedBox(
                    height: 5,
                  ),
                  is_wholesale.$ == 1 ? buildQuotation() : Container(),
                ],
              ),
            );
          },
        ),
      );
    } else if (!_isInitial && _shopList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context).cart_screen_cart_empty,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    }
  }

  SingleChildScrollView buildCartSellerItemList(sellerIndex) {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: _shopList[sellerIndex].cart_items.length,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              children: [
                buildCartSellerItemCard(sellerIndex, index),
              ],
            ),
          );
        },
      ),
    );
  }

  buildCartSellerItemCard(sellerIndex, itemIndex) {
    cartIndexPrice = (_shopList[sellerIndex].cart_items[itemIndex].price *
        _shopList[sellerIndex].cart_items[itemIndex].quantity);
    print("$cartIndexPrice " "!=" "${previousTotalSaved.$}");
    if (_qntyController.length <= itemIndex) {
      _qntyController.add(TextEditingController());
    }
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: MyTheme.light_grey, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Container(
                width: 100,
                height: 100,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/placeholder.png',
                      image: AppConfig.BASE_PATH +
                          _shopList[sellerIndex]
                              .cart_items[itemIndex]
                              .product_thumbnail_image,
                      fit: BoxFit.fitWidth,
                    ))),
            Container(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _shopList[sellerIndex]
                              .cart_items[itemIndex]
                              .product_name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              color: MyTheme.font_grey,
                              fontSize: 14,
                              height: 1.6,
                              fontWeight: FontWeight.w400),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: is_wholesale.$ == 1
                                  ? Text(is_wholesale.$ == 1 &&
                                          askQuotationCounter_saved.$ != 1
                                      ? "Ask for Quotation"
                                      : is_wholesale.$ == 1 &&
                                              isQuotationReceived == true
                                          ? _shopList[sellerIndex]
                                                  .cart_items[itemIndex]
                                                  .currency_symbol +
                                              (_shopList[sellerIndex]
                                                      .cart_items[itemIndex]
                                                      .price
                                                  //     *
                                                  // _shopList[seller_index]
                                                  //     .cart_items[
                                                  //         item_index]
                                                  //     .quantity

                                                  )
                                                  .toString()
                                          : "Successfully asked")
                                  : Text(
                                      _shopList[sellerIndex]
                                              .cart_items[itemIndex]
                                              .currency_symbol +
                                          (_shopList[sellerIndex]
                                                      .cart_items[itemIndex]
                                                      .price *
                                                  _shopList[sellerIndex]
                                                      .cart_items[itemIndex]
                                                      .quantity)
                                              .toString(),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: MyTheme.accent_color,
                                          fontSize: 14,
                                          height: 1.6,
                                          fontWeight: FontWeight.w600),
                                    ),
                            ),
                            // Spacer(),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: SizedBox(
                                height: 28,
                                child: InkWell(
                                  onTap: () {},
                                  child: IconButton(
                                    onPressed: is_wholesale.$ == 1 &&
                                            askQuotationCounter_saved.$ == 1
                                        ? () {
                                            ToastComponent.showDialog(
                                                "You can not delete after asking quotation",
                                                context,
                                                gravity: Toast.CENTER,
                                                duration: Toast.LENGTH_LONG);
                                          }
                                        : () {
                                            print("tap");
                                            print(_shopList[sellerIndex]
                                                .cart_items[itemIndex]
                                                .id);
                                            onPressDelete(_shopList[sellerIndex]
                                                .cart_items[itemIndex]
                                                .id);
                                          },
                                    icon: Icon(
                                      Icons.delete_forever_outlined,
                                      color: MyTheme.medium_grey,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Spacer(),
            Column(
              children: [
                is_wholesale.$ == 1
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 16, right: 16),
                        child: SizedBox(
                          width: 28,
                          height: 28,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Icon(
                              Icons.add,
                              color: MyTheme.accent_color,
                              size: 18,
                            ),
                            shape: CircleBorder(
                              side: new BorderSide(
                                  color: MyTheme.light_grey, width: 1.0),
                            ),
                            color: Colors.white,
                            onPressed: askQuotationCounter_saved.$ == 1
                                ? () {
                                    ToastComponent.showDialog(
                                        "Quotation is asked already, you can not perform",
                                        context,
                                        gravity: Toast.CENTER,
                                        duration: Toast.LENGTH_LONG);
                                  }
                                : () {
                                    onQuantityIncrease(sellerIndex, itemIndex);
                                    quantityCounter++;
                                  },
                          ),
                        ),
                      ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8),
                  // child: Text(
                  // _shopList[seller_index]
                  //     .cart_items[item_index]
                  //     .quantity
                  //     .toString(),
                  //   style:
                  //       TextStyle(color: MyTheme.accent_color, fontSize: 16),
                  // ),
                  child: is_wholesale.$ == 1 && askQuotationCounter_saved.$ != 1
                      ? Container(
                          height: 30,
                          width: 52,
                          // color: Colors.redAccent,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: TextFormField(
                              controller: _qntyController[itemIndex],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: 12, bottom: 12),
                                hintText: _shopList[sellerIndex]
                                    .cart_items[itemIndex]
                                    .quantity
                                    .toString(),
                                // hintText: hintList[item_index],
                              ),
                              onChanged: (value) {
                                print(_qntyController[itemIndex].text);
                                quantityByTextField =
                                    _qntyController[itemIndex].text;
                                print(quantityByTextField);

                                setState(() {});
                                onQuantityTextFeild(sellerIndex, itemIndex,
                                    quantityByTextField);
                                // onField(seller_index, item_index);
                                setState(() {});
                                // value = _qntyController[item_index].text;

                                // Future.delayed(Duration(seconds: 4), () {

                                //   // onPressUpdate();
                                //   // setState(() {});
                                // });

                                // _shopList[seller_index]
                                //     .cart_items[item_index]
                                //     .quantity = quatityController.text;
                                // getSetCartTotal();
                                // setState(() {});
                              },
                            ),
                          ),
                        )
                      : Text(
                          _shopList[sellerIndex]
                              .cart_items[itemIndex]
                              .quantity
                              .toString(),
                          style: TextStyle(
                              color: MyTheme.accent_color, fontSize: 16),
                        ),
                ),
                is_wholesale.$ == 1
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, bottom: 16, right: 16),
                        child: SizedBox(
                          width: 28,
                          height: 28,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Icon(
                              Icons.remove,
                              color: MyTheme.accent_color,
                              size: 18,
                            ),
                            height: 30,
                            shape: CircleBorder(
                              side: new BorderSide(
                                  color: MyTheme.light_grey, width: 1.0),
                            ),
                            color: Colors.white,
                            onPressed: askQuotationCounter_saved.$ == 1
                                ? () {
                                    ToastComponent.showDialog(
                                        "quotation is asked already, you can not perform",
                                        context,
                                        gravity: Toast.CENTER,
                                        duration: Toast.LENGTH_LONG);
                                  }
                                : () {
                                    onQuantityDecrease(sellerIndex, itemIndex);
                                    quantityCounter++;
                                  },
                          ),
                        ),
                      )
              ],
            )
          ]),
          // is_wholesale.$ == "1"
          //     ? RaisedButton(
          //         color: MyTheme.golden,
          //         onPressed: () {},
          //         child: Text(
          //           "Ask for Quotation",
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       )
          //     : Text('')
        ],
      ),
    );
  }

  Widget buildQuotation() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Divider(
              height: 1,
              color: MyTheme.medium_grey,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SubTotal",
                  style: TextStyle(
                      color: MyTheme.accent_color,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                Text(
                  askQuotationCounter_saved.$ != 1
                      ? "Ask for quotation first"
                      : askQuotationCounter_saved.$ == 1 &&
                              isQuotationReceived == true
                          ? _cartTotalString
                          : "Quotation asked successfully",
                  style: TextStyle(
                      color: MyTheme.accent_color,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            askQuotationCounter_saved.$ == 1
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RaisedButton(
                        color: MyTheme.golden,
                        onPressed: () {
                          // cartIndexPriceBeforeAskQuotation = cartIndexPrice;
                          // ValueCheckerHelper().saveCartPreviousPrice(
                          // cartIndexPriceBeforeAskQuotation);
                          onPressUpdate();
                          askQuotationCounter++;
                          setState(() {});
                          ValueCheckerHelper()
                              .saveAskQuotationCounter(askQuotationCounter);
                          sendQuotation();

                          // previousTotoal = _cartTotal;

                          // ValueCheckerHelper()
                          //     .saveCartPreviousTotal(previousTotoal);
                        },
                        child: Text(
                          "Ask for Quotation",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
