import 'dart:convert';

class Food {
  String id;
  String name;
  String imageUrl;
  String Instructions;
  String Category;
  String area;
  Food({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.Instructions,
    required this.Category,
    required this.area
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["idMeal"] ?? "34412",
        name: json["strMeal"] ?? "ulyl si paling",
        imageUrl: json["strMealThumb"] ?? '',
        Instructions: json["strInstructions"] ?? '',
        Category: json["strCategory"] ?? '',
        area: json["strArea"] ?? ""

      );

  static Map<String, dynamic> toMap(Food movie) => {
        'strMeal': movie.name,
        'strMealThumb': movie.imageUrl,
        "strInstructions": movie.Instructions,
        "strCategory": movie.Category,
        "strArea": movie.area,
        "idMeal": movie.id,
      };

  static String encode(List<Food> movie) => json.encode(
        movie.map<Map<String, dynamic>>((movie) => Food.toMap(movie)).toList(),
      );

  static List<Food> decode(String movie) =>
      (json.decode(movie) as List<dynamic>)
          .map<Food>((item) => Food.fromJson(item))
          .toList();
}

List<Food> MovieSkeletonData = [
  Food(
      id: "--",
      name: "-------",
      imageUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fmedium.com%2Fswlh%2Fflutter-shimmer-effect-be9c95e8f64d&psig=AOvVaw3-ObznuFlx-LSqO9sZXgp-&ust=1653833926137000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCLi1sdCxgvgCFQAAAAAdAAAAABAD",
      Category: '------------------------------',
      Instructions: '------------------------------',
      area: '-----'),
      
];
