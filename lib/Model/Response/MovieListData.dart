class MovieListData {
  List<Result>? result;
  QueryParam? queryParam;
  int? code;
  String? message;

  MovieListData({this.result, this.queryParam, this.code, this.message});

  MovieListData.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
    queryParam = json['queryParam'] != null
        ? QueryParam.fromJson(json['queryParam'])
        : null;
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    if (queryParam != null) {
      data['queryParam'] = queryParam!.toJson();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Result {
  String? sId;
  List<String>? director;
  List<String>? writers;
  List<String>? stars;
  int? releasedDate;
  List<String>? productionCompany;
  String? title;
  String? language;
  int? runTime;
  String? genre;
  List<Voted>? voted;
  String? poster;
  int? pageViews;
  String? description;
  int? totalVoted;
  int? voting;

  Result(
      {this.sId,
        this.director,
        this.writers,
        this.stars,
        this.releasedDate,
        this.productionCompany,
        this.title,
        this.language,
        this.runTime,
        this.genre,
        this.voted,
        this.poster,
        this.pageViews,
        this.description,
        this.totalVoted,
        this.voting});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    director = json['director'].cast<String>();
    writers = json['writers'].cast<String>();
    stars = json['stars'].cast<String>();
    releasedDate = json['releasedDate'];
    productionCompany = json['productionCompany'].cast<String>();
    title = json['title'];
    language = json['language'];
    runTime = json['runTime'];
    genre = json['genre'];
    if (json['voted'] != null) {
      voted = <Voted>[];
      json['voted'].forEach((v) {
        voted!.add(Voted.fromJson(v));
      });
    }
    poster = json['poster'];
    pageViews = json['pageViews'];
    description = json['description'];
    totalVoted = json['totalVoted'];
    voting = json['voting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['director'] = director;
    data['writers'] = writers;
    data['stars'] = stars;
    data['releasedDate'] = releasedDate;
    data['productionCompany'] = productionCompany;
    data['title'] = title;
    data['language'] = language;
    data['runTime'] = runTime;
    data['genre'] = genre;
    if (voted != null) {
      data['voted'] = voted!.map((v) => v.toJson()).toList();
    }
    data['poster'] = poster;
    data['pageViews'] = pageViews;
    data['description'] = description;
    data['totalVoted'] = totalVoted;
    data['voting'] = voting;
    return data;
  }
}

class Voted {
  List<String>? upVoted;
  String? sId;
  int? updatedAt;
  String? genre;

  Voted({this.upVoted, this.sId, this.updatedAt, this.genre});

  Voted.fromJson(Map<String, dynamic> json) {
    upVoted = json['upVoted'].cast<String>();

    sId = json['_id'];
    updatedAt = json['updatedAt'];
    genre = json['genre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['upVoted'] = upVoted;

    data['_id'] = sId;
    data['updatedAt'] = updatedAt;
    data['genre'] = genre;
    return data;
  }
}

class QueryParam {
  String? category;
  String? language;
  String? genre;
  String? sort;

  QueryParam({this.category, this.language, this.genre, this.sort});

  QueryParam.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    language = json['language'];
    genre = json['genre'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['language'] = language;
    data['genre'] = genre;
    data['sort'] = sort;
    return data;
  }
}