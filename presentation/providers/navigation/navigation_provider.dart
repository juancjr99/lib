// providers/navigation_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// El ChangeNotifier
class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index, BuildContext context) {
    _selectedIndex = index;
    notifyListeners();

    switch (index) {
      case 0:
        break;
      case 1:
        break;
    }
  }

  void updateIndexByRoute(String location) {
    if (location.startsWith('/favorites')) {
      _selectedIndex = 1;
    } else {
      _selectedIndex = 0;
    }
    notifyListeners();
  }
}

// El provider global
final navigationProvider = ChangeNotifierProvider<NavigationProvider>((ref) {
  return NavigationProvider();
});
