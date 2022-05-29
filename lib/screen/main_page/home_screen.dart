import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:recipeapp/model/movie.dart';
import 'package:recipeapp/screen/detail_screen.dart';
import 'package:recipeapp/screen/widget/carousel_slider.dart';
import 'package:recipeapp/screen/widget/movie_item.dart';
import 'package:recipeapp/service/service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movie = MovieApi();

    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Text(
                "Featured Recipes",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: movie.getFoodByPlace("Canadian"),
                  builder: (context, snapshot) => snapshot.data != null
                      ? _carouselMovie(snapshot.data as List<Food>)
                      : _carouselMovie(MovieSkeletonData)),
              SizedBox(
                height: 10,
              ),
              Text(
                "Today's Trending",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: movie.getFoodByPlace("American"),
                  builder: (context, snapshot) => snapshot.data != null
                      ? _listMovie(snapshot.data as List<Food>)
                      : _listMovie(MovieSkeletonData)),
            ],
          )),
    ));
  }

  Widget _listMovie(List<Food> movie) {
    return ListView.builder(
        itemBuilder: (context, index) => FoodItem(food: movie[index]),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: movie.length);
  }

  Widget _carouselMovie(List<Food> movie) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15, ),
      child: CarouselSlider.builder(
        itemCount: movie.length,
        options: CarouselOptions(
          enlargeCenterPage: true,
          height: 350,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          viewportFraction: 0.7,
          aspectRatio: 5.0,
        ),
        itemBuilder: (context, i, id) {
          print(movie[i].imageUrl);
          return FoodCarouselSlider(food: movie[i]);
        },
      ),
    );
  }
}
