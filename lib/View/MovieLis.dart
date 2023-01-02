import 'package:expenses/View/Helper/StyleData.dart';
import 'package:expenses/ViewModel/MovieListVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/Status.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  final MovieListVM _api = MovieListVM();


  fetchData(){
    Map<String,dynamic> params ={
      "category": "movies",
      "language": "kannada",
      "genre": "all",
      "sort": "voting"
    };
    _api.fetch(params);
  }
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: StyleData.background,
      appBar: AppBar(
        backgroundColor: StyleData.background,
        elevation: 0,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: ChangeNotifierProvider<MovieListVM>(
        create: (BuildContext context) => _api,
        child: Consumer<MovieListVM>(builder: (context, viewModel, _) {
          switch (viewModel.getData.status) {
            case Status.Loading:
              return  const Center(child: CircularProgressIndicator(color: Colors.white,));
            case Status.Error:
              return const Center(child: Center(child: Text("Something Issue"),))  ;
            case Status.Completed:
              var VM = viewModel.getData.data!.result!;
              return
                VM.isEmpty ?
                const Center(child:Center(child: Text("No Record Found",style: TextStyle(fontWeight: FontWeight.bold),),)) :
                ListView.builder(
                  itemCount: viewModel.getData.data!.result!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 140,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10,),
                            SizedBox(
                                height: 130,
                                width: 80,
                                child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network(
                                    VM[index].poster.toString(),
                                    height: 130.0,
                                    fit: BoxFit.fitHeight,
                                  ),
                                )
                            ),
                            const SizedBox(width: 17,),
                            Container(
                                height: 130,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 180,
                                        child: Text(VM[index].title.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 17),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                    const SizedBox(height: 4,),
                                    SizedBox(
                                        width: 180,
                                        child: Text(VM[index].genre.toString(),style: const TextStyle(fontSize: 13),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                    const SizedBox(height: 4,),
                                    SizedBox(
                                        width: 180,
                                        child: Text(VM[index].director![0],style: const TextStyle(fontSize: 13),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                    const SizedBox(height: 4,),
                                    SizedBox(
                                        width: 180,
                                        child: Text(VM[index].stars![0],style: const TextStyle(fontSize: 13,),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                    const SizedBox(height: 4,),
                                    SizedBox(
                                        width: 180,
                                        child: Text("${VM[index].language} | ${VM[index].runTime ?? "120 MINS"}",style: const TextStyle(fontSize: 13),overflow: TextOverflow.ellipsis,maxLines: 1)),
                                    const SizedBox(height: 4,),
                                    Text("${VM[index].pageViews} | Vote by ${VM[index].totalVoted}",style: const TextStyle(fontSize: 13),overflow: TextOverflow.ellipsis,maxLines: 1,),
                                  ],
                                )
                            ),
                            SizedBox(
                              width: 40,
                              child: Center(
                                child:CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Text(VM[index].voting.toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600))) ,
                              ),
                            )
                          ],
                        ),

                      ),
                    );
                  },
                );

            default:
          }
          return Container();
        }),
      ),

    );
  }
}
