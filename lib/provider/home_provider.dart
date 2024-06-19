import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app_provider_kag/models/movie_model.dart';
import 'package:movie_app_provider_kag/models/search_model.dart';
import 'package:movie_app_provider_kag/services/api_endpoint.dart';
import 'package:movie_app_provider_kag/services/api_services.dart';
import 'package:movie_app_provider_kag/utilities/helper.dart';

class HomeProvider extends ChangeNotifier {
  var loading = DataLoad.done;
  List<MovieListModel> listMovie = [];
  int currentPage = 1;
  int pageSize = 10;
  bool enablePullUp = true;

  HomeProvider() {
    getListMovie();
  }

  List<SearchModel> searchMovieModel = [];
  String valueSearch = '';
  bool isSearch = false;

  void getListMovie({bool reset = false}) async {
    if (reset) {
      currentPage = 1;
      listMovie.clear();
      enablePullUp = true;
      notifyListeners();
    }
    if (currentPage == 1) {
      loading = DataLoad.loading;
      notifyListeners();
    }

    try {
      var data = await ApiServices.api(
        endPoint: APiEndpoint.movie,
        type: APIMethod.get,
        param: "?page=$currentPage",
      );

      if (data['results'] != null) {
        var dataList = data['results'] as List;
        if (dataList.isEmpty) {
          enablePullUp = false;
        }
        List<MovieListModel> list =
            dataList.map((e) => MovieListModel.fromJson(e)).toList();
        listMovie.addAll(list);
        currentPage += 1;
        loading = DataLoad.done;
      } else {
        enablePullUp = false;
        loading = DataLoad.failed;
      }
    } catch (e) {
      print('ERROR GET LIST MOVIE ${e.toString()}');
      loading = DataLoad.failed;
    }
    notifyListeners();
  }

  void searchValue() async {
    loading = DataLoad.loading;
    notifyListeners();

    try {
      var data = await ApiServices.api(
        type: APIMethod.get,
        endPoint: APiEndpoint.search,
        param: "?query=$valueSearch",
      );
      if (data['results'] != null) {
        var dataSearch = data['results'] as List;
        List<SearchModel> list =
            dataSearch.map((e) => SearchModel.fromJson(e)).toList();
        searchMovieModel = list;
        loading = DataLoad.done;
      } else {
        loading = DataLoad.failed;
      }
    } catch (e) {
      loading = DataLoad.failed;
      print('ERROR SEARCH MOVIE: ${e.toString()}');
    }
    notifyListeners();
  }
}
