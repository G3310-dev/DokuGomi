import 'package:flutter/material.dart';
import 'package:dokugomi/Screen/News_Page/model/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  ArticlePage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        article.urlToImage != null ?
                        ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                      ),
                      child: Image.network(article.urlToImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*0.6,
                      ),
                    ) :
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                        ),
                        child: Image.network('https://cdn.pixabay.com/photo/2020/08/09/10/53/question-mark-5475172_960_720.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height*0.4,
                        ),
                    ),

                      Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(
                          article.title,
                          style:TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      "Description :",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff616161),

                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5,left: 10, right: 10),
                    child: Text(
                      article.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff616161),
                      ),
                    ),
                  ),]
                  ),
                ),
                Spacer(),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      launch(article.url);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width*0.8,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xff9e9e9e),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child:  Text(
                        'Read Full Article ->',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      );
  }
}