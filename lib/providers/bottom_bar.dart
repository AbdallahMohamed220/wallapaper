import 'package:flutter/material.dart';
import 'package:wallapaper/screens/favorite/favorite.dart';
import 'package:wallapaper/screens/home/home.dart';
import 'package:wallapaper/screens/search/search.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
  ];

  void updatePageSelection(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
