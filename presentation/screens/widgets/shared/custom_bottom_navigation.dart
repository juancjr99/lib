import 'package:cinemapedia/presentation/providers/navigation/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomBottomNavigation extends ConsumerWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final _navigationProvider = ref.watch(navigationProvider);

    return BottomNavigationBar(
      elevation: 0,
      onTap: (index) {
        ref.read(navigationProvider).setIndex(index, context);
      },
      currentIndex: _navigationProvider.selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Inicio',
          
          ),
          
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.label_outline),
        //   label: 'Categorias',
        //   ),

          BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',

          ),
      ],
    );
  }
}