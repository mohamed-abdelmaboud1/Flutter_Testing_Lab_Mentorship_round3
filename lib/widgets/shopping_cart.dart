import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;
  final double discount; // Discount percentage (0.0 to 1.0)

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.discount = 0.0,
  });
}

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => ShoppingCartState();
}

class ShoppingCartState extends State<ShoppingCart> {
  final List<CartItem> items = [];

  void addItem(String id, String name, double price, {double discount = 0.0}) {
    setState(() {
      final index = items.indexWhere((item) => item.id == id);
      if (index != -1) {
        items[index].quantity += 1;
        return;
      }
      items.add(CartItem(id: id, name: name, price: price, discount: discount));
    });
  }

  void removeItem(String id) {
    setState(() {
      items.removeWhere((item) => item.id == id);
    });
  }

  void updateQuantity(String id, int newQuantity) {
    setState(() {
      final index = items.indexWhere((item) => item.id == id);
      if (index != -1) {
        if (newQuantity <= 0) {
          items.removeAt(index);
        } else {
          items[index].quantity = newQuantity;
        }
      }
    });
  }

  void clearCart() {
    setState(() {
      items.clear();
    });
  }

  double get subtotal {
    double total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  double get totalDiscount {
    double discount = 0;
    for (var item in items) {
      discount += item.price * item.discount * item.quantity;
    }
    return discount;
  }

  double get totalAmount {
    return subtotal - totalDiscount;
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CartActions(
          onAddIphone: () =>
              addItem('1', 'Apple iPhone', 999.99, discount: 0.1),
          onAddGalaxy: () =>
              addItem('2', 'Samsung Galaxy', 899.99, discount: 0.15),
          onAddIpad: () => addItem('3', 'iPad Pro', 1099.99),
        ),
        const SizedBox(height: 16),
        CartSummary(
          totalItems: totalItems,
          subtotal: subtotal,
          totalDiscount: totalDiscount,
          totalAmount: totalAmount,
          onClearCart: clearCart,
        ),
        const SizedBox(height: 16),
        items.isEmpty
            ? const Center(child: Text('Cart is empty'))
            : CartItemList(
                items: items,
                onUpdateQuantity: updateQuantity,
                onRemoveItem: removeItem,
              ),
      ],
    );
  }
}

class CartActions extends StatelessWidget {
  final VoidCallback onAddIphone;
  final VoidCallback onAddGalaxy;
  final VoidCallback onAddIpad;

  const CartActions({
    super.key,
    required this.onAddIphone,
    required this.onAddGalaxy,
    required this.onAddIpad,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ElevatedButton(onPressed: onAddIphone, child: const Text('Add iPhone')),
        ElevatedButton(onPressed: onAddGalaxy, child: const Text('Add Galaxy')),
        ElevatedButton(onPressed: onAddIpad, child: const Text('Add iPad')),
      ],
    );
  }
}

class CartSummary extends StatelessWidget {
  final int totalItems;
  final double subtotal;
  final double totalDiscount;
  final double totalAmount;
  final VoidCallback onClearCart;

  const CartSummary({
    super.key,
    required this.totalItems,
    required this.subtotal,
    required this.totalDiscount,
    required this.totalAmount,
    required this.onClearCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Items: $totalItems'),
              ElevatedButton(
                onPressed: onClearCart,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Clear Cart'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Subtotal: \$${subtotal.toStringAsFixed(2)}'),
          Text('Total Discount: \$${totalDiscount.toStringAsFixed(2)}'),
          const Divider(),
          Text(
            'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class CartItemList extends StatelessWidget {
  final List<CartItem> items;
  final void Function(String id, int newQuantity) onUpdateQuantity;
  final void Function(String id) onRemoveItem;

  const CartItemList({
    super.key,
    required this.items,
    required this.onUpdateQuantity,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return CartItemTile(
          item: item,
          onUpdateQuantity: onUpdateQuantity,
          onRemoveItem: onRemoveItem,
        );
      },
    );
  }
}

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final void Function(String id, int newQuantity) onUpdateQuantity;
  final void Function(String id) onRemoveItem;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onUpdateQuantity,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    final itemTotal = item.price * item.quantity;
    final itemDiscount = itemTotal * item.discount;
    return Card(
      child: ListTile(
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: \$${item.price.toStringAsFixed(2)} each'),
            if (item.discount > 0)
              Text(
                'Discount: ${(item.discount * 100).toStringAsFixed(0)}%',
                style: const TextStyle(color: Colors.green),
              ),
            Text(
              'Item Total: \$${(itemTotal - itemDiscount).toStringAsFixed(2)}',
            ),
          ],
        ),
        trailing: CartItemActions(
          quantity: item.quantity,
          onDecrease: () => onUpdateQuantity(item.id, item.quantity - 1),
          onIncrease: () => onUpdateQuantity(item.id, item.quantity + 1),
          onRemove: () => onRemoveItem(item.id),
        ),
      ),
    );
  }
}

class CartItemActions extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onRemove;

  const CartItemActions({
    super.key,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: onDecrease, icon: const Icon(Icons.remove)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('$quantity'),
        ),
        IconButton(onPressed: onIncrease, icon: const Icon(Icons.add)),
        IconButton(
          onPressed: onRemove,
          icon: const Icon(Icons.delete),
          color: Colors.red,
        ),
      ],
    );
  }
}
