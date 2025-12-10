import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../data/dummy_data.dart';
import '../screens/meals.dart';
import '../widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Meal> availableMeals;
  final void Function(String) toggleFavorite;

  const CategoriesScreen({
    super.key,
    required this.availableMeals,
    required this.toggleFavorite,
  });

  void _selectCategory(BuildContext context, String categoryId, String title, Color color) {
    final filteredMeals = availableMeals.where((meal) => meal.categoryId == categoryId).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: title,
          meals: filteredMeals,
          categoryColor: color,
          toggleFavorite: toggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Your Category'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[900]!,
              Colors.grey[850]!,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: [
              for (final category in availableCategories)
                CategoryGridItem(
                  category: category,
                  onSelectCategory: () {
                    _selectCategory(context, category.id, category.title, category.color);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}