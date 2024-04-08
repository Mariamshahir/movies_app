import 'package:flutter/material.dart';
import 'package:test_movies/data/api_manger.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/models/one_movie_dm.dart';
import 'package:test_movies/widgets/search_widget/search_home.dart';

class ShowMovies extends StatelessWidget {
  static const String routeName = "show_movies";

  ShowMovies({super.key});

  late var resultsList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.loadPopularList(),
      builder: (context, snapshot) {
        //builder return widget
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              const Text("some thing went wrong"),
              ElevatedButton(onPressed: () {}, child: const Text("try again"))
            ],
          );
        } else if (snapshot.data == null) {
          return const Text("some thing went wrong, can not find data ");
        } else {
          //when data return right
          resultsList = snapshot.data!.results;
          return SearchHome(
            allMovies: getMoviesList(),
          );
        }
      },
    );
  }

  List<OneMovieDM> getMoviesList() {
    List<OneMovieDM> allMovies = [];

    for (MovieDM result in resultsList) {
      OneMovieDM movieDM = OneMovieDM(
          backdropPath: "https://image.tmdb.org/t/p/original" + result.backdropPath!,
          title: result.title!,
          releaseDate: result.releaseDate!,
          author: result.originalTitle!);

      allMovies.add(movieDM);
    }
    return allMovies;
  }
// List<String> getTitlesList() {
//   List<String> allTitles = [];
//   print("------------------------------------");
//   print(resultsList);
//   for (Results result in resultsList) {
//     allTitles.add(result.originalTitle!.toLowerCase());
//   }
//   return allTitles;
// }
}