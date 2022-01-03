import 'package:dokugomi/Screen/News_Page/pages/articles_details_page.dart';
import 'package:flutter/material.dart';
import 'package:dokugomi/Screen/News_Page/model/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

Widget customListTile(Article article, BuildContext context) {
  return InkWell(
        onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticlePage(article: article)));
          },
          child: Container(
                margin: EdgeInsets.all(12.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(15.0),
                   ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      article.urlToImage != null ?
                        Container(
                          height: 200.0,
                          width: MediaQuery.of(context).size.width*0.9,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(article.urlToImage), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ) :
                        Container(
                          height: 200.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage('https://cdn.pixabay.com/photo/2020/08/09/10/53/question-mark-5475172_960_720.jpg'), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      SizedBox(height: 8.0),

                      Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          child: Text(
                            article.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
  );
}
