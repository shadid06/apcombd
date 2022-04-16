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

  saveAskQuotationCounter(counter) {
    askQuotationCounter_saved.$ = counter;
    askQuotationCounter_saved.save();
    print(askQuotationCounter_saved.$);
  }

  clearAskQuotationCounter() {
    askQuotationCounter_saved.$ = 0;
    askQuotationCounter_saved.save();
  }

  saveCartPreviousTotal(total) {
    previousTotalSaved.$ = total;
    previousTotalSaved.save();
    print(previousTotalSaved.$);
  }

  clearCartPreviousTotal() {
    previousTotalSaved.$ = 0;
    previousTotalSaved.save();
  }
}
