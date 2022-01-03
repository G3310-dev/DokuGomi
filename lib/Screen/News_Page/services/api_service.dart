import 'dart:convert';
import 'package:dokugomi/Screen/News_Page/model/article_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final endPointUrl = "newsapi.org";
  final client = http.Client();

  Future<List<Article>> getArticle() async {
    
    final queryParameters = {
      'country': 'us',
      'category': 'science',
      'apiKey': '4a553d1438944a6eb0a6dbd45692d893'
    };

    final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<Article> articles = body.map((dynamic item) => Article.fromJson(item)).toList();
    return articles;
  }
}