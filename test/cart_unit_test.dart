import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart_model.dart';

void main() {
  group('for cart operations (add, remove, calculate totals)', () {
    late ShoppingCartModel cart;

    setUp(() {
      cart = ShoppingCartModel();
    });

    test('addItem adds an item to the cart', () {
      cart.addItem('1', 'Apple iPhone', 999.99);
      expect(cart.totalItems, 1);
      expect(cart.subtotal, 999.99);
    });

    test('addItem with discount', () {
      cart.addItem('1', 'Apple iPhone', 999.99, discount: 0.1);
      int expectedTotalItems = 1; // expected change
      double expectedSubtotal = 999.99;
      double expectedTotalDiscount = 999.99 * 0.1;
      double expectedTotalAmount = 999.99 - 999.99 * 0.1;

      expect(cart.totalItems, expectedTotalItems);
      expect(cart.subtotal, expectedSubtotal);
      expect(cart.totalDiscount, expectedTotalDiscount);
      expect(cart.totalAmount, expectedTotalAmount);
    });

    test('addItem increments quantity when adding existing item', () {
      cart.addItem('1', 'Apple iPhone', 999.99);
      cart.addItem('1', 'Apple iPhone', 999.99);
      expect(cart.totalItems, 2);
      expect(cart.items.length, 1); // Still only 1 item but quantity is 2 💞
      expect(cart.items[0].quantity, 2);
      expect(cart.subtotal, 1999.98);
    });

    test('removeItem removes an item from the cart', () {
      cart.addItem('1', 'Apple iPhone', 999.99);
      cart.removeItem('1');
      expect(cart.totalItems, 0);
      expect(cart.subtotal, 0);
      expect(cart.items.isEmpty, true);
    });


    test('updateQuantity updates the quantity of an item', () {
      cart.addItem('1', 'Apple iPhone', 999.99);
      cart.updateQuantity('1', 2);
      expect(cart.totalItems, 2);
      expect(cart.subtotal, 1999.98);
    });

    test('updateQuantity removes item when quantity is zero', () {
      cart.addItem('1', 'Apple iPhone', 999.99);
      cart.updateQuantity('1', 0);
      expect(cart.totalItems, 0);
      expect(cart.items.isEmpty, true);
    });

    test('clearCart clears all items from the cart', () {
      cart.addItem('1', 'Apple iPhone', 999.99);
      cart.addItem('2', 'Samsung Galaxy', 899.99);
      cart.clearCart();
      expect(cart.totalItems, 0);
      expect(cart.subtotal, 0);
      expect(cart.items.isEmpty, true);
    });

    test('subtotal calculates correctly with multiple items', () {
      cart.addItem('1', 'Apple iPhone', 999.99);
      cart.addItem('2', 'Samsung Galaxy', 899.99);
      cart.addItem('3', 'iPad Pro', 1099.99);
      expect(cart.subtotal, 999.99 + 899.99 + 1099.99);
    });

    test('totalDiscount calculates correctly with discounts', () {
      cart.addItem('1', 'Apple iPhone', 999.99, discount: 0.1); // 10% off
      cart.addItem('2', 'Samsung Galaxy', 899.99, discount: 0.15); // 15% off

      final expectedDiscount = (999.99 * 0.1) + (899.99 * 0.15);
      expect(cart.totalDiscount, expectedDiscount);
    });

    test('totalAmount calculates correctly with discounts', () {
      cart.addItem('1', 'Apple iPhone', 999.99, discount: 0.1);
      cart.addItem('2', 'Samsung Galaxy', 899.99, discount: 0.15);

      final subtotal = 999.99 + 899.99;
      final discount = (999.99 * 0.1) + (899.99 * 0.15);
      expect(cart.totalAmount, subtotal - discount);
    });

    test('totalItems calculates correctly with multiple quantities', () {
      cart.addItem('1', 'Apple iPhone', 999.99);
      cart.updateQuantity('1', 3);
      cart.addItem('2', 'Samsung Galaxy', 899.99);
      cart.updateQuantity('2', 2);
      expect(cart.totalItems, 5); // 3 iPhones + 2 Galaxy
    });
  });
}
