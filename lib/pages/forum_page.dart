import 'package:empower_women/backend/thread.dart';
import 'package:empower_women/utils/snackbar_ext.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ForumPage extends StatefulWidget {
  final String threadId;
  final String threadTitle;

  const ForumPage(
      {super.key, required this.threadId, required this.threadTitle});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final _commentController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Comment> _comments = [];

  Future<void> _loadComments() async {
    print('Thread ID: ${widget.threadId}');

    // Check if the thread ID is valid (not empty and valid UUID)
    if (widget.threadId.isEmpty || !isValidUUID(widget.threadId)) {
      print('Invalid threadId. Please pass a valid UUID.');
      return;
    }

    try {
      final response = await _supabase
          .from('comments')
          .select('*')
          .eq('thread_id', widget.threadId);

      setState(() {
        _comments = response.map((e) => Comment.fromJson(e)).toList();
      });
    } catch (e) {
      print('Error loading comments: $e');
    }
  }

  bool isValidUUID(String? uuid) {
    if (uuid == null) return false;
    return RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$')
        .hasMatch(uuid);
  }

  Future<void> _createComment() async {
    try {
      print('Thread ID: $widget.threadId');

      //print('User ID: ${user.id}');
      if (!isValidUUID(widget.threadId)) {
        context.showSnackbar(
          message: 'Invalid threadId. Please pass a valid UUID.',
          backgroundColor: Colors.amber,
        );
        return;
      }

      final userResponse = await _supabase.auth.getUser();
      final user = userResponse.user;

      if (user != null) {
        await _supabase.from('comments').insert([
          {
            'id': const Uuid().v4(),
            'thread_id': widget.threadId,
            'user_id': user.id,
            'content': _commentController.text,
            'created_at': DateTime.now().toIso8601String(),
          }
        ]);

        _commentController.clear();
        _loadComments();
        context.showSnackbar(
          message: 'Comment created successfully',
          backgroundColor: Colors.green,
        );
      } else {
        context.showSnackbar(
          message: 'Please log in to comment.',
          backgroundColor: Colors.amber,
        );
      }
    } catch (e) {
      if (e is PostgrestException) {
        context.showSnackbar(
          message: e.message,
          backgroundColor: Colors.amber,
        );
      } else {
        context.showSnackbar(
          message: 'Unknown error',
          backgroundColor: Colors.amber,
        );
      }
      print('Error creating comment: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.threadTitle,
          style: GoogleFonts.protestStrike(),
        ),
        backgroundColor: Colors.purple[100],
      ),
      backgroundColor: Colors.purple[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _comments[index].content,
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'By ${_comments[index].userId} on ${_formatDateTime(_comments[index].createdAt)}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      labelText: 'Comment...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _createComment,
                  child: const Text('Send'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm')
        .format(dateTime); // Custom date format
  }
}
