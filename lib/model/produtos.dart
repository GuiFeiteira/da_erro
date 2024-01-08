import 'package:flutter/material.dart';


class Product {
  final String nome;
  final List<String> imageUrl;
  final int price;

  Product(this.nome, this.imageUrl, {required this.price});
}


class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToFavorites;
  final VoidCallback? onAddToCart;

  ProductCard({
    required this.product,
    this.onAddToFavorites,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagem do produto
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
            child: Image.network(
              product.imageUrl.isNotEmpty
                  ? product.imageUrl.first
                  : 'fallback_image_url.jpg',
              fit: BoxFit.cover,
              height: 184,
            ),
          ),



        ],
      ),
    );
  }
}

final List<Product> products = [
  Product("Teddy", [
    "images/product1.png",
    "images/product11.png",
    "images/product12.png",
  ],price: 25),
  Product("The Classics", ["images/product2.png"], price: 20),
  Product("The Classics", ["images/product3.png"], price: 20),
  Product("Main Collection", ["images/product4.png"], price: 20),
  Product("Delay Effect", ["images/product5.png"], price: 20),
  Product("Nature Body", ["images/product6.png"], price: 20),
];