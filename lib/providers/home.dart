import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wallapaper/model/wallapaper.dart';

class HomeWallpaperProvider with ChangeNotifier {
  final List<WallaPaperModel> wallpapers = [];
  bool isLoading = false;
  int page = 1;
  Future<void> fetchWallpapers() async {
    isLoading = true;
    notifyListeners();
    wallpapers.clear();

    final response = await Dio().get(
      'https://api.pexels.com/v1/curated?per_page=10&page=$page',
      options: Options(
        headers: {
          'Authorization':
              'Acv8KbY2eQIRjJPVR0yC1qCGnhOMvI1esyqGvljrsOoJPkbrPgHGJPno'
        },
      ),
    );

    response.data['photos']
        .forEach((e) => wallpapers.add(WallaPaperModel.fromJson(e)));

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreWallpapers() async {
    final response = await Dio().get(
      'https://api.pexels.com/v1/curated?per_page=10&page=$page',
      options: Options(
        headers: {
          'Authorization':
              'Acv8KbY2eQIRjJPVR0yC1qCGnhOMvI1esyqGvljrsOoJPkbrPgHGJPno'
        },
      ),
    );

    response.data['photos']
        .forEach((e) => wallpapers.add(WallaPaperModel.fromJson(e)));
    notifyListeners();
  }
}
