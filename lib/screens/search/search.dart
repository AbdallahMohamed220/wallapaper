import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapaper/providers/search.dart';
import 'package:wallapaper/screens/image_details/wallapaper_details.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchWallpaperProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: provider.controller,
                  onFieldSubmitted: (value) {
                    provider.fetchWallpapers();
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            provider.isLoading
                ? const SliverToBoxAdapter(
                    child: Center(
                      heightFactor: 5,
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => WallpaperDetailsScreen(
                                    wallaPaperModel: provider.wallpapers[index],
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: provider.wallpapers[index].id!,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    provider.wallpapers[index].src!.original!,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: provider.wallpapers.length, // 1000 list items
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
