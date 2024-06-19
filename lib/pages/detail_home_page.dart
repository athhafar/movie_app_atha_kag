import 'package:flutter/material.dart';
import 'package:movie_app_provider_kag/provider/detail_home_provider.dart';
import 'package:movie_app_provider_kag/utilities/helper.dart';
import 'package:provider/provider.dart';

class DetailMoviePage extends StatelessWidget {
  const DetailMoviePage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (context) => DetailHomeProvider(id),
      child: Consumer<DetailHomeProvider>(
        builder: (context, value, child) => Scaffold(
          body: SingleChildScrollView(
            child: value.loading == DataLoad.loading
                ? const Text("HALAMAN INI SEDANG LOADING")
                : value.loading == DataLoad.failed
                    ? const Text("HALAMAN INI GAGAL LOAD")
                    : value.detailMovieModel == null
                        ? const Text("DATA TIDAK TERSEDIA")
                        : Column(
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    "https://image.tmdb.org/t/p/w500" +
                                        value.detailMovieModel!.backdropPath,
                                    fit: BoxFit.cover,
                                    width: width,
                                    height: height / 2,
                                  ),
                                  Container(
                                    height: height / 2,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          const Color(0XFF000000)
                                              .withOpacity(0),
                                          const Color(0XFF1E1E27),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 64,
                                    left: 32,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                color: const Color(0XFF1E1E27),
                                height: height,
                                width: width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.detailMovieModel!.title,
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      value.detailMovieModel!.releaseDate,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 32.0,
                                    ),
                                    Text(
                                      value.detailMovieModel!.tagline,
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
          ),
        ),
      ),
    );
  }
}
