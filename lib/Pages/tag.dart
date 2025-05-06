import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onboard/functiondio.dart';

class TagPage extends StatefulWidget {
  const TagPage({super.key});

  @override
  State<TagPage> createState() => _TagPageState();
}

// List count = [];

class _TagPageState extends State<TagPage> {
  List recipes = [];

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    try {
      Map<String, dynamic> prod = await result(); // Your API
      setState(() {
        recipes = prod['data'] ?? [];
      });
    } catch (e) {
      print('Error fetching recipes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text('HomePage'), centerTitle: true),
        body: SingleChildScrollView(
            child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: const [
                Icon(Icons.search),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search any recipes of your choice...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.tune), // filter icon
              ],
            ),
          ),
          SizedBox(height: 50),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.red,
                            BlendMode.colorBurn,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageUrl: '${recipes[index]['image']}',
                    height: 30,
                    width: 30,
                    progressIndicatorBuilder: (
                      context,
                      url,
                      progress,
                    ) {
                      return CircularProgressIndicator(
                        value: progress.progress,
                      );
                    },
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  title: Text(recipes[index]['name']),
                  subtitle: Text(recipes[index]['tags'].toString() ?? ''),
                );
              },
            ),
          ),
        ],
      ),
    )));
  }
}
