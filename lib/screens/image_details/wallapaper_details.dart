import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapaper/model/wallapaper.dart';
import 'package:wallapaper/providers/favorite.dart';

class WallpaperDetailsScreen extends StatefulWidget {
  final WallaPaperModel wallaPaperModel;
  const WallpaperDetailsScreen({Key? key, required this.wallaPaperModel})
      : super(key: key);

  @override
  State<WallpaperDetailsScreen> createState() => _WallpaperDetailsScreenState();
}

class _WallpaperDetailsScreenState extends State<WallpaperDetailsScreen> {
  late FavoritesProvider _favoritesProvider;
  bool _isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    bool isFavorite = _favoritesProvider.isFavorite(
      widget.wallaPaperModel,
    );
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    if (!_isFavorite) {
      _favoritesProvider.removeFavorite(widget.wallaPaperModel);
    } else {
      _favoritesProvider.addFavorite(widget.wallaPaperModel);
    }
  }

  Future<void> downloadWallpaper() async {
    _favoritesProvider.downloadWallpaper(widget.wallaPaperModel.src!.original!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: widget.wallaPaperModel.id!,
                        child: Image.network(
                          widget.wallaPaperModel.src!.original!,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.lightBlueAccent,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.wallaPaperModel.photographer!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: _isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            _toggleFavorite();
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.download,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            downloadWallpaper();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.wallaPaperModel.alt!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
