var kBaseUrl = "https://api.themoviedb.org/3";

var bearerToken =
    "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNjE0ZWM2ZDg1Y2UxNmM0N2UzZDk3YzlhYTM2NGIyNiIsInN1YiI6IjY0ZmVhYzE0ZGI0ZWQ2MTAzNDNlZTYwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NieZ6VPjub04ZolHWtxGhUzPHpNFnKQBi1epPkC7nEQ";

var baseImage = "https://image.tmdb.org/t/p/w500";

class APiEndpoint {
  static String movie = "/movie/now_playing";
  static String search = "/search/movie";
  static String detail = "/movie";
}
