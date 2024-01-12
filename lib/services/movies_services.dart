import 'package:get/get.dart';
import 'package:movies_task/models/movies_model.dart';
import 'package:movies_task/models/network_client.dart';

import '../models/api_response.dart';

class MoviesServices extends GetxService {
  ///
  ///
  ///
  Future<ApiResponse<MoviesListModel>> getMoviesList() async {
    final resp = await Get.find<NetworkClient>().get<MoviesListModel>(
      'movie',
    );
    if (resp.isSuccess) {
      final result = resp.rawData;
      final data = MoviesListModel.fromJson(result!);
      return resp.copyWith(data: data);
    } else {
      return resp;
    }
  }

  ///
  ///
  ///
}
