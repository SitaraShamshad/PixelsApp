import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
class SetWallpaper extends StatefulWidget {
  const SetWallpaper({super.key, required this.ImageLink});
 final String ImageLink;
  @override
  State<SetWallpaper> createState() => _SetWallpaperState();
}

class _SetWallpaperState extends State<SetWallpaper> {
   Future<void>setBackgroundImage()async{
    int location=WallpaperManager.HOME_SCREEN;
    var file=await DefaultCacheManager().getSingleFile(widget.ImageLink);
        final Future<bool> result=WallpaperManager.setWallpaperFromFile(file.path, location);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Container(
            child: Image.network(widget.ImageLink),
          )),
          InkWell(
            onTap: (){
              setBackgroundImage();
            },
            child: Container(
              color: Colors.pinkAccent,
              height: 60,
              width: double.infinity,
              child: Center(
                child: Text(
                  "Set as homescreen",
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
    );
  }
}
