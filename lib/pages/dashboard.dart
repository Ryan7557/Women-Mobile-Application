import 'package:empower_women/components/my_listview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Empowerment',
          style: GoogleFonts.protestStrike(),
        ),
        backgroundColor: Colors.purple[100],
        leading: const Icon(
          Icons.woo_commerce_rounded,
          size: 35,
        ),
        leadingWidth: 20,
        elevation: 4,
      ),
      backgroundColor: Colors.purple[100],
      body: ListView(
        children: [
          const SizedBox(height: 10),
          Center(
              child: Text(
            'Welcome Ladies, Please Choose Any Option Below',
            style: GoogleFonts.protestStrike(fontSize: 16),
          )),
          const SizedBox(height: 10),
          const DashboardItem(
            label: 'Forum/Discussion',
            imagePath: 'images/inspire.jpg',
            route: '/create_thread',
          ),
          //const SizedBox(height: 10),
          const Divider(
            height: 5,
            color: Colors.black54,
            indent: 16.0,
            endIndent: 16.0,
          ),
          const DashboardItem(
            label: 'Inspiration and News',
            imagePath: 'images/inspire.jpg',
            route: '/page1',
          ),
          //const SizedBox(height: 10),
          const Divider(
            height: 5,
            color: Colors.black54,
            indent: 16.0,
            endIndent: 16.0,
          ),
          const DashboardItem(
            label: 'Resource Directory',
            imagePath: 'images/directory.jpg',
            route: '/page1',
          ),
          const Divider(
            height: 5,
            color: Colors.black54,
            indent: 16.0,
            endIndent: 16.0,
          ),
        ],
      ),
    );
  }
}
