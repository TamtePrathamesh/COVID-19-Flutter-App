import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


 String fireStoreImageUrl(String imageName) =>
    "firestorage_link_of_images";
class MaskUsage extends StatelessWidget {
  static const String routeName = "myth";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.green[700],
        title: Text("Mask Uasage WHO"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => MaskUsageItem(
          height: height,
          index: index + 1,
        ),
        itemCount: 4,
      ),
    );
  }
}

class MaskUsageItem extends StatelessWidget {
  const MaskUsageItem({
    Key key,
    @required this.height,
    this.title,
    this.suffix = "m",
    this.index,
    this.subtitle,
  }) : super(key: key);

  final double height;
  final String title;
  final String subtitle;
  final int index;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PhotoView(
                  loadingBuilder: (context, event) => Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink)
                          ),
                        ),
                      ),
                  backgroundDecoration: BoxDecoration(color: Colors.white),
                  tightMode: true,
                  imageProvider: CachedNetworkImageProvider(
                  
                    fireStoreImageUrl(
                      "m$index",
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}