import 'package:empower_women/backend/thread.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:empower_women/utils/snackbar_ext.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayStories extends StatefulWidget {
  const DisplayStories({super.key});

  @override
  State<DisplayStories> createState() => _DisplayStoriesState();
}

class _DisplayStoriesState extends State<DisplayStories> {
  List<EmpowermentStory> _stories = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchStories();
  }

  Future<void> _fetchStories() async {
    try {
      final response = await Supabase.instance.client
          .from('empowerment_stories')
          .select()
          .order('created_at', ascending: false);

      final stories = (response as List)
          .map((data) => EmpowermentStory.fromJson(data))
          .toList();

      setState(() {
        _stories = stories;
        _isLoading = true;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      context.showSnackbar(message: 'Failed to Load Stories: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: Text(
          'Empowerment Stories',
          style: GoogleFonts.protestStrike(),
        ),
      ),
      backgroundColor: Colors.purple[100],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _stories.isEmpty
              ? const Center(child: Text('No stories found.'))
              : ListView.builder(
                  itemCount: _stories.length,
                  itemBuilder: (context, index) {
                    final story = _stories[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(story.authorName.toUpperCase(),
                                style: GoogleFonts.protestRiot(
                                    color: Colors.purple, fontSize: 15)),
                            const SizedBox(height: 1),
                            Text(story.title,
                                style: GoogleFonts.protestStrike(
                                    color: Colors.grey)),
                            const SizedBox(height: 8),
                            Text(story.content,
                                style: const TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
