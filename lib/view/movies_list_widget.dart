
import 'dart:developer';
import 'package:get/get.dart';
import 'fav_movies_list.dart';
import 'package:flutter/material.dart';
import 'package:movies_task/utils/app_colors.dart';
import 'package:movies_task/utils/app_consts.dart';
import 'package:movies_task/models/movies_model.dart';
import 'package:movies_task/utils/app_text_style.dart';
import 'package:movies_task/utils/preference_labels.dart';
import 'package:movies_task/widgets/loading_indicator.dart';
import 'package:movies_task/controllers/movie_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_task/controllers/preference_controller.dart';

class MoviesListWidget extends StatefulWidget {
  MoviesListWidget({Key? key}) : super(key: key);

  @override
  State<MoviesListWidget> createState() => _MoviesListWidgetState();
}

class _MoviesListWidgetState extends State<MoviesListWidget> {
  final MoviesListController moviesListController = Get.put(MoviesListController());

  @override
  void initState() {
    getPrefsData();
    super.initState();
  }

  void getPrefsData() async {
    moviesListController.favMoviesList = (await AppPreferencesController().getListString(AppPreferencesLabels.favMovies))! ;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Text("Movies APP", style: TextStyle(fontSize: 20,
              color: AppColors.white, fontWeight: FontWeight.bold)),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.bgColor,
          actions: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Get.to(() => FavMoviesList());
              },
            ),
          ]),
      body: Obx(() =>
      moviesListController.isLoading.value ? LoadingIndicator() :
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 05),
              Text("Trending Movies", style: AppTextStyle.boldWhite18),

              SizedBox(height: 12),
              moviesCardDesign(),
            ],
          ),
        ),
      ),
      ),
    );
  }

  SizedBox moviesCardDesign() {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height* 0.85,
      child: ListView.builder(
        itemCount: moviesListController.moviesListModel.results!.length,
        // scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final Results results = moviesListController.moviesListModel.results![index];

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height* 0.38,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.bgColor, width: 3),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          clipBehavior: Clip.hardEdge,
                          child: CachedNetworkImage(
                            imageUrl: "${AppConsts.imagesPath}${results.posterPath!}",
                            width: MediaQuery.of(context).size.width ,
                            height: MediaQuery.of(context).size.height * 0.25,
                            fit: BoxFit.fill,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => LoadingIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                        iconSize: 30,
                        onPressed: () {
                          moviesListController.isLoading.value = true;

                          if (moviesListController.favMoviesList.contains(results.id.toString())) {
                            moviesListController.favMoviesList.remove(results.id.toString());

                            AppPreferencesController().setListString(AppPreferencesLabels.favMovies,
                              moviesListController.favMoviesList.toSet().toList(),
                            );
                          } else {
                            moviesListController.favMoviesList.add(results.id!.toString());

                            AppPreferencesController().setListString(AppPreferencesLabels.favMovies,
                              moviesListController.favMoviesList.toSet().toList(),
                            );
                          }
                          log(moviesListController.favMoviesList.toString());
                          moviesListController.isLoading.value = false;
                        },
                        icon: moviesListController.favMoviesList.contains(results.id.toString())
                            ? Icon(Icons.favorite, color: AppColors.red,)
                            : Icon(Icons.favorite_border, color: AppColors.white,),
                    )
                  ],
                ),
                SizedBox(height: 05),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ", style: AppTextStyle.boldWhite12),
                    Flexible(
                      child: Text(moviesListController.moviesListModel.results![index].title!,
                        style: AppTextStyle.boldWhite12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Release Date: ", style: AppTextStyle.boldWhite12),
                    Text(moviesListController.moviesListModel.results![index].releaseDate!,
                      style: AppTextStyle.boldWhite12),
                  ],
                ),
                SizedBox(height: 0),

                Text("Overview: ", style: AppTextStyle.boldWhite12),
                Flexible(
                  child: Text(moviesListController.moviesListModel.results![index].overview!,
                    style: AppTextStyle.boldWhite12, overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
