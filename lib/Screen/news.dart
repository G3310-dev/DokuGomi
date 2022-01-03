import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dokugomi/Screen/News_Page/components/customListTile.dart';
import 'package:flutter/material.dart';
import 'package:dokugomi/Screen/News_Page/model/article_model.dart';
import 'package:dokugomi/Screen/News_Page/services/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class News extends StatefulWidget {
  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  Future<void> connect()async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("I am connected to a mobile network.");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("I am connected to a wifi network.");
    }else{
      Fluttertoast.showToast(msg: "Not Connected to internet" );
    }
  }
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      connect();
    });    connect();
  }
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {



  return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
          toolbarHeight: 45,
          backgroundColor: Colors.white,
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Text("Top News",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
        extendBodyBehindAppBar: true,

        body: Stack(
        children: [
          FutureBuilder(
            future: client.getArticle(),
            builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
              if (snapshot.hasData) {
                List<Article>? articles = snapshot.data;
                return ListView.builder(
                    itemCount: articles?.length,
                    itemBuilder: (context, index) => customListTile(articles![index], context)
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      )
    );
  }
}