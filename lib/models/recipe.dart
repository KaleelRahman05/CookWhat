class Recipe {
  final String title;
  final String imagePath;
  final double rating;
  final int cookingTime;
  final String description;

  final List<String> ingredients;   // ✅ ADD THIS
  final List<String> steps;         // ✅ ADD THIS

  Recipe({
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.cookingTime,
    required this.description,
    required this.ingredients,      // ✅ ADD THIS
    required this.steps,            // ✅ ADD THIS
  });
}