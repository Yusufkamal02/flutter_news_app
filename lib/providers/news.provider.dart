import 'package:aplikasi_berita/helpers/api.dart';
import 'package:aplikasi_berita/models/topNews.model.dart';
import 'package:aplikasi_berita/utils/const.dart';
import 'package:flutter/material.dart';

class NewsProvider with ChangeNotifier {
  bool isDataEmpty = true;
  bool isloading = true;
  bool isloadingSearch = true;
  TopNewsModel? resNews;
  TopNewsModel? resSearch;

  setLoading(data) {
    isloading = data;
    notifyListeners();
  }

  getTopNews() async {
    //this for get API News
    final res = await api(
        '${baseUrl}top-headlines?country=us&category=business&apiKey=$apiKey');

    if (res.statusCode == 200) {
      resNews = TopNewsModel.fromJson(res.data);
    } else {
      resNews = TopNewsModel();
    }
    isloading = false;
    notifyListeners();
  }

  search(String search) async {
    isDataEmpty = false;
    isloadingSearch = true;
    notifyListeners();

    final res = await api(
        '${baseUrl}everything?q=$search&sortBy=popularity&apiKey=$apiKey');

    if (res.statusCode == 200) {
      resSearch = TopNewsModel.fromJson(res.data);
    } else {
      resSearch = TopNewsModel();
    }
    isloadingSearch = false;
    notifyListeners();
  }
}
