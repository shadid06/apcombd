import 'package:active_ecommerce_flutter/data_model/department_response.dart'
    as department;
import 'package:active_ecommerce_flutter/data_model/reffer_response.dart';
import 'package:active_ecommerce_flutter/helpers/value_checker_helper.dart';
import 'package:active_ecommerce_flutter/repositories/reffer_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/order_list.dart';
import 'package:active_ecommerce_flutter/screens/stripe_screen.dart';
import 'package:active_ecommerce_flutter/screens/paypal_screen.dart';
import 'package:active_ecommerce_flutter/screens/razorpay_screen.dart';
import 'package:active_ecommerce_flutter/screens/paystack_screen.dart';
import 'package:active_ecommerce_flutter/screens/iyzico_screen.dart';
import 'package:active_ecommerce_flutter/screens/bkash_screen.dart';
import 'package:active_ecommerce_flutter/screens/nagad_screen.dart';
import 'package:active_ecommerce_flutter/screens/sslcommerz_screen.dart';
import 'package:active_ecommerce_flutter/screens/flutterwave_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/repositories/payment_repository.dart';
import 'package:active_ecommerce_flutter/repositories/cart_repository.dart';
import 'package:active_ecommerce_flutter/repositories/coupon_repository.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:active_ecommerce_flutter/screens/offline_screen.dart';
import 'package:active_ecommerce_flutter/screens/paytm_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Checkout extends StatefulWidget {
  int order_id; // only need when making manual payment from order details
  bool
      manual_payment_from_order_details; // only need when making manual payment from order details
  String list;

  Checkout(
      {Key key,
      this.order_id = 0,
      this.manual_payment_from_order_details = false,
      this.list = "both"})
      : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var _selected_payment_method_index = 0;
  var _selected_payment_method = "";
  var _selected_payment_method_key = "";
  var refferList = [];

  ScrollController _mainScrollController = ScrollController();
  TextEditingController _couponController = TextEditingController();
  var _paymentTypeList = [];
  bool _isInitial = true;
  var _totalString = ". . .";
  dynamic _grandTotalValue = 0.00;
  var _subTotalString = ". . .";
  var _taxString = ". . .";
  var _shippingCostString = ". . .";
  var _discountString = ". . .";
  var _used_coupon_code = "";
  var _coupon_applied = false;
  var selectedReffer;
  List<Datum> referrs = [];
  Future<List<Datum>> referrsdropList;
  Datum selectedReferr;
  var selectedReferrId;
  Future referrData;
  var selectedReferrName;
  bool flag = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    referred_by.load();
    print(referred_by.$);
    /*print("user data");
    print(is_logged_in.$);
    print(access_token.value);
    print(user_id.$);
    print(user_name.$);*/

    fetchAll();
  }

  @override
  void dispose() {
    super.dispose();
    _mainScrollController.dispose();
  }

  fetchAll() {
    fetchList();
    fetchRefferList();

    if (is_logged_in.$ == true) {
      fetchSummary();
    }
  }

  fetchList() async {
    var paymentTypeResponseList =
        await PaymentRepository().getPaymentResponseList(list: widget.list);
    _paymentTypeList.addAll(paymentTypeResponseList);
    if (_paymentTypeList.length > 0) {
      _selected_payment_method = _paymentTypeList[0].payment_type;
      _selected_payment_method_key = _paymentTypeList[0].payment_type_key;
    }
    _isInitial = false;
    setState(() {});
  }

  fetchRefferList() async {
    var refferResponse = await RefferRepository().getRefferList();
    refferList.addAll(refferResponse.data);
    referrs.addAll(refferResponse.data);
    flag = true;
    _isInitial = false;
    setState(() {});
    setSelectedReferr();
  }

  setSelectedReferr() {
    for (int i = 0; i < refferList.length; i++) {
      if (referred_by.$ == refferList[i].id) {
        // selectedReferr = refferList[i];
        selectedReferrName = refferList[i].name;
        selectedReferrId = refferList[i].id;
        setState(() {});
        fetchDepartment(selectedReferrId);
      }
    }
  }

  department.DepartmentResponse departmentResponse;
  bool isDepartment = true;
  var departmentList = [];
  var selectedDepartment;
  var selectedDepartmentId;
  var selectedDepartmentName;
  fetchDepartment(id) async {
    departmentResponse =
        await RefferRepository().getReferredDepartment(selectedReferrId);
    departmentList.addAll(departmentResponse.data);
    isDepartment = false;
    setState(() {});
  }
  // fetchDatas() async {
  //   referrsdropList = await Datum();
  // }

  fetchSummary() async {
    var cartSummaryResponse = await CartRepository().getCartSummaryResponse();

    if (cartSummaryResponse != null) {
      _subTotalString = cartSummaryResponse.subTotal;
      _taxString = cartSummaryResponse.tax;
      _shippingCostString = cartSummaryResponse.shippingCost;
      _discountString = cartSummaryResponse.discount;
      _totalString = cartSummaryResponse.grandTotal;
      _grandTotalValue = cartSummaryResponse.grandTotalValue;
      _used_coupon_code = cartSummaryResponse.couponCode;
      _couponController.text = _used_coupon_code;
      _coupon_applied = cartSummaryResponse.couponApplied;
      setState(() {});
    }
  }

  reset() {
    _paymentTypeList.clear();
    _isInitial = true;
    _selected_payment_method_index = 0;
    _selected_payment_method = "";
    _selected_payment_method_key = "";
    setState(() {});

    reset_summary();
  }

  reset_summary() {
    _totalString = ". . .";
    _grandTotalValue = 0;
    _subTotalString = ". . .";
    _taxString = ". . .";
    _shippingCostString = ". . .";
    _discountString = ". . .";
    _used_coupon_code = "";
    _couponController.text = _used_coupon_code;
    _coupon_applied = false;

    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchAll();
  }

  onPopped(value) {
    reset();
    fetchAll();
  }

  onCouponApply() async {
    var couponCode = _couponController.text.toString();
    if (couponCode == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).checkout_screen_coupon_code_warning,
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
      return;
    }

    var couponApplyResponse =
        await CouponRepository().getCouponApplyResponse(couponCode);
    if (couponApplyResponse.result == false) {
      ToastComponent.showDialog(couponApplyResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }

    reset_summary();
    fetchSummary();
  }

  onCouponRemove() async {
    var couponRemoveResponse =
        await CouponRepository().getCouponRemoveResponse();

    if (couponRemoveResponse.result == false) {
      ToastComponent.showDialog(couponRemoveResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }

    reset_summary();
    fetchSummary();
  }

  onPressPlaceOrderOrProceed() {
    if (_selected_payment_method == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).common_payment_choice_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }

    if (_selected_payment_method == "stripe_payment") {
      if (_grandTotalValue == 0.00) {
        ToastComponent.showDialog(
            AppLocalizations.of(context).common_nothing_to_pay, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return StripeScreen(
          amount: _grandTotalValue,
          payment_type: "cart_payment",
          payment_method_key: _selected_payment_method_key,
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "paypal_payment") {
      if (_grandTotalValue == 0.00) {
        ToastComponent.showDialog(
            AppLocalizations.of(context).common_nothing_to_pay, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PaypalScreen(
          amount: _grandTotalValue,
          payment_type: "cart_payment",
          payment_method_key: _selected_payment_method_key,
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "razorpay") {
      if (_grandTotalValue == 0.00) {
        ToastComponent.showDialog(
            AppLocalizations.of(context).common_nothing_to_pay, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RazorpayScreen(
          amount: _grandTotalValue,
          payment_type: "cart_payment",
          payment_method_key: _selected_payment_method_key,
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "paystack") {
      if (_grandTotalValue == 0.00) {
        ToastComponent.showDialog(
            AppLocalizations.of(context).common_nothing_to_pay, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PaystackScreen(
          amount: _grandTotalValue,
          payment_type: "cart_payment",
          payment_method_key: _selected_payment_method_key,
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "iyzico") {
      if (_grandTotalValue == 0.00) {
        ToastComponent.showDialog(
            AppLocalizations.of(context).common_nothing_to_pay, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return IyzicoScreen(
          amount: _grandTotalValue,
          payment_type: "cart_payment",
          payment_method_key: _selected_payment_method_key,
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "bkash") {
      if (_grandTotalValue == 0.00) {
        ToastComponent.showDialog(
            AppLocalizations.of(context).common_nothing_to_pay, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return BkashScreen(
          amount: _grandTotalValue,
          payment_type: "cart_payment",
          payment_method_key: _selected_payment_method_key,
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "nagad") {
      if (_grandTotalValue == 0.00) {
        ToastComponent.showDialog(
            AppLocalizations.of(context).common_nothing_to_pay, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return NagadScreen(
          amount: _grandTotalValue,
          payment_type: "cart_payment",
          payment_method_key: _selected_payment_method_key,
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "sslcommerz_payment") {
      if (_grandTotalValue == 0.00) {
        ToastComponent.showDialog(
            AppLocalizations.of(context).common_nothing_to_pay, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SslCommerzScreen(
          amount: _grandTotalValue,
          payment_type: "cart_payment",
          payment_method_key: _selected_payment_method_key,
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "flutterwave") {
      if (_grandTotalValue == 0.00) {
        ToastComponent.showDialog(
            AppLocalizations.of(context).common_nothing_to_pay, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FlutterwaveScreen(
          amount: _grandTotalValue,
          payment_type: "cart_payment",
          payment_method_key: _selected_payment_method_key,
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "paytm") {
      if (_grandTotalValue == 0.00) {
        ToastComponent.showDialog(
            AppLocalizations.of(context).common_nothing_to_pay, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PaytmScreen(
          amount: _grandTotalValue,
          payment_type: "cart_payment",
          payment_method_key: _selected_payment_method_key,
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "wallet_system") {
      pay_by_wallet();
    } else if (_selected_payment_method == "cash_payment") {
      pay_by_cod();
    } else if (_selected_payment_method == "manual_payment" &&
        widget.manual_payment_from_order_details == false) {
      pay_by_manual_payment();
    } else if (_selected_payment_method == "manual_payment" &&
        widget.manual_payment_from_order_details == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return OfflineScreen(
          order_id: widget.order_id,
          payment_type: "manual_payment",
          details: _paymentTypeList[_selected_payment_method_index].details,
          offline_payment_id: _paymentTypeList[_selected_payment_method_index]
              .offline_payment_id,
        );
      })).then((value) {
        onPopped(value);
      });
    }
  }

  pay_by_wallet() async {
    var orderCreateResponse = await PaymentRepository()
        .getOrderCreateResponseFromWallet(
            _selected_payment_method_key, _grandTotalValue);

    if (orderCreateResponse.result == false) {
      ToastComponent.showDialog(orderCreateResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OrderList(from_checkout: true);
    }));
  }

  pay_by_cod() async {
    var orderCreateResponse = await PaymentRepository()
        .getOrderCreateResponseFromCod(_selected_payment_method_key,
            selectedReferrId, selectedDepartmentName);

    if (orderCreateResponse.result == false) {
      ToastComponent.showDialog(orderCreateResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      Navigator.of(context).pop();
      return;
    } else {
      ToastComponent.showDialog(orderCreateResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      ValueCheckerHelper().clearAskQuotationCounter();
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OrderList(from_checkout: true);
    }));
  }

  pay_by_manual_payment() async {
    var orderCreateResponse = await PaymentRepository()
        .getOrderCreateResponseFromManualPayment(_selected_payment_method_key);

    if (orderCreateResponse.result == false) {
      ToastComponent.showDialog(orderCreateResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      Navigator.of(context).pop();
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OrderList(from_checkout: true);
    }));
  }

  onPaymentMethodItemTap(index) {
    if (_selected_payment_method_key !=
        _paymentTypeList[index].payment_type_key) {
      setState(() {
        _selected_payment_method_index = index;
        _selected_payment_method = _paymentTypeList[index].payment_type;
        _selected_payment_method_key = _paymentTypeList[index].payment_type_key;
      });
    }

    //print(_selected_payment_method);
    //print(_selected_payment_method_key);
  }

  onPressDetails() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.only(
                  top: 16.0, left: 2.0, right: 2.0, bottom: 2.0),
              content: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                child: Container(
                  height: 150,
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .checkout_screen_subtotal,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: MyTheme.font_grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Spacer(),
                              Text(
                                _subTotalString,
                                style: TextStyle(
                                    color: MyTheme.font_grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .checkout_screen_shipping_cost,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: MyTheme.font_grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Spacer(),
                              Text(
                                _taxString,
                                style: TextStyle(
                                    color: MyTheme.font_grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .checkout_screen_shipping_cost,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: MyTheme.font_grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Spacer(),
                              Text(
                                _shippingCostString,
                                style: TextStyle(
                                    color: MyTheme.font_grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .checkout_screen_discount,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: MyTheme.font_grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Spacer(),
                              Text(
                                _discountString,
                                style: TextStyle(
                                    color: MyTheme.font_grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                      Divider(),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .checkout_screen_grand_total,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: MyTheme.font_grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Spacer(),
                              Text(
                                _totalString,
                                style: TextStyle(
                                    color: MyTheme.accent_color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              actions: [
                FlatButton(
                  child: Text(
                    AppLocalizations.of(context).common_close_in_all_lower,
                    style: TextStyle(color: MyTheme.medium_grey),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          bottomNavigationBar: buildBottomAppBar(context),
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
                          child: buildPaymentMethodList(),
                        ),
                        Container(
                          height: 140,
                        )
                      ]),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    /*border: Border(
                      top: BorderSide(color: MyTheme.light_grey,width: 1.0),
                    )*/
                  ),
                  height: widget.manual_payment_from_order_details ? 80 : 204,
                  //color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        widget.manual_payment_from_order_details == false
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: is_wholesale.$ == 1
                                    ? buildRefferDropDown()
                                    : buildApplyCouponRow(context),
                              )
                            : Container(),
                        is_wholesale.$ == 1
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: buildDepartmentDropDown(),
                              )
                            : Container(),
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
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .checkout_screen_total_amount,
                                    style: TextStyle(
                                        color: MyTheme.font_grey, fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      onPressDetails();
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .common_see_details,
                                      style: TextStyle(
                                        color: MyTheme.font_grey,
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Text(_totalString,
                                      style: TextStyle(
                                          color: MyTheme.accent_color,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Row buildApplyCouponRow(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 42,
          width: (MediaQuery.of(context).size.width - 32) * (2 / 3),
          child: TextFormField(
            controller: _couponController,
            readOnly: _coupon_applied,
            autofocus: false,
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)
                    .checkout_screen_enter_coupon_code,
                hintStyle:
                    TextStyle(fontSize: 14.0, color: MyTheme.textfield_grey),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: MyTheme.textfield_grey, width: 0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(8.0),
                    bottomLeft: const Radius.circular(8.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: MyTheme.medium_grey, width: 0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(8.0),
                    bottomLeft: const Radius.circular(8.0),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 16.0)),
          ),
        ),
        !_coupon_applied
            ? Container(
                width: (MediaQuery.of(context).size.width - 32) * (1 / 3),
                height: 42,
                child: FlatButton(
                  minWidth: MediaQuery.of(context).size.width,
                  //height: 50,
                  color: MyTheme.accent_color,
                  shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.only(
                    topRight: const Radius.circular(8.0),
                    bottomRight: const Radius.circular(8.0),
                  )),
                  child: Text(
                    AppLocalizations.of(context).checkout_screen_apply_coupon,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    onCouponApply();
                  },
                ),
              )
            : Container(
                width: (MediaQuery.of(context).size.width - 32) * (1 / 3),
                height: 42,
                child: FlatButton(
                  minWidth: MediaQuery.of(context).size.width,
                  //height: 50,
                  color: MyTheme.accent_color,
                  shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.only(
                    topRight: const Radius.circular(8.0),
                    bottomRight: const Radius.circular(8.0),
                  )),
                  child: Text(
                    AppLocalizations.of(context).checkout_screen_remove,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    onCouponRemove();
                  },
                ),
              )
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
// backgroundColor: Colors.white,
      backgroundColor: MyTheme.appBarColor,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        AppLocalizations.of(context).checkout_screen_checkout,
        style: TextStyle(
          fontSize: 16,
          //  color: MyTheme.accent_color
          color: MyTheme.appBarTextColor,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  buildDropDownseaarchReferrer() {
    if (_isInitial && refferList.length == 0) {
      ShimmerHelper().buildListShimmer(item_count: 1, item_height: 100.0);
    } else if (refferList.length > 0) {
      return DropdownSearch<Datum>(
        itemAsString: (Datum p) => p.name,
        // maxHeight: deviceHeight * .80,
        maxHeight: 300,
        selectedItem: selectedReferr,
        showClearButton: true,
        //showSelectedItems: true,
        onFind: (String filter) => referrs as Future<List<Datum>>,
        //items: viewModelProvider?.categoryListProvider,
        clearButton: IconButton(
          onPressed: () {
            setState(() {
              selectedReferr = null;
              selectedReferrId = null;
              print("tap");
            });
          },
          icon: Icon(Icons.close_outlined),
        ),
        label: "Referr",
        //selectedItem: widget.singleCategore,
        onChanged: (Datum data) {
          // print(data.toJson()),
          // setState(() {
          //   categoryModel = data;
          // });

          // setState(() {
          //   subDistrict = null;
          // });
          // _subDistricts = APIService.fetchSubDistricts(data.id);
          setState(() {
            selectedReferr = data;
            selectedReferrId = data.id;
            // categoryId = data!.id;
            // print(categoryId);
          });
        },
        showSearchBox: true,
      );
    }
  }

  buildRefferDropDown() {
    if (_isInitial && refferList.length == 0) {
      ShimmerHelper().buildListShimmer(item_count: 1, item_height: 100.0);
    } else if (refferList.length > 0) {
      return Container(
        // height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButton<Datum>(
            value: selectedReffer,
            // alignment: AlignmentDirectional.center,
            hint: Text(
              selectedReferrName,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              ),
            ),
            isExpanded: true,
            underline: SizedBox(),
            // decoration: InputDecoration(
            //     enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12),
            //         borderSide:
            //             BorderSide(width: 2, color: MyTheme.accent_color))),
            // icon: const Icon(Icons.arrow_downward),
            // iconSize: 24,
            // elevation: 16,
            // style: const TextStyle(color: Colors.black),
            // underline: Container(
            //   height: 2,
            //   width: double.infinity,
            //   color: Colors.deepPurpleAccent,
            // ),
            onChanged: (Datum newValue) {
              setState(() {
                selectedReffer = newValue;
                selectedReferrId = newValue.id;
                isDepartment = true;
                departmentList.clear();
                fetchDepartment(selectedReferrId);
                print(selectedReferrId);
              });
            },
            items: refferList.map<DropdownMenuItem<Datum>>((dynamic value) {
              return DropdownMenuItem<Datum>(
                value: value,
                child: Text(value.name),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  buildDepartmentDropDown() {
    if (isDepartment && departmentList.length == 0) {
      ShimmerHelper().buildListShimmer(item_count: 1, item_height: 100.0);
    } else if (departmentList.length > 0) {
      return Container(
        // height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButton<department.Datum>(
            value: selectedDepartment,
            // alignment: AlignmentDirectional.center,
            hint: Text(
              "Department",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              ),
            ),
            isExpanded: true,
            underline: SizedBox(),
            // decoration: InputDecoration(
            //     enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12),
            //         borderSide:
            //             BorderSide(width: 2, color: MyTheme.accent_color))),
            // icon: const Icon(Icons.arrow_downward),
            // iconSize: 24,
            // elevation: 16,
            // style: const TextStyle(color: Colors.black),
            // underline: Container(
            //   height: 2,
            //   width: double.infinity,
            //   color: Colors.deepPurpleAccent,
            // ),
            onChanged: (department.Datum newValue) {
              setState(() {
                selectedDepartment = newValue;
                // selectedDepartmentId = newValue.id;
                selectedDepartmentName = newValue.departmentName;
                print(selectedDepartmentName);
              });
            },
            items: departmentList
                .map<DropdownMenuItem<department.Datum>>((dynamic value) {
              return DropdownMenuItem<department.Datum>(
                value: value,
                child: Text(value.departmentName),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  buildPaymentMethodList() {
    if (_isInitial && _paymentTypeList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildListShimmer(item_count: 5, item_height: 100.0));
    } else if (_paymentTypeList.length > 0) {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: _paymentTypeList.length,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: buildPaymentMethodItemCard(index),
            );
          },
        ),
      );
    } else if (!_isInitial && _paymentTypeList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context).common_no_payment_method_added,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    }
  }

  GestureDetector buildPaymentMethodItemCard(index) {
    return GestureDetector(
      onTap: () {
        onPaymentMethodItemTap(index);
      },
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: _selected_payment_method_key ==
                      _paymentTypeList[index].payment_type_key
                  ? BorderSide(color: MyTheme.accent_color, width: 2.0)
                  : BorderSide(color: MyTheme.light_grey, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 0.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: 100,
                      height: 100,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                              /*Image.asset(
                          _paymentTypeList[index].image,
                          fit: BoxFit.fitWidth,
                        ),*/
                              FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.png',
                            image: _paymentTypeList[index].payment_type ==
                                    "manual_payment"
                                ? AppConfig.BASE_PATH +
                                    _paymentTypeList[index].image
                                : _paymentTypeList[index].image,
                            fit: BoxFit.fitWidth,
                          ))),
                  Container(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            _paymentTypeList[index].title,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: MyTheme.font_grey,
                                fontSize: 14,
                                height: 1.6,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: buildPaymentMethodCheckContainer(
                _selected_payment_method_key ==
                    _paymentTypeList[index].payment_type_key),
          )
        ],
      ),
    );
  }

  Container buildPaymentMethodCheckContainer(bool check) {
    return check
        ? Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0), color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Icon(FontAwesome.check, color: Colors.white, size: 10),
            ),
          )
        : Container();
  }

  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Container(
        color: Colors.transparent,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton(
              minWidth: MediaQuery.of(context).size.width,
              height: 50,
              color: MyTheme.accent_color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Text(
                widget.manual_payment_from_order_details
                    ? AppLocalizations.of(context).common_proceed_in_all_caps
                    : AppLocalizations.of(context)
                        .checkout_screen_place_my_order,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                // ValueCheckerHelper().clearAskQuotationCounter();
                if (flag) {
                  flag = false;
                  onPressPlaceOrderOrProceed();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
