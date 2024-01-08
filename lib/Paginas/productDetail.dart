import 'package:da_erro/Paginas/cart.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:da_erro/model/produtos.dart';
import 'package:provider/provider.dart';



class ProductDetailScreen extends StatefulWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = "S"; // Tamanho inicial selecionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF3DC),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF3DC),
        title: Text("Product Details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CarouselSlider(
            items: widget.product.imageUrl.map((imagePath) {
              return Image.asset(
                imagePath,
                fit: BoxFit.cover,
              );
            }).toList(),
            options: CarouselOptions(
              height: 300.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.product.nome,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price: ${widget.product.price} €", // \$${widget.product.price}
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Select Size:",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedSize,
                  onChanged: (String? newSize) {
                    setState(() {
                      selectedSize = newSize!;
                    });
                  },
                  items: ["XS", "S", "M", "L", "XL"].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              var cartManager = Provider.of<CartManager>(context, listen: false);
              cartManager.addToCart(CartItem(
                productName: widget.product.nome,
                size: selectedSize,
                price: widget.product.price,
              ));
            },
            child: Text("Add to Cart"),
          ),
        ],
      ),
    );
  }
}
