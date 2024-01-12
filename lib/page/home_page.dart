import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../bo/article.dart';
import '../bo/cart.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => context.go('/cart'),
              icon: Badge(
                  label: Text("${context.watch<Cart>().listArticles.length}"),
                  child: Icon(Icons.shopping_cart))),
          IconButton(
              onPressed: () => context.go("/aboutus"),
              icon: Icon(Icons.info_outline))
        ],
      ),
      body: FutureBuilder<List<Article>>(
          future: fetchListProducts(),
          builder: (context, snapshot) => switch (snapshot.connectionState) {
            ConnectionState.done when snapshot.data != null =>
                ListArticles(listArticles: snapshot.data!),
            ConnectionState.waiting =>
                Center(child: const CircularProgressIndicator()),
            _ => const Icon(Icons.error)
          }),
    );
  }

  Future<List<Article>> fetchListProducts() async {
    String uri = "https://fakestoreapi.com/products";
    Response resListArt = await get(Uri.parse(uri));
    if (resListArt.statusCode == 200 && resListArt.body.isNotEmpty) {
      final resListMap = jsonDecode(resListArt.body) as List<dynamic>;
      return resListMap
          .map<Article>((map) => Article.fromMap(map as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Requête invalide");
    }
  }
}
class ListArticles extends StatelessWidget {
  const ListArticles({
    super.key,
    required this.listArticles,
  });

  final List<Article> listArticles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listArticles.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () => context.go("/detail", extra: listArticles[index]),
          title: Text(listArticles[index].nom),
          subtitle: Text(listArticles[index].getPrixEuro()),
          leading: Image.network(
            listArticles[index].image,
            width: 80,
          ),
          trailing: TextButton(
            child: Text("AJOUTER"),
            onPressed: () {
              context.read<Cart>().add(listArticles[index]);
            },
          ),
        ));
  }
}
