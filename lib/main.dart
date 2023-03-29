import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:wallapaper/providers/bottom_bar.dart';
import 'package:wallapaper/providers/favorite.dart';
import 'package:wallapaper/providers/home.dart';
import 'package:wallapaper/providers/search.dart';
import 'package:wallapaper/screens/bottom_nav/bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationBarProvider>(
          create: (_) => BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider<HomeWallpaperProvider>(
          create: (_) => HomeWallpaperProvider(),
        ),
        ChangeNotifierProvider<SearchWallpaperProvider>(
          create: (_) => SearchWallpaperProvider(),
        ),
        ChangeNotifierProvider<FavoritesProvider>(
          create: (_) => FavoritesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WallaPaper',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AppBottomBar(),
      ),
    );
  }
}
