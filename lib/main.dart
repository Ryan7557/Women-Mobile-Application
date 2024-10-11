import 'package:empower_women/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://yppicwflcmumrspzvyvu.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlwcGljd2ZsY211bXJzcHp2eXZ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjgyODE0MDAsImV4cCI6MjA0Mzg1NzQwMH0.kNKXalFbFtbI_ckaLg4VEqrm1u5WKHW4uPDdW8R-vqY");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Empower Women',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
