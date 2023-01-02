import 'package:expenses/Model/Response/MovieListData.dart';
import 'ApiClient.dart';
import 'Repository/Repo.dart';
import 'ServerURL.dart';



class ApiInterface implements Repo {

  final ApiClient _apiService = ApiClient();


  @override
  Future<MovieListData?> getMovieList(Map<String, dynamic> params) async {
    try {
      dynamic response = await _apiService.fetchData(ServerURL().getUrl(RequestType.movieList),params);
      print("Response $response");
      final jsonData = MovieListData.fromJson(response);
      return jsonData;
    } catch (e) {
      print("Error $e");
      rethrow;
    }
  }



}