import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:onboard/Models/receipedetail.dart';
import 'package:onboard/functiondio.dart';
// import 'package:onboard/main.dart';
// import 'package:onboard/vaiable.dart';

// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// List count = [];

// class _DashboardState extends State<Dashboard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome page'),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           color: Colors.white,
//           child: Column(
//             children: [
//               TextButton(
//                 style: ButtonStyle(
//                   backgroundColor: WidgetStatePropertyAll(
//                     Colors.purpleAccent,
//                   ),
//                 ),
//                 onPressed: () async {
//                   // print(result());
//                   Map<String, dynamic> prod = await result();
//                   setState(() {
//                     print('yyyy , ${prod.runtimeType}');
//                     // print('yyyy , ${prod['data'].runtimeType}');
//                     count = prod['data'];
//                     print(count);
//                   });
//                 },
//                 child: Text(
//                   'Click here',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: 50),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 0.5,
//                 child: Expanded(
//                   child: RecipeGrid(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List count = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome page')),
      body: Column(
        children: [
          // 🔍 Top Section: Search + Promo Card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What would you like to cook today?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                // 🎯 Promo Card
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                    image: const DecorationImage(
                      image: AssetImage('lib/asset/food3.jpg'), // optional
                      fit: BoxFit.cover,
                      opacity: 0.1,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Discover the secrets to\nbecoming a master chef!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: null, // add functionality later
                              child: Text('Start Now'),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'lib/asset/food2.jpg', // 👈 your chef image
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 🔽 GridView in Expanded
          Expanded(child: RecipeGrid()),
        ],
      ),
    );
  }
}

class RecipeGrid extends StatefulWidget {
  const RecipeGrid({super.key});

  @override
  State<RecipeGrid> createState() => _RecipeGridState();
}

class _RecipeGridState extends State<RecipeGrid> {
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
    if (recipes.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RecipeDetailPage(recipe: recipe),
              ),
            );
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Hero(
                      tag: recipe['id'],
                      child: CachedNetworkImage(
                        imageUrl: '${recipe["image"] ?? ''}',
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        progressIndicatorBuilder: (context, url, progress) =>
                            CircularProgressIndicator(value: progress.progress),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    recipe["name"] ?? '',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    recipe["difficulty"] ?? '',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';

// class RecipeCarousel extends StatefulWidget {
//   const RecipeCarousel({super.key});

//   @override
//   State<RecipeCarousel> createState() => _RecipeCarouselState();
// }

// class _RecipeCarouselState extends State<RecipeCarousel> {
//   List recipes = [];

//   @override
//   void initState() {
//     super.initState();
//     loadRecipes();
//   }

//   Future<void> loadRecipes() async {
//     try {
//       Map<String, dynamic> prod = await result(); // call your API
//       setState(() {
//         recipes = prod['data'] ?? [];
//       });
//     } catch (e) {
//       print('Error fetching recipes: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (recipes.isEmpty) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return cs.CarouselSlider(
//       options: cs.CarouselOptions(
//         height: 250,
//         autoPlay: true,
//         enlargeCenterPage: true,
//         aspectRatio: 16 / 9,
//       ),
//       items: recipes.map((recipe) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius:
//                         const BorderRadius.vertical(top: Radius.circular(10)),
//                     child: CachedNetworkImage(
//                       imageBuilder: (context, imageProvider) => Container(
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: imageProvider,
//                             fit: BoxFit.cover,
//                             colorFilter: ColorFilter.mode(
//                               Colors.red,
//                               BlendMode.colorBurn,
//                             ),
//                           ),
//                         ),
//                       ),
//                       errorWidget: (context, url, error) => Icon(Icons.error),
//                       imageUrl: '${recipe["image"] ?? ''}',
//                       // imageUrl: 'https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png',
//                       height: 150,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       progressIndicatorBuilder: (
//                         context,
//                         url,
//                         progress,
//                       ) {
//                         return CircularProgressIndicator(
//                           value: progress.progress,
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       recipe["name"] ?? '',
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(
//                       recipe["difficulty"] ?? '',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }
// }
