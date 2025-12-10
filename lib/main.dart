import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/favorites.dart';
import 'package:meal_app/screens/settings.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/meal.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(String mealId) {
    setState(() {
      // Update meal in availableMeals
      final mealIndex = _availableMeals.indexWhere((meal) => meal.id == mealId);
      if (mealIndex >= 0) {
        _availableMeals[mealIndex] = Meal(
          id: _availableMeals[mealIndex].id,
          title: _availableMeals[mealIndex].title,
          categoryId: _availableMeals[mealIndex].categoryId,
          imageUrl: _availableMeals[mealIndex].imageUrl,
          description: _availableMeals[mealIndex].description,
          price: _availableMeals[mealIndex].price,
          isFavorite: !_availableMeals[mealIndex].isFavorite,
        );
      }

      // Update favoriteMeals list
      final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex >= 0) {
        _favoriteMeals.removeAt(existingIndex);
      } else {
        final meal = _availableMeals.firstWhere((meal) => meal.id == mealId);
        _favoriteMeals.add(meal);
      }
    });
  }

  // ignore: unused_field
  final List<Widget> _screens = [];

  @override
  Widget build(BuildContext context) {
    // Initialize screens with updated data
    final screens = [
      CategoriesScreen(
        availableMeals: _availableMeals,
        toggleFavorite: _toggleFavorite,
      ),
      FavoritesScreen(
        favoriteMeals: _favoriteMeals,
        toggleFavorite: _toggleFavorite,
      ),
      const SettingsScreen(),
    ];

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        body: screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: Colors.grey[900],
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey[400],
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}