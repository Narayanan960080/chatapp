

class ServerURL {



  static String baseurl = "https://hoblist.com/api/";

  getUrl(RequestType RequestTypes) {
    switch (RequestTypes) {
      case RequestType.movieList:
        return baseurl + RequestType.movieList.name;

    }
  }

}


enum RequestType {

  movieList



}