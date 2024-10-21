import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardItem extends StatelessWidget {
  final String label;
  final String imagePath;
  final String route;

  const DashboardItem({
    Key? key,
    required this.label,
    required this.imagePath,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1.0),
              child: Stack(
                children: [
                  Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5), // Adjust opacity here
                    width: double.infinity,
                    height: 200,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: label,
                        style: GoogleFonts.londrinaSketch(fontSize: 25)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
