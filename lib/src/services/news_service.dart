import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _urlBase = 'https://newsapi.org/v2';
final _apiKey = '5f908c65c5284d7bad880d5f322b3a0a';

class NewsService with ChangeNotifier {
  List<Article> headLines = [];
  String _selectedCategory = 'business';
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'technology'),
    Category(FontAwesomeIcons.addressCard, 'ports'),
    Category(FontAwesomeIcons.headSideVirus, 'sciences'),
    Category(FontAwesomeIcons.vials, 'health'),
    Category(FontAwesomeIcons.volleyball, 'general'),
    Category(FontAwesomeIcons.memory, 'entertainment')
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadLines();
    categories.forEach((element) {
      this.categoryArticles[element.name] = [];
    });
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory(valor) {
    this._selectedCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticlesCategorySelected =>
      this.categoryArticles[this.selectedCategory];

  getTopHeadLines() async {
    print('Cargando HeadLines...');
    final url = '$_urlBase/top-headlines?apiKey=$_apiKey&country=co';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);
    this.headLines.addAll(newsResponse.articles);
    print(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.length > 0) {
      return categoryArticles[category];
    }

    final url =
        '$_urlBase/top-headlines?apiKey=$_apiKey&country=co&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);
    //this.headLines.addAll(newsResponse.articles);
    print(newsResponse.articles);
    this.categoryArticles[category]?.addAll(newsResponse.articles);
    notifyListeners();
  }
}
