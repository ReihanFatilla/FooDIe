import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipeapp/model/movie.dart';
import 'package:recipeapp/service/service.dart';

import '../detail_screen.dart';

class FoodItem extends StatefulWidget {
  final food;
  const FoodItem({ Key? key, required this.food }) : super(key: key);

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  var movieApi = MovieApi();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movieApi.getFoodDetail(widget.food.id),
      builder: (context, snapshot) => snapshot.data != null
      ? _listMovie(snapshot.data as List<Food>)
      : _listMovie(MovieSkeletonData),
 
    );
  }
  Widget _listMovie(List<Food> foodList){
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Row(children: [
          Expanded(
            flex: 4,
            child: Container(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: foodList[0].imageUrl,
                  fit: BoxFit.cover,
                  width: 500,
                  placeholder: (context, url) => Image.asset("images/skeleton_image_loading.gif", fit: BoxFit.cover,),
                  errorWidget: (context, url, error) => Image.asset("images/skeleton_image_loading.gif", fit: BoxFit.cover,),
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: Expanded(
                        child: Container(
                          color: Colors.black,
                          child: Text(
                            foodList[0].Category,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    foodList[0].name,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      foodList[0].Instructions,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 100,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      color: Colors.black,
                      child: Text(
                        "Read More",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              foodFromHome: foodList[0],
                              originNav: "home",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ))
        ]),
      );
  }
}