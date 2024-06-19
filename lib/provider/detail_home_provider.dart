import 'package:flutter/material.dart';
import 'package:movie_app_provider_kag/models/detail_movie_model.dart';
import 'package:movie_app_provider_kag/services/api_endpoint.dart';
import 'package:movie_app_provider_kag/services/api_services.dart';
import 'package:movie_app_provider_kag/utilities/helper.dart';

class DetailHomeProvider extends ChangeNotifier {
  var id = 0;
  DetailMovieModel? detailMovieModel;
  var loading = DataLoad.done;

  DetailHomeProvider(this.id) {
    getDetailMovie(id);
  }

  void getDetailMovie(int id) async {
    loading = DataLoad.loading;
    notifyListeners();
    try {
      var data = await ApiServices.api(
        endPoint: APiEndpoint.detail,
        type: APIMethod.get,
        param: "/$id",
      );
      detailMovieModel = DetailMovieModel.fromJson(data);
      loading = DataLoad.done;
    } catch (e) {
      loading = DataLoad.failed;
      print('ERROR GET DETAIL MOVIE ${e.toString()}');
    }
    notifyListeners();
  }
}
