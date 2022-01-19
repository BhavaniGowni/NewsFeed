import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:newsfeed/model/news.dart';
// notifier for the news class
class NewsNotifier with ChangeNotifier {
  List<News> _newsList = [];
  News _currentNewsArticle;

  UnmodifiableListView<News> get newsList => UnmodifiableListView(_newsList);

  News get currentNewsArticle => _currentNewsArticle;
//for list of news articles
  set newsList(List<News> newsList) {
    _newsList = newsList;
    notifyListeners();
  }
  //for each news article
  set currentNewsArticle(News news) {
    _currentNewsArticle = news;
    notifyListeners();
  }


}