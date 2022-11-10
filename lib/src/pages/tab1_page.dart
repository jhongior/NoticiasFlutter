import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
//se usa para mantener el estado de la lista
    with
        AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final headLines = Provider.of<NewsService>(context).headLines;
    final newsService = Provider.of<NewsService>(context);
    return Scaffold(
      body: (headLines.length == 0)
          ? const Center(child: CircularProgressIndicator())
          : ListaNoticias(noticias: newsService.headLines),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true; //siempre debe retornar true
}
