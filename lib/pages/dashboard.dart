import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<MenuList> menus = [];
  List<MenuList> settings = [];

  @override
  void initState() {
    super.initState();
    menus.addAll([
      MenuList(1, "Forum", Icons.chat_bubble, '/create_thread'),
      MenuList(2, "News", Icons.newspaper, '/women_news'),
      MenuList(3, "Inspire", Icons.abc_outlined, '/add_story'),
      MenuList(4, "Inspiration", Icons.power, '/display_stories'),
      MenuList(5, "Education", Icons.book, '/education_resources'),
    ]);

    settings.addAll([
      MenuList(1, "Logout", Icons.logout, '/'),
    ]);
  }

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
        shrinkWrap: true,
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 16),
            child: Text(
              'Dashboard',
              style: GoogleFonts.protestStrike(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 15, right: 15),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
            ),
            itemCount: menus.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, menus[index].route);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(menus[index].icon, color: Colors.black),
                    SizedBox(
                      height: MediaQuery.of(context).size.width > 700 ? 10 : 8,
                    ),
                    Text(
                      // ignore: unnecessary_null_comparison
                      menus[index].title == null
                          ? ""
                          : menus[index].title.toString(),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 16,
            ),
            child: Text(
              'Settings',
              style: GoogleFonts.protestStrike(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 15, right: 15),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
            ),
            itemCount: settings.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, menus[index].route);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(settings[index].icon, color: Colors.black),
                    SizedBox(
                      height: MediaQuery.of(context).size.width > 700 ? 10 : 8,
                    ),
                    Text(
                      // ignore: unnecessary_null_comparison
                      settings[index].title == null
                          ? ""
                          : settings[index].title.toString(),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class MenuList {
  int menuId;
  String title;
  IconData icon;
  String route;

  MenuList(this.menuId, this.title, this.icon, this.route);
}
