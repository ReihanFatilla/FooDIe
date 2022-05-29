import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipeapp/screen/detail_screen.dart';

class FoodCarouselSlider extends StatelessWidget {
  final food;
  const FoodCarouselSlider({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Hero(
        tag: food.imageUrl,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child:
          CachedNetworkImage(
            imageUrl: food.imageUrl,
            fit: BoxFit.cover,
            width: 500,
            placeholder: (context, url) => Image.asset("images/skeleton_image_loading.gif", fit: BoxFit.cover,),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          // child: Image.network(
          //   food.poster_path,
          //   width: 500,
          //   fit: BoxFit.cover,
          //   loadingBuilder: (BuildContext context, Widget child,
          //           ImageChunkEvent? loadingProgress) {
          //         if (loadingProgress == null) return child;
          //         return Center(
          //           child: CircularProgressIndicator(
          //             value: loadingProgress.expectedTotalBytes != null
          //                 ? loadingProgress.cumulativeBytesLoaded /
          //                     loadingProgress.expectedTotalBytes!
          //                 : null,
          //           ),
          //         );
          //       },
          // ),
        ),
      ),
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => DetailScreen(
      //         foodFromHome: food,
      //         originNav: "home",
      //       ),
      //     ),
      //   );
      // },
    );
  }
}
