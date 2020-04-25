import 'dart:convert';

import 'package:challenge3/ConnectivityCheck.dart';
import 'package:challenge3/description.dart';
import 'package:challenge3/models/News.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:page_transition/page_transition.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

String api =
    "your_news_api_key";

class News_Feed extends StatefulWidget {
  @override
  _News_FeedState createState() => _News_FeedState();
}

class _News_FeedState extends State<News_Feed> {
  @override
  void initState() {
    super.initState();
    CheckConnectivity.isConnected().then((isConnected){
      if(!isConnected){
        CheckConnectivity.showInternetDialog(context);
      }
    });
    refreshList();
  }

  bool loading = false;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  List<News> ls_news;
  Future<List<News>> getNews() async {
    final response = await http.get(api);
    final res = jsonDecode(response.body);
    return (res["articles"] as List)
        .map<News>((json) => new News.fromJson(json))
        .toList();
  }

  Future<Null> refreshList() async {
    if(this.mounted){
      setState(() {
      loading = true;
    });
    }
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    // setState(() async {
    // //  list = List.generate(random.nextInt(10), (i) => "Item $i");

    // });
    ls_news = await getNews();
    if(this.mounted){
      setState(() {
      loading = false;
    });
    }

    //    List<News> ls=await  getNews();
    //  NewsList(news:ls);

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "News Feed",
            style: TextStyle(
                fontWeight: FontWeight.w900, ),
          ),
          backgroundColor: Colors.green[700],
        ),
        body: RefreshIndicator(
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
                )
              : ListView.builder(
                  itemCount: ls_news == null ? 0 : ls_news.length,
                  padding: new EdgeInsets.all(8.0),
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      child: new Card(
                        elevation: 1.7,
                        child: new Padding(
                          padding: new EdgeInsets.all(10.0),
                          child: new Column(
                            children: [
                              new Row(
                                children: <Widget>[
                                  new Padding(
                                    padding: new EdgeInsets.only(left: 4.0),
                                    child: new Text(
                                      timeago.format(DateTime.parse(
                                          ls_news[index].publishedAt.toString())),
                                      style: new TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.all(5.0),
                                    child: new Text(
                                      ls_news[index].sourcename!=null?ls_news[index].sourcename:"NDTV",
                                      style: new TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              new Row(
                                children: [
                                  new Expanded(
                                    child: new GestureDetector(
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          new Padding(
                                            padding: new EdgeInsets.only(
                                                left: 4.0,
                                                right: 8.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: new Text(
                                              ls_news[index].title.toString()!=null? ls_news[index].title.toString():"Corona Virus",
                                              style: new TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          new Padding(
                                            padding: new EdgeInsets.only(
                                                left: 4.0,
                                                right: 4.0,
                                                bottom: 4.0),
                                            child: new Text(
                                              ls_news[index].description!=null?ls_news[index].description:"",
                                              style: new TextStyle(
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        // flutterWebviewPlugin.launch(
                                        //     data["articles"][index]["url"],
                                        //     fullScreen: false);
                                         Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: DescriptionPage(ls_news[index].launchurl.toString())));
                                      },
                                    ),
                                  ),
                                  new Column(
                                    children: <Widget>[
                                      new Padding(
                                        padding: new EdgeInsets.only(top: 8.0),
                                        child: new SizedBox(
                                          height: 100.0,
                                          width: 100.0,
                                          child: new Image.network(
                                            ls_news[index].url!=null?ls_news[index].url:"https://image.shutterstock.com/image-vector/illustration-flat-icon-tv-channel-260nw-482689633.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // new Row(
                                      //   children: <Widget>[
                                      //     new GestureDetector(
                                      //       child: new Padding(
                                      //           padding:
                                      //               new EdgeInsets.symmetric(
                                      //                   vertical: 10.0,
                                      //                   horizontal: 5.0),
                                      //           child: buildButtonColumn(
                                      //               Icons.share)),
                                      //       onTap: () {
                                      //         // share(data["articles"][index]
                                      //         //     ["url"]);
                                      //       },
                                      //     ),
                                      //     new GestureDetector(
                                      //       child: new Padding(
                                      //           padding:
                                      //               new EdgeInsets.all(5.0),
                                      //           child: _hasArticle(
                                      //                   data["articles"][index])
                                      //               ? buildButtonColumn(
                                      //                   Icons.bookmark)
                                      //               : buildButtonColumn(
                                      //                   Icons.bookmark_border)),
                                      //       onTap: () {
                                      //         _onBookmarkTap(
                                      //             data["articles"][index]);
                                      //       },
                                      //     ),
                                      //   ],
                                      // )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          onRefresh: refreshList,
        ));
  }

//  Widget build(BuildContext context) {
//       // need to call super method.

//     var width = MediaQuery.of(context).size.width;
//     String title;

//     return Scaffold(
//       appBar: AppBar(
//          backgroundColor: Colors.green[700],
//         title: new Text("News Feed",
//               style: TextStyle(
//               fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),

//       ),
//       body: RefreshIndicator(child:
//       new SafeArea(
//           child: new Column(
//         children: [
//           new Expanded(
//             flex: 1,
//             child: new Container(
//                 width: width,
//                 color: Colors.white,
//                 child: new GestureDetector(
//                   child: new FutureBuilder<List<News>>(
//                     future: getNews(), // a Future<String> or null
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) print(snapshot.error);

//                       return snapshot.hasData
//                           ? ListView.builder(
//       itemCount: snapshot.data?.length,
//       itemBuilder: (context, index) {
//         return new Card(
//           child: new ListTile(
//             leading: Container(
//                       width: 100.0,
//                       height: 100.0,

//                       alignment: Alignment.center,
//                       child: CachedNetworkImage(
//                         imageUrl:  snapshot.data[index].url.toString(),
//                         imageBuilder: (context, imageProvider) => Container(
//                           width: 100.0,
//                           height: 100.0,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: imageProvider, fit: BoxFit.cover),
//                           ),
//                         ),
//                         placeholder: (context, url) =>
//                             CircularProgressIndicator(),
//                         errorWidget: (context, url, error) => Icon(Icons.error),
//                       )),
//             title: Text( snapshot.data[index].title),
//             onTap: () {
//               var url =  snapshot.data[index].url;
//               // Navigator.push(
//               //     context,
//               //     new MaterialPageRoute(
//               //       builder: (BuildContext context) => new DescriptionPage(url),
//               //     ));
//             },
//           ),
//         );
//       },
//     )
//                           : Center(child: CircularProgressIndicator(
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                     Colors.green)));
//                     },
//                   ),
//                 )),
//           ),
//         ],
//       ))
//       , onRefresh: refreshList,
//     ));
//   }
}



// class NewsList extends StatelessWidget {
//   final List<News> news;

//   NewsList({Key key, this.news}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: news.length,
//       itemBuilder: (context, index) {
//         return new Card(
//           child: new ListTile(
//             leading: Container(
//                       width: 100.0,
//                       height: 100.0,

//                       alignment: Alignment.center,
//                       child: CachedNetworkImage(
//                         imageUrl: news[index].url.toString(),
//                         imageBuilder: (context, imageProvider) => Container(
//                           width: 100.0,
//                           height: 100.0,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: imageProvider, fit: BoxFit.cover),
//                           ),
//                         ),
//                         placeholder: (context, url) =>
//                             CircularProgressIndicator(),
//                         errorWidget: (context, url, error) => Icon(Icons.error),
//                       )),
//             title: Text(news[index].title),
//             onTap: () {
//               var url = news[index].url;
//               // Navigator.push(
//               //     context,
//               //     new MaterialPageRoute(
//               //       builder: (BuildContext context) => new DescriptionPage(url),
//               //     ));
//             },
//           ),
//         );
//       },
//     );
//   }
// }
