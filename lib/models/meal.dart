class Meal {
  final String id;
  final String title;
  final String category; // مصري أو سعودي
  final String imageUrl;
  final int calories;
  final double protein;
  final double carbs;
  final double fat;

  Meal({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });
}
