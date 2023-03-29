import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wallapaper/model/wallapaper.dart';

class SearchWallpaperProvider with ChangeNotifier {
  final List<WallaPaperModel> wallpapers = [];
  bool isLoading = false;

  TextEditingController controller = TextEditingController();
  Future<void> fetchWallpapers() async {
    isLoading = true;
    notifyListeners();
    wallpapers.clear();

    final response = await Dio().get(
      'https://api.pexels.com/v1/search?query=${controller.text}&per_page=2',
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
}
