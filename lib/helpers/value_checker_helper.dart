import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class ValueCheckerHelper {
  saveCartPreviousPrice(price) {
    cartIndexPriceBeforeAskQuotation.$ = price;
    cartIndexPriceBeforeAskQuotation.save();
    print(cartIndexPriceBeforeAskQuotation.$);
  }

  clearCartPreviousVlue() {
    cartIndexPriceBeforeAskQuotation.$ = 0;
    cartIndexPriceBeforeAskQuotation.save();
  }
}
