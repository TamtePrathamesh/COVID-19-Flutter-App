import 'dart:convert';
import 'dart:ui';
import 'package:challenge3/BarChart.dart';
import 'package:challenge3/CMaps.dart';
import 'package:challenge3/ConnectivityCheck.dart';
import 'package:challenge3/CovidTracker.dart';
import 'package:challenge3/News_Feed.dart';
import 'package:challenge3/Service/CovidTrackerService.dart';
import 'package:challenge3/description.dart';
import 'package:challenge3/faq_page.dart';
import 'package:challenge3/maskusage.dart';
import 'package:challenge3/models/IndiaStateData.dart';
import 'package:challenge3/myth_page.dart';
import 'package:challenge3/helpline.dart';
import 'package:challenge3/models/Covid.dart';
import 'package:challenge3/protech_page.dart';
import 'package:challenge3/widgets/TextCard.dart';
import 'package:challenge3/widgets/data_card.dart';
import 'package:challenge3/widgets/pie_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:challenge3/YouTube_Feed.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:http/http.dart' as http;
import 'package:custom_splash/custom_splash.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:challenge3/Service/Services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => CovidTrackerService()),
      ChangeNotifierProvider(create: (_) => DailyProvider()),
      ChangeNotifierProvider(create: (_) => ProvinceProvider()),
      ChangeNotifierProvider(create: (_) => CovidTrackerCountry()),
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Corona',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: AnimatedSplash(

      //   imagePath: 'assets/icon/covid19.png',
      //   home: MyHomePage(title: 'Corona-HelpApp'),
      //   duration: 2500,
      //   type: AnimatedSplashType.StaticDuration,
      // ),
      home: CustomSplash(
        imagePath: 'assets/icon/covid19.png',
        backGroundColor: Colors.green[700],
        animationEffect: 'fade-in',
        logoSize: 200,
        home: MyHomePage(title: 'Corona-HelpApp'),
        duration: 2500,
        type: CustomSplashType.StaticDuration,
      ),
    );
  }
}

