import 'package:flutter/material.dart';
import 'models/recipe.dart';
import 'screens/splash_screen.dart';
import 'screens/recipe_details_screen.dart';
import 'services/spoonacular_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Recipe> recipes = [
    Recipe(
      title: "Creamy Pasta",
      imagePath: "assets/images/food1.jpg",
      rating: 4.5,
      cookingTime: 30,
      description: "Delicious creamy pasta with rich sauce.",
      ingredients: [
        "Pasta",
        "Olive Oil",
        "Cheese",
        "Cream",
      ],
      steps: [
        "Boil water",
        "Cook pasta",
        "Prepare sauce",
        "Mix and serve",
      ],
    ),

    Recipe(
      title: "Veggie Pizza",
      imagePath: "assets/images/food2.jpg",
      rating: 4.8,
      cookingTime: 25,
      description: "Crispy pizza with fresh vegetables.",
      ingredients: [
        "Pizza Base",
        "Mozzarella",
        "Capsicum",
        "Onion",
      ],
      steps: [
        "Preheat oven",
        "Add toppings",
        "Bake",
        "Serve hot",
      ],
    ),

    Recipe(
      title: "Chocolate Cake",
      imagePath: "assets/images/food3.jpg",
      rating: 4.9,
      cookingTime: 45,
      description: "Soft and moist chocolate cake.",
      ingredients: [
        "Flour",
        "Cocoa Powder",
        "Sugar",
        "Eggs",
        "Butter",
      ],
      steps: [
        "Preheat oven to 180°C",
        "Mix dry ingredients",
        "Add wet ingredients",
        "Bake for 35 minutes",
        "Cool and serve",
      ],
    ),
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {

    final filteredRecipes = recipes
        .where((recipe) =>
        recipe.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cook What"),
        centerTitle: true,

        // 🔍 SEARCH ICON ADDED HERE
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RecipeSearchDelegate(recipes),
              );
            },
          ),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredRecipes.length,
        itemBuilder: (context, index) {
          final recipe = filteredRecipes[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RecipeDetailsScreen(recipe: recipe),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // IMAGE
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.asset(
                      recipe.imagePath,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // TITLE
                        Text(
                          recipe.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // RATING + TIME
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.orange, size: 16),
                            const SizedBox(width: 4),
                            Text(recipe.rating.toString()),
                            const SizedBox(width: 16),
                            const Icon(Icons.access_time,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text("${recipe.cookingTime} mins"),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // 🧂 INGREDIENTS PREVIEW ADDED HERE
                        Wrap(
                          spacing: 6,
                          children: recipe.ingredients
                              .take(3)
                              .map(
                                (ingredient) => Chip(
                              label: Text(
                                ingredient,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// SEARCH DELEGATE
////////////////////////////////////////////////////////////

class RecipeSearchDelegate extends SearchDelegate {

  final List<Recipe> recipes;

  RecipeSearchDelegate(this.recipes);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = recipes
        .where((recipe) =>
        recipe.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: results
          .map(
            (recipe) => ListTile(
          title: Text(recipe.title),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    RecipeDetailsScreen(recipe: recipe),
              ),
            );
          },
        ),
      )
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}