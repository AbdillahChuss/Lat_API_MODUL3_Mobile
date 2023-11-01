import 'package:flutter/material.dart';
import 'API_Service/api_service.dart';
import 'MODEL_API/model_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsScreen(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ApiService apiService = ApiService();
  List<Article> newsArticles = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final Welcome welcome = await ApiService.fetchData();
      setState(() {
        newsArticles = welcome.articles;
        errorMessage =
            ''; // Mengosongkan pesan kesalahan jika tidak terjadi kesalahan
      });
    } catch (e) {
      setState(() {
        errorMessage =
            'Gagal mengambil data: $e'; // Menampilkan pesan kesalahan
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tesla News'),
      ),
      body: errorMessage.isNotEmpty
          ? Center(
              child: Text(errorMessage),
            )
          : ListView.builder(
              itemCount: newsArticles.length,
              itemBuilder: (context, index) {
                final article = newsArticles[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(article.title),
                    subtitle: Text(article.description ?? ''),
                    onTap: () {
                      // Implement the logic to open the full article here.
                    },
                  ),
                );
              },
            ),
    );
  }
}
