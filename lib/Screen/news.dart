import 'package:dokugomi/Screen/News_Page/components/customListTile.dart';
import 'package:flutter/material.dart';
import 'package:dokugomi/Screen/News_Page/model/article_model.dart';
import 'package:dokugomi/Screen/News_Page/services/api_service.dart';

class News extends StatelessWidget {
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