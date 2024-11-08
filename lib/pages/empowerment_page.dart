import 'package:empower_women/utils/snackbar_ext.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:empower_women/backend/thread.dart';
import 'package:uuid/uuid.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _authorNameController = TextEditingController();
  String _selectedType = 'user_submission'; // Default type

  Future<void> _submitStory() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    final authorName = _authorNameController.text.trim();

    if (title.isEmpty || content.isEmpty || authorName.isEmpty) {
      context.showSnackbar(
          message: 'Please Fill in all fields.', backgroundColor: Colors.amber);
      return;
    }

    final user = Supabase.instance.client.auth.currentUser;
    final authorId = user?.id ?? '';

    // insertion data
    final newStory = EmpowermentStory(
      id: Uuid().v4(),
      title: title,
      content: content,
      authorId: authorId,
      authorName: authorName,
      type: _selectedType,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      await Supabase.instance.client
          .from('empowerment_stories')
          .insert(newStory.toJson());

      context.showSnackbar(
          message: 'Story Added Successfully!', backgroundColor: Colors.green);
      Navigator.pop(context);
    } catch (e) {
      print('Error adding Story: $e');
      context.showSnackbar(
          message: 'Error Adding Story', backgroundColor: Colors.amber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Empowerment Story')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            TextField(
              controller: _authorNameController,
              decoration: InputDecoration(labelText: 'Author Name'),
            ),
            DropdownButton<String>(
              value: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
              items: [
                DropdownMenuItem(
                    value: 'user_submission', child: Text('User Submission')),
                DropdownMenuItem(value: 'interview', child: Text('Interview')),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _submitStory,
              child: Text('Submit Story'),
            ),
          ],
        ),
      ),
    );
  }
}
