import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pixelsapp/setwallpaper.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List images = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  Future<void> fetchApi() async {
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
      headers: {
        'Authorization': 'eynpu3IHipcYc09PV6xQi2l3zisXM69PifijbRzl9Nc3pessE4BzqZf5',
      },
    ).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
    });
  }

  Future<void> loadingmore() async {
    setState(() {
      page += 1;
    });
    await http.get(
        Uri.parse('https://api.pexels.com/v1/curated?page=$page&per_page=80'),
        headers: {
          'Authorization': 'eynpu3IHipcYc09PV6xQi2l3zisXM69PifijbRzl9Nc3pessE4BzqZf5',
        }
    ).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>SetWallpaper(
                            ImageLink: images[index]['src']['tiny'] ,
                          )));
                    },
                    child: Container(
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
            InkWell(
              onTap: (){
                loadingmore();
              },
              child: Container(
                color: Colors.pinkAccent,
                height: 60,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Loading more",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
