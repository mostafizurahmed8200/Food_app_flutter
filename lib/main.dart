import 'package:flutter/material.dart';
import 'package:food_apps/page/add_basket_page.dart';
import 'package:food_apps/page/intropage2.dart';
import 'package:food_apps/page/splash_screen.dart';

import 'assets/const.dart';
import 'page/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Const.hexToColor(Const.appColor)),
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.grey[40],
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0,
          )),
      // home: const SplashScreen(),
      home: const SplashScreen(),
      routes: {
        '/intro2': (context) => const IntroScreen2(),
        '/homescreen': (context) => const HomeScreen(),
        '/cartitempage': (context) => const AddBasketItems(),
        '/basketPage': (context) => const AddBasketItems(),
      },
    );
  }
}
