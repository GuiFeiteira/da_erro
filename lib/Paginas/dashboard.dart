import 'package:da_erro/Paginas/favorites.dart';
import 'package:da_erro/Paginas/home.dart';
import 'package:da_erro/Paginas/cart.dart';
import 'package:da_erro/Paginas/profile.dart';
import 'package:da_erro/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {

  CurrentUser lembrarUtilizador = Get.put(CurrentUser());
  List<Widget> screens = [
    HomeScreen(),
    FavoritesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  List navigationButtons =[
    {
      "active_icon": Icons.home,
      "desactive_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.favorite,
      "desactive_icon": Icons.favorite_border,
      "label": "Favorites",
    },
    {
      "active_icon": Icons.shopping_cart_sharp,
      "desactive_icon": Icons.shopping_cart_outlined,
      "label": "Cart",
    },
    {
      "active_icon": Icons.person,
      "desactive_icon": Icons.person_outline,
      "label": "Profile",
    }
  ];

  RxInt index = 0.obs;

  @override
  Widget build(BuildContext context) {

    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState){
        lembrarUtilizador.getUserInfo();
      },
      builder: (controller){
        return Scaffold(
          backgroundColor: Color(0xFFFFF3DC),
          body: SafeArea(
              child: Obx(
                  () => screens[index.value]
              ),
          ),
          bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                currentIndex: index.value,
                onTap: (value){
                  index.value = value;
                },
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white24,
                items: List.generate(4, (index){
                  var navBtn = navigationButtons[index];
                  return BottomNavigationBarItem(
                    backgroundColor: Color(0xFF9379A3),
                    icon: Icon(navBtn["desactive_icon"]),
                    activeIcon: Icon(navBtn["active_icon"]),
                    label: navBtn["label"]

                  );
                }),
              )
          ),
        );
      }

    );
  }
}
