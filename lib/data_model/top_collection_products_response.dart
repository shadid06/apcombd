// // To parse this JSON data, do
// //
// //     final topCollectionProductsResponse = topCollectionProductsResponseFromJson(jsonString);

// import 'dart:convert';

// TopCollectionProductsResponse topCollectionProductsResponseFromJson(
//         String str) =>
//     TopCollectionProductsResponse.fromJson(json.decode(str));

// String topCollectionProductsResponseToJson(
//         TopCollectionProductsResponse data) =>
//     json.encode(data.toJson());

// class TopCollectionProductsResponse {
//   TopCollectionProductsResponse({
//     this.data,
//     this.result,
//     this.message,
//   });

//   List<Datum> data;
//   bool result;
//   String message;

//   factory TopCollectionProductsResponse.fromJson(Map<String, dynamic> json) =>
//       TopCollectionProductsResponse(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         result: json["result"],
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "result": result,
//         "message": message,
//       };
// }

// class Datum {
//   Datum({
//     this.id,
//     this.name,
//     this.addedBy,
//     this.userId,
//     this.categoryId,
//     this.brandId,
//     this.photos,
//     this.thumbnailImg,
//     this.videoProvider,
//     this.videoLink,
//     this.tags,
//     this.description,
//     this.shortDescription,
//     this.isShortDescription,
//     this.unitPrice,
//     this.purchasePrice,
//     this.variantProduct,
//     this.attributes,
//     this.choiceOptions,
//     this.colors,
//     this.variations,
//     this.todaysDeal,
//     this.published,
//     this.approved,
//     this.stockVisibilityState,
//     this.cashOnDelivery,
//     this.featured,
//     this.sellerFeatured,
//     this.currentStock,
//     this.unit,
//     this.minQty,
//     this.lowStockQuantity,
//     this.discount,
//     this.discountType,
//     this.discountStartDate,
//     this.discountEndDate,
//     this.tax,
//     this.taxType,
//     this.shippingType,
//     this.shippingCost,
//     this.isQuantityMultiplied,
//     this.estShippingDays,
//     this.numOfSale,
//     this.metaTitle,
//     this.metaDescription,
//     this.metaImg,
//     this.pdf,
//     this.slug,
//     this.rating,
//     this.barcode,
//     this.digital,
//     this.auctionProduct,
//     this.fileName,
//     this.filePath,
//     this.externalLink,
//     this.externalLinkBtn,
//     this.wholesaleProduct,
//     this.createdAt,
//     this.updatedAt,
//     this.collectionId,
//     this.productId,
//     this.productTranslations,
//     this.taxes,
//   });

