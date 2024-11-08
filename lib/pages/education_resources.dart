import 'package:empower_women/backend/thread.dart';
import 'package:empower_women/utils/snackbar_ext.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class EducationResourcesPage extends StatefulWidget {
  const EducationResourcesPage({super.key});

  @override
  State<EducationResourcesPage> createState() => _EducationResourcesPageState();
}

class _EducationResourcesPageState extends State<EducationResourcesPage> {
  List<EducationResource> resources = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEducationResources();
  }

  Future<void> fetchEducationResources() async {
    try {
      final response = await Supabase.instance.client
          .from('education_resources')
          .select()
          .order('added_at', ascending: false);

      setState(() {
        resources =
            response.map((json) => EducationResource.fromJson(json)).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching resources: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      context.showSnackbar(message: 'Could not open the URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Education & Skills Resources",
          style: GoogleFonts.protestStrike(),
        ),
        backgroundColor: Colors.purple[100],
      ),
      backgroundColor: Colors.purple[100],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: resources.length,
              itemBuilder: (context, index) {
                final resource = resources[index];
                return ListTile(
                  title: Text(resource.title, style: GoogleFonts.protestStrike(),),
                  subtitle: Text(resource.description),
                  trailing: IconButton(
                    icon: const Icon(Icons.open_in_new),
                    onPressed: () {
                      _launchURL(resource.url);
                    },
                  ),
                );
              },
            ),
    );
  }
}