String covid_count_api = "your_api_key";

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  
 
  bool countloading = false;
  Covid covid_res;
  bool loadingstatedata = false;
  List<IndiaStateData> indata;
  Size size;
  YoutubePlayerController _controller;

   static List<OrdinalSales> statedata=[];
  @override
  Widget build(BuildContext context) {
    // final statsProvider = Provider.of<StatsProvider>(context);
      final height = MediaQuery.of(context).size.height;
    size = MediaQuery.of(context).size;

   
    return Scaffold(
        drawer: Drawer(
          elevation: 3,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.3,
                child: DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Image.asset(
                            "assets/icon/dothefivegif.gif",
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                // Icon(OMIcons.slowMotionVideo),
                leading: Icon(
                  OMIcons.slowMotionVideo,
                  color: Colors.red,
                ),
                title: Text(
                  'YouTube Feed',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: YouTubeFeed()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  CupertinoIcons.news,
                  color: Colors.pink,
                ),
                title: Text(
                  'News Feed',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: News_Feed()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  OMIcons.person,
                  color: Colors.blue,
                ),
                title: Text(
                  'Spiritual Practices For Covid',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: DescriptionPage(
                              "https://isha.sadhguru.org/us/en/blog/article/offerings-sadhguru-challenging-times")));
                },
              ),
              Divider(),
              ListTile(
                leading: Image.asset(
                  'assets/icon/virus.png',
                  width: 25,
                  height: 25,
                ),
                title: Text(
                  'Covid Tracker',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: CovidTracker()));
                },
              ),
              Divider(),
              ListTile(
                leading:Icon(OMIcons.localPharmacy,color: Colors.orange,),
                title: Text(
                  'Instructions on Mask WHO',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: MaskUsage()));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          // Text(widget.title,style: TextStyle(fontWeight: FontWeight.w900,fontStyle: FontStyle.italic),),
          title: Image.asset('assets/icon/covid19.png', height: 20.0),
          backgroundColor: Colors.green[700],
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: CMyMaps()));
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        side: BorderSide(width: 5, color: Colors.orange)),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        " \"Those who are sensible will survive these  situations. Those who are senseless will be brave and dead. \" \n -coronavirus ",
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
              ),
              
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    customButtonWidget(
                        leadingIcon: Icon(OMIcons.call),
                        text: 'COVID-19 HelpLine',
                        endIcon: Icon(OMIcons.arrowForwardIos),
                        color: Colors.greenAccent[200],
                        ontap: () {
                          print('button 1 tapped');
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: helpline()));
                        }),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 20.0,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: FAQPage()));
                          },
                          child: Text(
                            "FAQ",
                            style: TextStyle(),
                          ),
                          color: Colors.pink,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        RaisedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => YoutubePlayer(
                                      controller: _controller,
                                      showVideoProgressIndicator: true,
                                      progressIndicatorColor: Colors.pink,
                                    ));
                          },
                          color: Colors.purple,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text("What is coronavirus?"),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: MythPage()));
                          },
                          child: Text("Myth-busters"),
                          color: Colors.orange,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: ProtectPage()));
                          },
                          child: Text("Protect yourself"),
                          color: Colors.green,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 9,
              ),
             // Text("Helpline Email ID : ncov2019@gov.in"),
             RichText(text:   TextSpan(children: [
                TextSpan(text:"Helpline Email ID : ",style: TextStyle(color:Colors.black)),
                  TextSpan(
                  text: 'ncov2019@gov.in',
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () { launchMailer('ncov2019@gov.in');
                  },
                ),
               ]),),
              SizedBox(
                height: 9,
              ),
              countloading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green))
                  : Container(
                      padding: EdgeInsets.all(15),
                      child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(2),
                                  topRight: Radius.circular(2))),
                          //side: BorderSide( color: Colors.black)),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.info_outline,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("India Corona Cases",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: <Widget>[
                                    //Icon(Icons.timer, color: Colors.black),
                                    //  SizedBox(width: 2),
                                    Flexible(
                                        child: ListTile(
                                      title: Text(
                                        "LastUpdated:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      subtitle: Text(covid_res.lastupdate,
                                          style: TextStyle()),
                                    ))
                                  ],
                                ),
                                titleWidget(
                                    'Confirmed',
                                    covid_res.confvalue.toString() ?? '',
                                    Colors.blue),
                                titleWidget(
                                    'Recovered',
                                    covid_res.recvalue.toString() ?? '',
                                    Colors.green),
                                titleWidget(
                                    'Deaths',
                                    covid_res.deaths.toString() ?? '',
                                    Colors.red),
                                DataCard(
                                  children: <Widget>[
                                    TextStatsCard(
                                      label: 'Recovery Rate',
                                      numbers:
                                          "${((covid_res.recvalue / covid_res.confvalue) * 100).toStringAsFixed(2)} %",
                                      color: Colors.green,
                                    ),
                                    TextStatsCard(
                                        label: 'Death Rate',
                                        numbers:
                                            "${((covid_res.deaths / covid_res.confvalue) * 100).toStringAsFixed(2)} %",
                                        color: Colors.red),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
              SizedBox(
                height: 10,
              ),
              countloading
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 20),
                      child: DrawPieChart(
                        model: covid_res,
                      ),
                    ),

              SizedBox(
                height: 10,
              ), //loading here state wise india data
              loadingstatedata
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green))
                      
                  : Container(
                    padding: EdgeInsets.all(20),
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("Statewise Corona Cases",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        )),
                              Divider(),
                             SizedBox(
                               height: MediaQuery.of(context).size.height*1.4,
                               child: SubscriberChart(data: statedata,),
                             )

                          //     ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          // scrollDirection: Axis.vertical,
                          // itemCount: indata == null ? 0 : indata.length,
                          // padding: new EdgeInsets.all(8.0),
                          // itemBuilder: (BuildContext context, int index) {
                          //   return titleWidget(indata[index].name,
                          //       indata[index].confirmed, Colors.black);
                          // })
                            ],
                          ),
                        ),
                      ),
                    ),
               
            ],
          ),
        ));
  }
 launchMailer( String to) async {
    
    var url = "mailto:$to?subject='COVID19' ";  
    if (await canLaunch(url)) {
       await launch(url);
    } else {
      throw 'Could not launch $url';
    }   
}
  Widget titleWidget(title, subtitle, color) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
              color: color, fontSize: 17, fontWeight: FontWeight.w500)),
      trailing: Text(subtitle, style: TextStyle(color: color, fontSize: 14)),
    );
  }

  


  Widget customButtonWidget(
      {Icon leadingIcon,
      String text,
      Icon endIcon,
      Function ontap,
      Color color}) {
    return Center(
        child: Card(
      elevation: 5,
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          color: color,
          height: 50,
          width: size.width / 1.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              leadingIcon,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              endIcon
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadcount();
    loadIndiaStateData();
    CheckConnectivity.isConnected().then((isConnected) {
      if (!isConnected) {
        CheckConnectivity.showInternetDialog(context);
      }
    });
    _controller = YoutubePlayerController(
      initialVideoId: 'mOV1aBVYKGA',
      flags: YoutubePlayerFlags(
          autoPlay: true,
          enableCaption: true,
          hideThumbnail: false,
          forceHideAnnotation: true),
    );
  }

  Future<void> loadcount() async {
    setState(() {
      countloading = true;
    });
    covid_res = await getIndiaCount();
    print("covid deaths is" + covid_res.deaths.toString());
    setState(() {
      countloading = false;
    });
  }

  Future<void> loadIndiaStateData() async {
    List<OrdinalSales>dummy=[];
    if (this.mounted) {
      setState(() {
        loadingstatedata = true;
      });
    }
    indata = await Services.getINStateData();
    print("India State  data  is" + indata[0].name);
    for(int i=0;i<indata.length;i++){
     
      dummy.add( new OrdinalSales( state: indata[i].name,confirmed: int.parse(indata[i].confirmed)));
    }
    if (this.mounted) {
      setState(() {
        statedata=dummy;
        loadingstatedata = false;
      });
    }
  }

  Future<Covid> getIndiaCount() async {
    final response = await http.get(covid_count_api);
    return Covid.fromJson(json.decode(response.body));
  }
}