//   int id;
//   String name;
//   String addedBy;
//   String userId;
//   String categoryId;
//   String brandId;
//   String photos;
//   String thumbnailImg;
//   String videoProvider;
//   String videoLink;
//   String tags;
//   String description;
//   String shortDescription;
//   String isShortDescription;
//   String unitPrice;
//   dynamic purchasePrice;
//   String variantProduct;
//   String attributes;
//   String choiceOptions;
//   String colors;
//   dynamic variations;
//   String todaysDeal;
//   String published;
//   String approved;
//   String stockVisibilityState;
//   String cashOnDelivery;
//   String featured;
//   String sellerFeatured;
//   String currentStock;
//   String unit;
//   String minQty;
//   String lowStockQuantity;
//   String discount;
//   String discountType;
//   String discountStartDate;
//   String discountEndDate;
//   dynamic tax;
//   dynamic taxType;
//   dynamic shippingType;
//   String shippingCost;
//   String isQuantityMultiplied;
//   dynamic estShippingDays;
//   String numOfSale;
//   String metaTitle;
//   String metaDescription;
//   String metaImg;
//   String pdf;
//   String slug;
//   String rating;
//   dynamic barcode;
//   String digital;
//   String auctionProduct;
//   dynamic fileName;
//   dynamic filePath;
//   dynamic externalLink;
//   dynamic externalLinkBtn;
//   String wholesaleProduct;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String collectionId;
//   String productId;
//   List<ProductTranslation> productTranslations;
//   List<Tax> taxes;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         name: json["name"],
//         addedBy: json["added_by"],
//         userId: json["user_id"],
//         categoryId: json["category_id"],
//         brandId: json["brand_id"],
//         photos: json["photos"],
//         thumbnailImg: json["thumbnail_img"],
//         videoProvider: json["video_provider"],
//         videoLink: json["video_link"] == null ? null : json["video_link"],
//         tags: json["tags"],
//         description: json["description"],
//         shortDescription: json["short_description"],
//         isShortDescription: json["is_short_description"],
//         unitPrice: json["unit_price"],
//         purchasePrice: json["purchase_price"],
//         variantProduct: json["variant_product"],
//         attributes: json["attributes"],
//         choiceOptions: json["choice_options"],
//         colors: json["colors"],
//         variations: json["variations"],
//         todaysDeal: json["todays_deal"],
//         published: json["published"],
//         approved: json["approved"],
//         stockVisibilityState: json["stock_visibility_state"],
//         cashOnDelivery: json["cash_on_delivery"],
//         featured: json["featured"],
//         sellerFeatured: json["seller_featured"],
//         currentStock: json["current_stock"],
//         unit: json["unit"],
//         minQty: json["min_qty"],
//         lowStockQuantity: json["low_stock_quantity"],
//         discount: json["discount"],
//         discountType: json["discount_type"],
//         discountStartDate: json["discount_start_date"] == null
//             ? null
//             : json["discount_start_date"],
//         discountEndDate: json["discount_end_date"] == null
//             ? null
//             : json["discount_end_date"],
//         tax: json["tax"],
//         taxType: json["tax_type"],
//         shippingType: json["shipping_type"],
//         shippingCost:
//             json["shipping_cost"] == null ? null : json["shipping_cost"],
//         isQuantityMultiplied: json["is_quantity_multiplied"],
//         estShippingDays: json["est_shipping_days"],
//         numOfSale: json["num_of_sale"],
//         metaTitle: json["meta_title"],
//         metaDescription: json["meta_description"],
//         metaImg: json["meta_img"],
//         pdf: json["pdf"] == null ? null : json["pdf"],
//         slug: json["slug"],
//         rating: json["rating"],
//         barcode: json["barcode"],
//         digital: json["digital"],
//         auctionProduct: json["auction_product"],
//         fileName: json["file_name"],
//         filePath: json["file_path"],
//         externalLink: json["external_link"],
//         externalLinkBtn: json["external_link_btn"],
//         wholesaleProduct: json["wholesale_product"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         collectionId: json["collection_id"],
//         productId: json["product_id"],
//         productTranslations: List<ProductTranslation>.from(
//             json["product_translations"]
//                 .map((x) => ProductTranslation.fromJson(x))),
//         taxes: List<Tax>.from(json["taxes"].map((x) => Tax.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "added_by": addedBy,
//         "user_id": userId,
//         "category_id": categoryId,
//         "brand_id": brandId,
//         "photos": photos,
//         "thumbnail_img": thumbnailImg,
//         "video_provider": videoProvider,
//         "video_link": videoLink == null ? null : videoLink,
//         "tags": tags,
//         "description": description,
//         "short_description": shortDescription,
//         "is_short_description": isShortDescription,
//         "unit_price": unitPrice,
//         "purchase_price": purchasePrice,
//         "variant_product": variantProduct,
//         "attributes": attributes,
//         "choice_options": choiceOptions,
//         "colors": colors,
//         "variations": variations,
//         "todays_deal": todaysDeal,
//         "published": published,
//         "approved": approved,
//         "stock_visibility_state": stockVisibilityState,
//         "cash_on_delivery": cashOnDelivery,
//         "featured": featured,
//         "seller_featured": sellerFeatured,
//         "current_stock": currentStock,
//         "unit": unit,
//         "min_qty": minQty,
//         "low_stock_quantity": lowStockQuantity,
//         "discount": discount,
//         "discount_type": discountType,
//         "discount_start_date":
//             discountStartDate == null ? null : discountStartDate,
//         "discount_end_date": discountEndDate == null ? null : discountEndDate,
//         "tax": tax,
//         "tax_type": taxType,
//         "shipping_type": shippingType,
//         "shipping_cost": shippingCost == null ? null : shippingCost,
//         "is_quantity_multiplied": isQuantityMultiplied,
//         "est_shipping_days": estShippingDays,
//         "num_of_sale": numOfSale,
//         "meta_title": metaTitle,
//         "meta_description": metaDescription,
//         "meta_img": metaImg,
//         "pdf": pdf == null ? null : pdf,
//         "slug": slug,
//         "rating": rating,
//         "barcode": barcode,
//         "digital": digital,
//         "auction_product": auctionProduct,
//         "file_name": fileName,
//         "file_path": filePath,
//         "external_link": externalLink,
//         "external_link_btn": externalLinkBtn,
//         "wholesale_product": wholesaleProduct,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "collection_id": collectionId,
//         "product_id": productId,
//         "product_translations":
//             List<dynamic>.from(productTranslations.map((x) => x.toJson())),
//         "taxes": List<dynamic>.from(taxes.map((x) => x.toJson())),
//       };
// }

