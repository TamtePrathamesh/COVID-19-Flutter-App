import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';


    class CheckConnectivity{


    static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static Future<bool> showInternetDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {},
          child: AlertDialog(
            title: Text("Connectivity Problem"),
            content: Text("Please check your connection"),
            actions: <Widget>[
              RaisedButton(
                child: Text("Exit"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                child: Text("Retry.."),
                onPressed: () {
                  CheckConnectivity.isConnected().then((internet) {
                    if (internet) {
                      Navigator.of(context).pop();
                    }
                  });
                },
              )
            ],
          ),
        );
      });

    }
 