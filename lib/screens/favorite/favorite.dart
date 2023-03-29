import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapaper/providers/favorite.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FavoritesProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          provider.favorites[index].src!.original!,
                        ),
                      ),
                    ),
                  );
                },
                childCount: provider.favorites.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
