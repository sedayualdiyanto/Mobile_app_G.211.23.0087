class Meal {
  const Meal({
    required this.id,
    required this.title,
    required this.categoryId,
    this.imageUrl = '',
    this.description = '',
    this.price = 0.0,
    this.isFavorite = false,
    this.duration = 0, // dalam menit
    this.complexity = Complexity.simple,
    this.affordability = Affordability.affordable,
  });

  final String id;
  final String title;
  final String categoryId;
  final String imageUrl;
  final String description;
  final double price;
  final bool isFavorite;
  final int duration; // dalam menit
  final Complexity complexity;
  final Affordability affordability;
}

enum Complexity {
  simple,
  challenging,
  hard,
}

enum Affordability {
  affordable,
  pricey,
  luxurious,
}