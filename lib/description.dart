import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

//void main() => runApp(new DescriptionPage(null));

class DescriptionPage extends StatelessWidget {
  static String tag = 'description-page';
  num _stackToView = 1;
  DescriptionPage(this.urlnews);
  final String urlnews;




  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Full Article",
          style: TextStyle(
                fontWeight: FontWeight.w900, fontStyle: FontStyle.italic),
          ),
          backgroundColor: Colors.green[700],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        
        child: WebviewScaffold(
          url: urlnews,
        withJavascript: true,
        hidden: true,
        initialChild: Container(
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green)
          ),
        ),
      ),
        ),
      ),
    );
  }
}
