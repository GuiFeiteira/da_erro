import 'package:flutter/material.dart';
import 'package:da_erro/model/produtos.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var favoritesManager = Provider.of<FavoritesManager>(context);
    List<Product> favoritesList = favoritesManager.favoritesList;

    return Scaffold(
      backgroundColor: Color(0xFFFFF3DC),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Os Teus Favoritos',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          favoritesList.isNotEmpty
              ? Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: favoritesList.length,
              itemBuilder: (context, index) {
                return ProductCard(product: favoritesList[index]);
              },
            ),
          )
              : Center(
            child: Text(
              "No favorites yet.",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

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
            child: Image.asset(
              product.imageUrl.isNotEmpty
                  ? product.imageUrl[0]
                  : 'fallback_image_url.jpg', // Adicione uma imagem de fallback se a lista estiver vazia
              fit: BoxFit.cover,
              height: 184,
            ),
          ),
          // Adicione outros elementos conforme necessário
        ],
      ),
    );
  }
}

class FavoritesManager extends ChangeNotifier {
  List<Product> _favoritesList = [];

  List<Product> get favoritesList => _favoritesList;

  bool isFavorite(Product product) {
    return _favoritesList.contains(product);
  }

  void addToFavorites(Product product) {
    if (!_favoritesList.contains(product)) {
      _favoritesList.add(product);
      notifyListeners();
    }
  }

  void removeFromFavorites(Product product) {
    if (_favoritesList.contains(product)) {
      _favoritesList.remove(product);
      notifyListeners();
    }
  }
}
