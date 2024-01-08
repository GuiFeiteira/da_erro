import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:da_erro/model/produtos.dart';

class CartItem {
  final String productName;
  final String size;
  final int price;

  CartItem({
    required this.productName,
    required this.size,
    required this.price,
  });
}


class CartManager extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }
  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartManager = Provider.of<CartManager>(context);

    return Scaffold(
      backgroundColor: Color(0xFFFFF3DC),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Cart Items",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: cartManager.cartItems.map((item) {
                return Card(
                  child: ListTile(
                    title: Text("${item.productName} - ${item.price} €"),
                    subtitle: Text("Size: ${item.size}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_forever_sharp),
                      onPressed: () {
                        cartManager.removeFromCart(item);
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: ${calculateTotal(cartManager.cartItems)} €",
                  style: TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: () {

                  },
                  child: Text(" Pagar "),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotal(List<CartItem> cartItems) {
    return cartItems.fold(0.0, (sum, item) => sum + item.price);
  }
}




class SizeOptionButton extends StatelessWidget {
  final String size;
  final VoidCallback onPressed;

  SizeOptionButton({required this.size, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(size),
    );
  }
}


