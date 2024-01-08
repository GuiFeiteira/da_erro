import 'package:da_erro/Paginas/productDetail.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:da_erro/model/produtos.dart';
import 'package:da_erro/Paginas/favorites.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key});

  final List<String> image = [
    "images/Delay2.png",
    "images/Delay4.png",
    "images/Delay2.png",
    "images/Delay6.png",
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF3DC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Welcome to the world of ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Delay",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: CarouselSlider(
              items: image.map((img) {
                return Container(
                  margin: EdgeInsets.all(6.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      img,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "GET YOURSELF DELAYED: ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Consumer<FavoritesManager>(
              builder: (context, favoritesManager, child) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Dois itens por linha
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {

                    return ProductCard(
                      product: products[index],
                      isFavorite: favoritesManager.isFavorite(products[index]),
                      addToFavorites: () {
                        favoritesManager.addToFavorites(products[index]);
                      },
                      removeFromFavorites: () {
                        favoritesManager.removeFromFavorites(products[index]);
                      },
                      addToCart: () {
                        // Adicione a lógica para adicionar ao carrinho aqui
                      },
                    );
                  },
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback addToFavorites;
  final VoidCallback removeFromFavorites;
  final VoidCallback addToCart;

  ProductCard({
    required this.product,
    required this.isFavorite,
    required this.addToFavorites,
    required this.removeFromFavorites,
    required this.addToCart,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isInCart = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: widget.product),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Imagem do produto
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.asset(
                widget.product.imageUrl.isNotEmpty
                    ? widget.product.imageUrl[0]
                    : 'fallback_image_url.jpg', // Adicione uma imagem de fallback se a lista estiver vazia
                fit: BoxFit.cover,
              ),
            ),

            // Botoes
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      widget.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.isFavorite ? Color(0xFF977AA3) : null,
                    ),
                    onPressed: () {
                      setState(() {
                        if (widget.isFavorite) {
                          widget.removeFromFavorites();
                        } else {
                          widget.addToFavorites();
                        }
                      });
                    },
                  ),
                  SizedBox(width: 56.0),
                  IconButton(
                    icon: Icon(
                      isInCart ? Icons.check : Icons.add,
                      color: isInCart ? Colors.green : null,
                    ),
                    onPressed: () {
                      setState(() {
                        isInCart = !isInCart;
                        if (isInCart) {
                          widget.addToCart();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

