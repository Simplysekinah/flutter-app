import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe["name"] ?? "Details"),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: recipe['id'].toString(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: '${recipe["image"] ?? ''}',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            recipe["name"] ?? '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: [
              Chip(
                label: Text(recipe["difficulty"] ?? 'Unknown'),
                avatar: const Icon(Icons.whatshot, color: Colors.orange),
              ),
              if (recipe["cuisine"] != null)
                Chip(
                  label: Text(recipe["cuisine"]),
                  avatar: const Icon(Icons.restaurant_menu),
                ),
            ],
          ),
          const Divider(height: 30),
          const Text(
            "Instructions",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          // recipe['instructions'].toString(),
          Text(
            recipe["instructions"].toString() ?? 'No instructions available.',
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}
