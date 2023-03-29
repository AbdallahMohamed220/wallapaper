import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallapaper/model/wallapaper.dart';

class FavoritesProvider with ChangeNotifier {
  late Database _database;
  final String _tableName = 'favorites';

  List<WallaPaperModel> _favorites = [];

  FavoritesProvider() {
    _initDatabase();
  }

  List<WallaPaperModel> get favorites => _favorites;

  void addFavorite(WallaPaperModel wallaPaperModel) async {
    Map<String, dynamic> row = {
      'id': wallaPaperModel.id,
      'image_url': wallaPaperModel.src!.original
    };
    int id = await _database.insert(_tableName, row);
    _favorites.add(WallaPaperModel(
        id: id, src: Src(original: wallaPaperModel.src!.original)));
    print(_favorites);
    notifyListeners();
  }

  void removeFavorite(WallaPaperModel wallaPaperModel) async {
    await _database.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [wallaPaperModel.id],
    );
    _favorites.removeWhere((w) => w.id == wallaPaperModel.id);
    notifyListeners();
  }

  bool isFavorite(WallaPaperModel wallaPaperModel) {
    return _favorites.any((w) => w.id == wallaPaperModel.id);
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      'WallaPaperModel_database.db',
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            image_url TEXT NOT NULL
          )
        ''');
      },
    );
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    List<Map<String, dynamic>> maps = await _database.query(_tableName);
    _favorites = List.generate(
      maps.length,
      (index) => WallaPaperModel(),
    );
    notifyListeners();
  }

  Future<String> _getDownloadPath() async {
    Directory? directory = await getExternalStorageDirectory();
    String path = directory!.path;
    return path;
  }

  Future<void> downloadWallpaper(String image) async {
    String path = await _getDownloadPath();
    String fileName = image.split('/').last;
    String url = image;
    await FlutterDownloader.enqueue(
      url: url,
      savedDir: path,
      fileName: fileName,
      showNotification: true,
      openFileFromNotification: true,
    );
  }
}
