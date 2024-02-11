import 'package:aplikasi_berita/components/news.dart';
import 'package:aplikasi_berita/providers/news.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController SearchController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
        builder: (BuildContext context, news, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Search News Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: SearchController,
                    decoration: const InputDecoration(
                      hintText: 'Cari Berita...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    news.search(SearchController.text);
                  },
                  icon: Icon(Icons.send),
                )
              ],
            ),
            SizedBox(height: 20),
            news.isDataEmpty
                ? SizedBox()
                : news.isloadingSearch
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          ...news.resSearch!.articles!.map(
                            (e) => News(
                              title: e.title ?? '',
                              image: e.urlToImage ?? '',
                            ),
                          )
                        ],
                      ),
            // News(
            //   title: 'testing',
            //   image:
            //       'https://image.cnbcfm.com/api/v1/image/106971590-1636133442922allbirds1.jpg?v=1636133472&w=1920&h=1080',
            // )
          ])),
        ),
      );
    });
  }
}
