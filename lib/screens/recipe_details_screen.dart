import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({
    super.key,
    required this.recipe,
  });

  @override
  State<RecipeDetailsScreen> createState() =>
      _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState
    extends State<RecipeDetailsScreen> {

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F2),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= IMAGE SECTION =================
            Stack(
              children: [
                Hero(
                  tag: recipe.imagePath,
                  child: Image.asset(
                    recipe.imagePath,
                    height: 320,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Back Button
                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),

                // Favorite Button (NOW WORKING)
                Positioned(
                  top: 50,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ================= CONTENT SECTION =================
            Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 30,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF8F2),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Title
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Rating + Time
                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: Colors.orange, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          "${recipe.rating}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Icon(Icons.access_time,
                            size: 18, color: Colors.grey),
                        const SizedBox(width: 5),
                        Text(
                          "${recipe.cookingTime} mins",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // About
                    const Text(
                      "About Recipe",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      recipe.description,
                      style: const TextStyle(
                        color: Colors.black54,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ================= INGREDIENTS =================
                    const Text(
                      "Ingredients",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recipe.ingredients.map((ingredient) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle,
                                  size: 18,
                                  color: Color(0xFF8BC34A)),
                              const SizedBox(width: 8),
                              Text(ingredient),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 30),

                    // ================= STEPS =================
                    const Text(
                      "Cooking Steps",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      recipe.steps.asMap().entries.map((entry) {
                        int index = entry.key;
                        String step = entry.value;

                        return Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor:
                                const Color(0xFF8BC34A),
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: Text(step)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 40),

                    // Start Cooking Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFF8BC34A),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Start Cooking",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}