import 'package:empower_women/pages/categories.dart';
import 'package:empower_women/pages/create_thread_form.dart';
import 'package:empower_women/pages/dashboard.dart';
import 'package:empower_women/pages/display_story.dart';
import 'package:empower_women/pages/education_resources.dart';
import 'package:empower_women/pages/empowerment_page.dart';
import 'package:empower_women/pages/login.dart';
import 'package:empower_women/pages/news_page.dart';
import 'package:empower_women/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://ysypylovyibmawsmygmh.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlzeXB5bG92eWlibWF3c215Z21oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDgwMTcsImV4cCI6MjA0NDc4NDAxN30.ynT94sTh5lBUnXR3XVbDCQfaJxOOlHpQoiJPu9M6ypc");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empower Women',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/create_thread': (context) => const CreateThreadForm(),
        '/dashboard': (context) => const DashboardPage(),
        '/register': (context) => const Register(),
        '/create_category': (context) => const CreateCategoryForm(),
        '/women_news': (context) => const NewsPage(),
        '/add_story': (context) => const AddStoryPage(),
        '/display_stories': (context) => const DisplayStories(),
        '/education_resources': (context) => const EducationResourcesPage()
      },
    );
  }
}
