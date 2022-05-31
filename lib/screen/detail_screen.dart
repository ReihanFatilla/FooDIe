import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipeapp/helper/utils.dart';
import 'package:recipeapp/model/movie.dart';
import 'package:recipeapp/screen/image_vew_screen.dart';
import 'package:recipeapp/screen/main_page/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sql/pref_helper.dart';

class DetailScreen extends StatefulWidget {
  final Food foodFromHome;
  final String originNav;
  const DetailScreen(
      {Key? key, required this.foodFromHome, required this.originNav})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                            )),
                        Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          print(widget.foodFromHome.imageUrl);
                          if (widget.originNav == "saved") {
                            removeWatchList(
                              widget.foodFromHome.name,
                            );
                          } else {
                            addWatchlist(
                              widget.foodFromHome.name,
                              widget.foodFromHome.Instructions,
                              widget.foodFromHome.Category,
                              widget.foodFromHome.area,
                              widget.foodFromHome.imageUrl,
                              widget.foodFromHome.id
                            );
                          }
                        },
                        icon: widget.originNav == "saved"
                            ? Icon(
                                Icons.delete,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.bookmark_add,
                                color: Colors.black,
                              )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Hero(
                  tag: widget.foodFromHome.imageUrl,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageViewScreen(
                          detailImage: widget.foodFromHome,
                        ),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: widget.foodFromHome.imageUrl,
                        fit: BoxFit.cover,
                        height: 250,
                        width: double.infinity,
                        placeholder: (context, url) => Image.asset(
                          "images/skeleton_image_loading.gif",
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.foodFromHome.name,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.visible,),
                            Text(
                              widget.foodFromHome.area,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      Wrap(
                        children: [
                          Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              widget.foodFromHome.Category,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        ],
                      ),
                    ]),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Instructions",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  widget.foodFromHome.Instructions,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: SizedBox(
      //   height: 40,
      //   width: 40,
      //   child: FloatingActionButton(
      //     onPressed: () {
      //     },
      //     backgroundColor: Colors.black,
      //     child: const Icon(
      //       Icons.bookmark,
      //       size: 18,
      //     ),
      //   ),
      // ));
    );
  }

  void addWatchlist(String title, String desc, String rating, String released,
      String poster_path, String id) {
    final prefs = PreferenceHelper();
    final bookmarkedMovie = Food(
      name: title,
      Instructions: desc,
      Category: rating,
      area: released,
      imageUrl: poster_path,
      id: id,
    );
    prefs.addBookmark(bookmarkedMovie, context);
  }

  void removeWatchList(String title) async {
    final prefs = PreferenceHelper();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    var databasePref = sharedPref.getString("food_key");

    var decodedDb = Food.decode(databasePref!);

    print(decodedDb);
    final index = decodedDb.indexWhere((element) => element.name == title);
    print(decodedDb[index].name);
    prefs.removeBookmark(index, context);
  }
}
