import 'package:empower_women/backend/thread.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final News news;

  NewsCard({Key? key, required this.news}) : super(key: key);
  //const NewsCard({super.key});

  void _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.inAppWebView)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ExpansionTile(
        // Handle missing or invalid image URLs
        leading: news.image.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0), // Rounded edges
                child: Image.network(
                  news.image,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                        Icons.broken_image); // Placeholder on error
                  },
                  fit: BoxFit.cover, // Adjust image to fit nicely
                  height: 50,
                  width: 50,
                ),
              )
            : const Icon(Icons
                .image_not_supported), // Show icon if image is null or empty
        title: Text(
          news.title,
          style: GoogleFonts.kanit(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              news.content,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          InkWell(
            child: Text(
              "Read More",
              style: GoogleFonts.kanit(
                color: Colors.blue,
                height: 3,
              ),
            ),
            onTap: () {
              _launchURL(news.url);
            },
          )
        ],
      ),
    );
  }
}
