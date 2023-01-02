import 'package:expenses/Model/Response/MovieListData.dart';

abstract class Repo{

  // Future<BaseData?> getBase(Map<String,dynamic> params) async {}
  Future<MovieListData?> getMovieList(Map<String,dynamic> params) async {
    return null;
  }



}