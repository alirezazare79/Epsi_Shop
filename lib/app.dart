import 'package:epsi_shop/page/about_us_page.dart';
import 'package:epsi_shop/page/cart_page.dart';
import 'package:epsi_shop/page/detail_page.dart';
import 'package:epsi_shop/page/home_page.dart';
import 'package:epsi_shop/page/paiment_page.dart'; // Ensure this is the correct file name.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bo/article.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => HomePage(),
      routes: [
        GoRoute(
          path: 'cart',
          builder: (BuildContext context, GoRouterState state) => CartPage(),
          routes: [
            GoRoute(
              path: 'payment',
              builder: (BuildContext context, GoRouterState state) => PaymentPage(),
            ),
          ],
        ),
        GoRoute(path: 'aboutus', builder: (BuildContext context, GoRouterState state) => AboutUsPage()),
        GoRoute(
          path: 'detail',
          builder: (BuildContext context, GoRouterState state) => DetailPage(article: state.extra as Article),
        ),
  ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}