// class ProductTranslation {
//   ProductTranslation({
//     this.id,
//     this.productId,
//     this.name,
//     this.unit,
//     this.description,
//     this.lang,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   String productId;
//   String name;
//   String unit;
//   String description;
//   String lang;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory ProductTranslation.fromJson(Map<String, dynamic> json) =>
//       ProductTranslation(
//         id: json["id"],
//         productId: json["product_id"],
//         name: json["name"],
//         unit: json["unit"],
//         description: json["description"],
//         lang: json["lang"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_id": productId,
//         "name": name,
//         "unit": unit,
//         "description": description,
//         "lang": lang,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

// class Tax {
//   Tax({
//     this.id,
//     this.productId,
//     this.taxId,
//     this.tax,
//     this.taxType,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   String productId;
//   String taxId;
//   String tax;
//   String taxType;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory Tax.fromJson(Map<String, dynamic> json) => Tax(
//         id: json["id"],
//         productId: json["product_id"],
//         taxId: json["tax_id"],
//         tax: json["tax"],
//         taxType: json["tax_type"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_id": productId,
//         "tax_id": taxId,
//         "tax": tax,
//         "tax_type": taxType,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

// To parse this JSON data, do
//
//     final topCollectionProductsResponse = topCollectionProductsResponseFromJson(jsonString);

import 'dart:convert';

TopCollectionProductsResponse topCollectionProductsResponseFromJson(
        String str) =>
    TopCollectionProductsResponse.fromJson(json.decode(str));

String topCollectionProductsResponseToJson(
        TopCollectionProductsResponse data) =>
    json.encode(data.toJson());

class TopCollectionProductsResponse {
  TopCollectionProductsResponse({
    this.data,
    this.result,
    this.message,
  });

  List<Datum> data;
  bool result;
  String message;

