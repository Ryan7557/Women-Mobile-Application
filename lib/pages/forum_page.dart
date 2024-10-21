import 'package:empower_women/backend/thread.dart';
import 'package:empower_women/utils/snackbar_ext.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ForumPage extends StatefulWidget {
  final String threadId;
  final String threadTitle;

  const ForumPage({Key? key, required this.threadId, required this.threadTitle}) : super(key: key);

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
        title: Text('Thread ${widget.threadTitle}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_comments[index].content),
                      subtitle: Text(
                        'By ${_comments[index].userId} on ${_comments[index].createdAt}',
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        labelText: 'Comment',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _createComment,
                    child: const Text('Comment'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
