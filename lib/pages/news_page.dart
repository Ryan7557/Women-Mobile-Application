import 'package:empower_women/backend/news_api_service.dart';
import 'package:empower_women/backend/thread.dart';
import 'package:empower_women/components/news_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<News>> _newsList;

  @override
  void initState() {
    super.initState();
    _newsList = NewsApiService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Women News',
          style: GoogleFonts.protestRiot(),
        ),
      ),
      backgroundColor: Colors.purple[100],
      body: FutureBuilder<List<News>>(
        future: _newsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news articles found.'));
          } else {
            final newsArticles = snapshot.data ?? [];
            return ListView.builder(
              itemCount: newsArticles.length,
              itemBuilder: (context, index) {
                return NewsCard(news: newsArticles[index]);
              },
            );
          }
        },
      ),
    );
  }
}
