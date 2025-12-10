import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import '../models/meal.dart';
import 'meal_detail.dart';
import '../data/dummy_data.dart';

class MealsScreen extends StatelessWidget {
  final String title;
  final List<Meal> meals;
  final Color categoryColor;
  final void Function(String) toggleFavorite;

  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
    required this.categoryColor,
    required this.toggleFavorite,
  });

  // Fungsi untuk mendapatkan kategori dari categoryId
  Category _getCategoryFromMeal(Meal meal) {
    return availableCategories.firstWhere(
      (category) => category.id == meal.categoryId,
      orElse: () => Category(
        id: 'unknown',
        title: 'Unknown',
        color: Colors.grey, imageUrl: '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: categoryColor,
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
        child: meals.isEmpty
            ? _buildEmptyState()
            : _buildMealsGrid(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 20),
          Text(
            'No meals available',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Check back later for new recipes!',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        final category = _getCategoryFromMeal(meal);
        
        return _buildMealCard(meal, category, context);
      },
    );
  }

  Widget _buildMealCard(Meal meal, Category category, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          // Navigasi ke detail screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => MealDetailScreen(
                meal: meal,
                category: category,
                toggleFavorite: toggleFavorite,
                categoryColor: category.color,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar dengan overlay dan favorite button
            Stack(
              children: [
                // Gambar makanan
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 120,
                        width: double.infinity,
                        color: Colors.grey[800],
                        child: Center(
                          child: CircularProgressIndicator(
                            color: categoryColor,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        width: double.infinity,
                        color: Colors.grey[800],
                        child: const Icon(
                          Icons.fastfood,
                          color: Colors.grey,
                          size: 50,
                        ),
                      );
                    },
                  ),
                ),
                
                // Favorite button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        toggleFavorite(meal.id);
                      },
                      icon: Icon(
                        meal.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                
                // Badge durasi di pojok kanan bawah gambar
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.schedule,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${meal.duration} min',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Info makanan
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Judul
                    Text(
                      meal.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    // Deskripsi
                    Text(
                      meal.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    // Badge kompleksitas dan affordability
                    Row(
                      children: [
                        // Badge kompleksitas
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getComplexityColor(meal.complexity),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getComplexityText(meal.complexity),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 8),
                        
                        // Badge affordability
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getAffordabilityColor(meal.affordability),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getAffordabilityText(meal.affordability),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Harga dan tap indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${meal.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: categoryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Tap to view',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.chevron_right,
                              size: 14,
                              color: Colors.grey[500],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper functions untuk kompleksitas
  Color _getComplexityColor(Complexity complexity) {
    switch (complexity) {
      case Complexity.simple:
        return Colors.green;
      case Complexity.challenging:
        return Colors.orange;
      case Complexity.hard:
        return Colors.red;
    }
  }

  String _getComplexityText(Complexity complexity) {
    switch (complexity) {
      case Complexity.simple:
        return 'Simple';
      case Complexity.challenging:
        return 'Challenging';
      case Complexity.hard:
        return 'Hard';
    }
  }

  // Helper functions untuk affordability
  Color _getAffordabilityColor(Affordability affordability) {
    switch (affordability) {
      case Affordability.affordable:
        return Colors.blue;
      case Affordability.pricey:
        return Colors.purple;
      case Affordability.luxurious:
        return Colors.amber;
    }
  }

  String _getAffordabilityText(Affordability affordability) {
    switch (affordability) {
      case Affordability.affordable:
        return 'Affordable';
      case Affordability.pricey:
        return 'Pricey';
      case Affordability.luxurious:
        return 'Luxurious';
    }
  }
}