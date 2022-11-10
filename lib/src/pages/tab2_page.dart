import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:news_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(children: <Widget>[
          const _ListaCategories(),
          Expanded(
              child: (newsService.getArticlesCategorySelected!.length == 0)
                  ? const Center(child: CircularProgressIndicator())
                  : ListaNoticias(
                      noticias: newsService.getArticlesCategorySelected!))
        ]),
      ),
    );
  }
}

class _ListaCategories extends StatelessWidget {
  const _ListaCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: <Widget>[
              _CategoryBottom(categoria: categories[index]),
              const SizedBox(
                height: 5,
              ),
              Text(categories[index].name)
            ]),
          );
        },
      ),
    );
  }
}

class _CategoryBottom extends StatelessWidget {
  final Category categoria;
  const _CategoryBottom({
    required this.categoria,
  });

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        print('${categoria.name}');
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == this.categoria.name)
              ? myTheme.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
