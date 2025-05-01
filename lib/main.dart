import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:onboard/functiondio.dart';
import 'package:onboard/onboardingScreen.dart';
import 'package:onboard/vaiable.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

List count = [];

class _MyHomePageState extends ConsumerState<MyHomePage> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool isfirstRun = await IsFirstRun.isFirstRun();
      ref.read(firstRunProvider.notifier).state = isfirstRun;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ref.watch(ifr)
          ? Onboardingscreen()
          : Scaffold(
              appBar: AppBar(title: Text('HomePage'), centerTitle: true),
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.purpleAccent,
                          ),
                        ),
                        onPressed: () async {
                          Map<String, dynamic> prod = await result();
                          setState(() {
                            count = prod['data'];
                          });
                        },
                        child: Text(
                          'Click here',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          itemCount: count.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CachedNetworkImage(
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                imageUrl: '${count[index]['images'][0]}',
                                // imageUrl: 'https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png',
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

                              // Image(image: CachedNetworkImageProvider(count[index]['images'][0],)),

                              //  Image.network(
                              //   count[index]['images'][0],
                              // ),
                              trailing: Icon(Icons.arrow_forward_ios_rounded),
                              title: Text(count[index]['title']),
                              subtitle: Text(count[index]['brand'] ?? ''),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
