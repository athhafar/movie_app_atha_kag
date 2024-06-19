import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app_provider_kag/pages/detail_home_page.dart';
import 'package:movie_app_provider_kag/provider/home_provider.dart';
import 'package:movie_app_provider_kag/utilities/helper.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final RefreshController refreshController = RefreshController();
  TextEditingController textEditingController = TextEditingController();
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            TextFormField(
              controller: textEditingController,
              onChanged: (text) {
                if (_timer?.isActive ?? false) _timer?.cancel();
                _timer = Timer(const Duration(milliseconds: 200), () {
                  value.isSearch = text.isNotEmpty;
                  value.valueSearch = text;
                  value.searchValue();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: IconButton(
                  onPressed: () {
                    value.isSearch = false;
                    value.searchMovieModel.clear();
                    textEditingController.clear();
                    value.valueSearch = "";
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(Icons.close, size: 32),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            Expanded(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: value.enablePullUp,
                controller: refreshController,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 1000));
                  refreshController.refreshCompleted();
                  value.getListMovie(reset: true);
                },
                onLoading: () async {
                  await Future.delayed(const Duration(milliseconds: 1000));
                  value.getListMovie();
                  refreshController.loadComplete();
                },
                child: value.isSearch
                    ? _buildSearchResultList(value)
                    : _buildMovieList(value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultList(HomeProvider value) {
    if (value.loading == DataLoad.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (value.loading == DataLoad.failed) {
      return Center(child: Text("Failed to load search results"));
    } else {
      return ListView.builder(
        itemCount: value.searchMovieModel.length,
        itemBuilder: (context, index) {
          var movie = value.searchMovieModel[index];
          return ListTile(
            title: Text(movie.title),
            subtitle: Text(movie.originalTitle),
            onTap: () {
              Get.to(DetailMoviePage(id: movie.id));
            },
          );
        },
      );
    }
  }

  Widget _buildMovieList(HomeProvider value) {
    if (value.loading == DataLoad.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (value.loading == DataLoad.failed) {
      return Center(child: Text("Failed to load movies"));
    } else {
      return ListView.builder(
        itemCount: value.listMovie.length,
        itemBuilder: (context, index) {
          var movie = value.listMovie[index];
          return ListTile(
            title: Text(movie.title),
            subtitle: Text(movie.originalTitle),
            onTap: () {
              Get.to(DetailMoviePage(id: movie.id));
            },
          );
        },
      );
    }
  }
}
