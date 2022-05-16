import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/top_collection_products_repository.dart';
import 'package:active_ecommerce_flutter/ui_elements/product_card.dart';
import 'package:flutter/material.dart';

class CollectionProducts extends StatefulWidget {
  int collectionId;
  CollectionProducts({this.collectionId});

  @override
  State<CollectionProducts> createState() => _CollectionProductsState();
}

class _CollectionProductsState extends State<CollectionProducts> {
  ScrollController _scrollController = ScrollController();
  ScrollController _xcrollController = ScrollController();
  List<dynamic> _productList = [];
  bool _isInitial = true;

  bool _showLoadingContainer = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var productResponse = await TopCollectionProductsRepository()
        .getTopCollectionProductsResponseList(widget.collectionId);
    _productList.addAll(productResponse.data);

    _showLoadingContainer = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            buildProductList(),
            // Align(
            //     alignment: Alignment.bottomCenter,
            //     child: buildLoadingContainer())
          ],
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.white,
      backgroundColor: MyTheme.appBarColor,
      toolbarHeight: 75,
      /*bottom: PreferredSize(
          child: Container(
            color: MyTheme.textfield_grey,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(4.0)),*/
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        "Collection Products",
        style: TextStyle(color: MyTheme.appBarTextColor, fontSize: 16),
      ),
      elevation: 0.0,
      titleSpacing: 0,
      // actions: <Widget>[
      //   Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      //     child: IconButton(
      //       icon: Icon(Icons.search, color: MyTheme.dark_grey),
      //       onPressed: () {
      //         _searchKey = _searchController.text.toString();
      //         reset();
      //         fetchData();
      //       },
      //     ),
      //   ),
      // ],
    );
  }

  buildProductList() {
    if (_isInitial && _productList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildProductGridShimmer(scontroller: _scrollController));
    } else if (_productList.length > 0) {
      return SingleChildScrollView(
        controller: _xcrollController,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: GridView.builder(
          // 2
          //addAutomaticKeepAlives: true,
          itemCount: _productList.length,
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.618),
          padding: EdgeInsets.all(16),
          //physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // 3
            return ProductCard(
                id: _productList[index].id,
                image: _productList[index].thumbnailImg,
                name: _productList[index].name,
                main_price: _productList[index].unitPrice.toString(),
                stroked_price: _productList[index].purchasePrice,
                has_discount: _productList[index] = false);
          },
        ),
      );
    } else {
      return Container(); // should never be happening
    }
  }
}
