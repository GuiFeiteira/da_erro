import 'package:da_erro/Paginas/cart.dart';
import 'package:da_erro/Paginas/dashboard.dart';
import 'package:da_erro/Paginas/favorites.dart';
import 'package:da_erro/autentificacao/login_screen.dart';
import 'package:da_erro/userPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritesManager()),
        ChangeNotifierProvider(create: (context) => CartManager()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Delay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: RememberPrefs.readUser(),
        builder: (context, dataSnapShot) {
          if (dataSnapShot.data == null) {
            return LoginScreen();
          } else {
            return Dashboard();
          }
        },
      ),
    );
  }
}
