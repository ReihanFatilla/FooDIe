import 'package:flutter/material.dart';
import 'package:recipeapp/helper/utils.dart';
import 'package:recipeapp/model/movie.dart';
import 'package:recipeapp/model/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper{

  // Add Bookmark
  void addBookmark(Food selectedFood, context ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? previousDataString = prefs.getString('food_key');

    if(previousDataString.toString().contains(selectedFood.name.toString())){
      ScaffoldMessenger.of(context).showSnackBar(HelperFunction.showMySnackBar(selectedFood.name + " Is Already in Watch List"));
      return;
    }

    List<Food>? previousData =
        previousDataString == null ? null : Food.decode(previousDataString);
      

    if (previousData == null) {
      final List<Food> books = [selectedFood];
      prefs.setString('food_key', Food.encode(books));
    } else {
      previousData.add(selectedFood);
      prefs.setString('food_key', Food.encode(previousData));
      ScaffoldMessenger.of(context).showSnackBar(HelperFunction.showMySnackBar(selectedFood.name + " Bookmarked!"));
      print(prefs.getString("food_key"));
    }
  }

  // Get Bookmark
  Future<List<Food>> getBookmark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? booksString = await prefs.getString('food_key');

    final List<Food> food = Food.decode(booksString!);
    return food;
  }

  void removeBookmark(int index, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final previousDataString = prefs.getString('food_key');

    List<Food>? previousData =
        previousDataString == null ? null : Food.decode(previousDataString);

    if (previousData == null) {
      return;
    } else {
      final List<Food> books = [...previousData];
      ScaffoldMessenger.of(context).showSnackBar(HelperFunction.showMySnackBar(books[index].name + " Removed from Bookmark"));
      books.remove(books[index]);
      prefs.setString('food_key', Food.encode(books));
    }
  }

  // Clear Bookmark
static Future clearBookmark() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
  
// // Write DATA
// static Future saveBookmark(String title, String desc, String rating, String released, String poster_path) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     await sharedPreferences.setString(title, title);
//     await sharedPreferences.setString(desc, desc);
//     await sharedPreferences.setString(rating, rating);
//     await sharedPreferences.setString(released, released);
//     await sharedPreferences.setString(poster_path, poster_path);
//   }
  
    
// // Read Data


// static Future<BookmarkFood> getBookmark(String title, String desc, String rating, String released, String poster_path) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String? mTitle = sharedPreferences.getString(title);
//     String? mDesc = sharedPreferences.getString(desc);
//     String? mRating = sharedPreferences.getString(rating);
//     String? mReleased = sharedPreferences.getString(released);
//     String? mPosterPath = sharedPreferences.getString(poster_path);

//     BookmarkMovie newBookmark = BookmarkMovie(
//       title: mTitle,
//       desc: mDesc,
//       rating: mRating,
//       released: mReleased,
//       poster_path: mPosterPath,
//     );

//     return newBookmark;
//   }
}