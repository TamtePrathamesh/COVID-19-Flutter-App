import 'package:challenge3/ConnectivityCheck.dart';
import 'package:challenge3/VideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

class YouTubeFeed extends StatefulWidget {
  @override
  _YouTubeFeedState createState() => _YouTubeFeedState();
}

class _YouTubeFeedState extends State<YouTubeFeed> {
  YoutubeAPI _youtubeAPI;
  List<YT_API> _ytResults;
  List<VideoItem> videoItem;
  String videoId;
  bool loading = false;
  ScrollController _scrollController = ScrollController();
  bool _getMoreVideos = false;
  @override
  void initState() {
     CheckConnectivity.isConnected().then((isConnected){
      if(!isConnected){
        CheckConnectivity.showInternetDialog(context);
      }
    });
    super.initState();
    setState(() {
     if(this.mounted){
        loading=true;
     }
    });
    _youtubeAPI = YoutubeAPI("gcp_youtube_api_key",
        type: "video", maxResults: 20);
    _ytResults = [];
    videoItem = [];
    callAPI("#coronavirus");
  
    // _scrollController.addListener(() {
    //   double maxscroll = _scrollController.position.maxScrollExtent;
    //   double currentScroll = _scrollController.position.pixels;

    //   double delta = MediaQuery.of(context).size.height * 0.25;

    //   if (maxscroll - currentScroll <= delta) {}
    // });
  }

  // getMoreVideos() async {
  //   //_getMoreVideos=true;
  //   // List<YT_API>res=await _youtubeAPI.nextPage();
  //   // callAPI("", nextPage: false);
  //   // if(res==null){
  //   //   setState(() {
  //   //     _getMoreVideos=false;
  //   //   });
  //   // }
  //   //   _ytResults.addAll(res);
  //   //   for (YT_API result in _ytResults) {
  //   //   VideoItem item = VideoItem(
  //   //     api: result,
  //   //   );
  //   //   videoItem.add(item);
  //   // }
  //   //   setState(() {

  //   //   });
  //   callAPI("", nextPage: true);
  // }

  Future<Null> callAPI(String query, {bool nextPage}) async {
    if (nextPage == null) {
      _ytResults = await _youtubeAPI.search(query);
    }
    if (nextPage == true)
      _ytResults = await _youtubeAPI.nextPage();
    else
      _ytResults = await _youtubeAPI.prevPage();

    for (YT_API result in _ytResults) {
      VideoItem item = VideoItem(
        api: result,
      );
      videoItem.add(item);
    }
   if(this.mounted){
      setState(() {});
        setState(() {
      if(this.mounted){
        loading=false;
      }
    });
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "YouTube Feed",
          style: TextStyle(
              fontWeight: FontWeight.w900, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.green[700],
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: ButtonBar(
      //     alignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       IconButton(
      //           color: Colors.red,
      //           icon: Icon(Icons.arrow_back),
      //           onPressed: () async {
      //             await callAPI("", nextPage: false);
      //           }),
      //       IconButton(
      //         color: Colors.blueGrey,
      //         icon: Icon(
      //           Icons.arrow_forward,
      //         ),
      //         onPressed: () async {
      //           await callAPI("", nextPage: true);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                loading
                    ? Center(
                        child: SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.green))))
                    : Flexible(
                        child: ListView.builder(
                           // controller: _scrollController,
                            padding: EdgeInsets.all(8.0),
                            itemCount: videoItem.length,
                            itemBuilder: (_, int index) {
                              return videoItem[index];
                            }),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final YT_API api;

  const VideoItem({
    Key key,
    this.api,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          leading: Image.network(api.thumbnail["default"]["url"]),
          title: Text(api.title),
          subtitle: Text(api.channelTitle),
          onTap: () {
            //listPopupTap.onTap(api, context);
            Route _createRoute() {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    VideoScreen(
                  id: api.id,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              );
            }

            // Navigator.of(context).pushReplacement(CupertinoPageRoute(
            //         builder: (context) => MyHomePage(title: 'Corona-HelpApp')
            //       ));s
            Navigator.of(context).push(_createRoute());
          },
        ),
      ),
    );
  }
}
