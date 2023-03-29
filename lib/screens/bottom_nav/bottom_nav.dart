import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapaper/providers/bottom_bar.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: provider.screens[provider.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.blueAccent,
            currentIndex: provider.currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              provider.updatePageSelection(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
            ],
          ),
        );
      },
    );
  }
}
