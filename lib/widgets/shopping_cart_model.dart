import 'package:flutter_testing_lab/widgets/shopping_cart.dart';

// Refactored ShoppingCartState logic into a separate model class for better testability.
class ShoppingCartModel {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  double get totalDiscount => _items.fold(
    0,
    (sum, item) => sum + (item.price * item.discount * item.quantity),
  );

  double get totalAmount => subtotal - totalDiscount;

  void addItem(String id, String name, double price, {double discount = 0.0}) {
    final existingItem = _items.where((item) => item.id == id).toList();

    if (existingItem.isNotEmpty) {
      existingItem.first.quantity++;
    } else {
      _items.add(
        CartItem(id: id, name: name, price: price, discount: discount),
      );
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  void updateQuantity(String id, int quantity) {
    final item = _items.firstWhere(
      (i) => i.id == id,
      orElse: () => CartItem(id: '', name: '', price: 0),
    );

    if (item.id == '') return;

    if (quantity <= 0) {
      removeItem(id);
    } else {
      item.quantity = quantity;
    }
  }

  void clearCart() {
    _items.clear();
  }
}
