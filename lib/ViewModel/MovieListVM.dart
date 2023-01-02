import 'package:expenses/Model/Response/MovieListData.dart';
import 'package:flutter/material.dart';
import '../Model/ApiInterface.dart';
import '../Model/ApiResponse.dart';




class MovieListVM extends ChangeNotifier{
  final _myRepo = ApiInterface();

  ApiResponse<MovieListData> origin = ApiResponse.loading();

  ApiResponse<MovieListData> get getData => origin;

  setData(ApiResponse<MovieListData> response) {
    print("Response :: $response");
    print(response.data);
    origin = response;
    notifyListeners();
  }

  Future<void> fetch(Map<String,dynamic> params) async {
    setData( ApiResponse.loading());
    _myRepo.getMovieList(params)
        .then((value) {
      return setData( ApiResponse.completed(value));
    });
    //     .onError((error, stackTrace) {
    //   return setData(ApiResponse.error(error.toString()));
    // });
  }


}