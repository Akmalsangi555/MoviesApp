import 'dart:async';
import 'package:get/get.dart';
import 'package:movies_task/models/movies_model.dart';
import 'package:movies_task/services/movies_services.dart';

class MoviesListController extends GetxController {
  RxBool isLoading = false.obs;

  final MoviesServices moviesServices = MoviesServices();
  MoviesListModel moviesListModel = MoviesListModel();

  List<String> favMoviesList = [];

  @override
  void onInit() {
    getMoviesList();
    super.onInit();
  }

  Future<bool> getMoviesList() async {
    isLoading.value = true;
    final response = await moviesServices.getMoviesList();

    if (response.data != null) {
      moviesListModel = response.data!;
      isLoading.value = false;
      return true;
    }

    else {
      isLoading.value = false;
      return false;
    }
  }
}
