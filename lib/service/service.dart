import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipeapp/model/movie.dart';
import 'package:recipeapp/auth/secrets.dart';

String apiKey = myApiKey;
String baseUrl = "https://www.themealdb.com/api/json/v1/1";

class MovieApi {
  Future<List<Food>> getFoodByPlace(String place) async{
    List<Food>? list;

    String url ="$baseUrl/filter.php?a=$place";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      var result = data["meals"] as List;
      list = result.map((json) => Food.fromJson(json)).toList();
      return list;
    } else {
      throw Exception("Tidak Dapat Mengambil Data");
    }
  }

  Future<List<Food>> getFoodDetail(String id) async{
    List<Food>? list;
    String url ="$baseUrl/lookup.php?i=$id";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      var result = data["meals"] as List;
      list = result.map((json) => Food.fromJson(json)).toList();
      return list;
    } else {
      throw Exception("Tidak Dapat Mengambil Data");
    }
  }

  // Future<List<Movie>?> getPopularMovie() async{
  //   List<Movie>? list;

  //   String url ="$baseUrl/trending/all/day?api_key=$apiKey";

  //   var response = await http.get(Uri.parse(url));
  //   if(response.statusCode == 200){
  //     var data = jsonDecode(response.body);
  //     var result = data["results"] as List;
  //     list = result.map((json) => Movie.fromJson(json)).toList();
  //     return list;
  //   } else {
  //     throw Exception("Tidak Dapat Mengambil Data");
  //   }
  //   return list;
  // }
  
}