  factory TopCollectionProductsResponse.fromJson(Map<String, dynamic> json) =>
      TopCollectionProductsResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "result": result,
        "message": message,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.addedBy,
    this.userId,
    this.categoryId,
    this.brandId,
    this.photos,
    this.thumbnailImg,
    this.videoProvider,
    this.videoLink,
    this.description,
    this.shortDescription,
    this.isShortDescription,
    this.unitPrice,
    this.purchasePrice,
    this.variantProduct,
    this.attributes,
    this.choiceOptions,
    this.colors,
    this.variations,
    this.todaysDeal,
    this.published,
    this.approved,
    this.stockVisibilityState,
    this.cashOnDelivery,
    this.sellerFeatured,
    this.currentStock,
    this.unitunit,
    this.minQty,
    this.lowStockQuantity,
    this.discount,
    this.discountType,
    this.discountStartDate,
    this.discountEndDate,
    this.tax,
    this.taxType,
    this.shippingType,
    this.shippingCost,
    this.isQuantityMultiplied,
    this.estShippingDays,
    this.numOfSale,
    this.metaTitle,
    this.metaDescription,
    this.metaImg,
    this.pdf,
    this.slug,
    this.rating,
    this.barcode,
    this.digital,
    this.auctionProduct,
    this.fileName,
    this.filePath,
    this.externalLink,
    this.externalLinkBtn,
    this.wholesaleProduct,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String addedBy;
  int userId; //string silo
  int categoryId; //string silo
  int brandId; //string silo
  String photos;
  String thumbnailImg;
  String videoProvider;
  String videoLink;
  String description;
  String shortDescription;
  int isShortDescription; //string silo
  int unitPrice; //string silo
  dynamic purchasePrice;
  int variantProduct; //string silo
  String attributes;
  String choiceOptions;
  String colors;
  dynamic variations;
  int todaysDeal; //string silo
  int published; ////string silo
  int approved; //string silo
  String stockVisibilityState;
  int cashOnDelivery; //string silo
  int sellerFeatured; //string silo
  int currentStock; //string silo
  String unitunit;
  int minQty; //string silo
  int lowStockQuantity; //string silo
  int discount; //string silo
  String discountType;
  int discountStartDate; //string silo
  int discountEndDate; //string silo
  dynamic tax;
  dynamic taxType;
  dynamic shippingType;
  String shippingCost;
  int isQuantityMultiplied; //string silo
  dynamic estShippingDays;
  int numOfSale; //string silo
  String metaTitle;
  String metaDescription;
  String metaImg;
  String pdf;
  String slug;
  int rating; //string silo
  dynamic barcode;
  int digital; //string silo
  int auctionProduct; //string silo
  dynamic fileName;
  dynamic filePath;
  dynamic externalLink;
  dynamic externalLinkBtn;
  int wholesaleProduct; //string silo
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        addedBy: json["added_by"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        brandId: json["brand_id"],
        photos: json["photos"],
        thumbnailImg: json["thumbnail_img"],
        videoProvider: json["video_provider"],
        videoLink: json["video_link"] == null ? null : json["video_link"],
        description: json["description"],
        shortDescription: json["short_description"],
        isShortDescription: json["is_short_description"],
        unitPrice: json["unit_price"],
        purchasePrice: json["purchase_price"],
        variantProduct: json["variant_product"],
        attributes: json["attributes"],
        choiceOptions: json["choice_options"],
        colors: json["colors"],
        variations: json["variations"],
        todaysDeal: json["todays_deal"],
        published: json["published"],
        approved: json["approved"],
        stockVisibilityState: json["stock_visibility_state"],
        cashOnDelivery: json["cash_on_delivery"],
        sellerFeatured: json["seller_featured"],
        currentStock: json["current_stock"],
        unitunit: json["unitunit"],
        minQty: json["min_qty"],
        lowStockQuantity: json["low_stock_quantity"],
        discount: json["discount"],
        discountType: json["discount_type"],
        discountStartDate: json["discount_start_date"] == null
            ? null
            : json["discount_start_date"],
        discountEndDate: json["discount_end_date"] == null
            ? null
            : json["discount_end_date"],
        tax: json["tax"],
        taxType: json["tax_type"],
        shippingType: json["shipping_type"],
        shippingCost:
            json["shipping_cost"] == null ? null : json["shipping_cost"],
        isQuantityMultiplied: json["is_quantity_multiplied"],
        estShippingDays: json["est_shipping_days"],
        numOfSale: json["num_of_sale"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaImg: json["meta_img"],
        pdf: json["pdf"] == null ? null : json["pdf"],
        slug: json["slug"],
        rating: json["rating"],
        barcode: json["barcode"],
        digital: json["digital"],
        auctionProduct: json["auction_product"],
        fileName: json["file_name"],
        filePath: json["file_path"],
        externalLink: json["external_link"],
        externalLinkBtn: json["external_link_btn"],
        wholesaleProduct: json["wholesale_product"],
        createdAt: DateTime.parse(json["created_at "]),
        updatedAt: DateTime.parse(json["updated_at "]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "added_by": addedBy,
        "user_id": userId,
        "category_id": categoryId,
        "brand_id": brandId,
        "photos": photos,
        "thumbnail_img": thumbnailImg,
        "video_provider": videoProvider,
        "video_link": videoLink == null ? null : videoLink,
        "description": description,
        "short_description": shortDescription,
        "is_short_description": isShortDescription,
        "unit_price": unitPrice,
        "purchase_price": purchasePrice,
        "variant_product": variantProduct,
        "attributes": attributes,
        "choice_options": choiceOptions,
        "colors": colors,
        "variations": variations,
        "todays_deal": todaysDeal,
        "published": published,
        "approved": approved,
        "stock_visibility_state": stockVisibilityState,
        "cash_on_delivery": cashOnDelivery,
        "seller_featured": sellerFeatured,
        "current_stock": currentStock,
        "unitunit": unitunit,
        "min_qty": minQty,
        "low_stock_quantity": lowStockQuantity,
        "discount": discount,
        "discount_type": discountType,
        "discount_start_date":
            discountStartDate == null ? null : discountStartDate,
        "discount_end_date": discountEndDate == null ? null : discountEndDate,
        "tax": tax,
        "tax_type": taxType,
        "shipping_type": shippingType,
        "shipping_cost": shippingCost == null ? null : shippingCost,
        "is_quantity_multiplied": isQuantityMultiplied,
        "est_shipping_days": estShippingDays,
        "num_of_sale": numOfSale,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_img": metaImg,
        "pdf": pdf == null ? null : pdf,
        "slug": slug,
        "rating": rating,
        "barcode": barcode,
        "digital": digital,
        "auction_product": auctionProduct,
        "file_name": fileName,
        "file_path": filePath,
        "external_link": externalLink,
        "external_link_btn": externalLinkBtn,
        "wholesale_product": wholesaleProduct,
        "created_at ": createdAt.toIso8601String(),
        "updated_at ": updatedAt.toIso8601String(),
      };
}
