import 'package:empower_women/backend/thread.dart';
import 'package:empower_women/pages/forum_page.dart';
import 'package:empower_women/utils/snackbar_ext.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateThreadForm extends StatefulWidget {
  const CreateThreadForm({super.key});

  @override
  State<CreateThreadForm> createState() => _CreateThreadFormState();
}

class _CreateThreadFormState extends State<CreateThreadForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;
  bool _isLoading = false;

  List<Category> _categories = [];
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _createThread() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final userResponse = await _supabase.auth.getUser();
        final user = userResponse.user;

        if (user != null) {
          final response = await _supabase.from('threads').insert([
            {
              'title': _titleController.text,
              'created_at': DateTime.now().toIso8601String(),
              'user_id': user.id,
              'category_id': _selectedCategory?.id,
            }
          ]).select();
          if (response.isNotEmpty) {
            final newThreadId = response[0]['id'];
            final threadTitle = response[0]['title'];

            _titleController.clear();
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => ForumPage(
                    threadId: newThreadId, threadTitle: threadTitle)));
            context.showSnackbar(
                message: 'Thread created successfully',
                backgroundColor: Colors.green);
          }
        } else {
          context.showSnackbar(
              message: 'Please log in to create a thread.',
              backgroundColor: Colors.amber);
        }
      } catch (e) {
        print('Error creating thread: $e');
        context.showSnackbar(
            message: 'Error creating thread', backgroundColor: Colors.amber);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadCategories() async {
    try {
      final response = await _supabase.from('categories').select('*');

      setState(() {
        _categories =
            (response as List).map((e) => Category.fromJson(e)).toList();
      });
    } catch (e) {
      print('Error loading categories: $e');
    }

    if (_categories.isEmpty) {
      await _createDefaultCategories();
      _loadCategories();
    }
  }

  Future<void> _createDefaultCategories() async {
    final categories = [
      {
        'name': 'General Discussion',
        'description': 'Discuss anything related to the forum'
      },
      {'name': 'Off-Topic', 'description': 'For off-topic discussions'},
      {
        'name': 'Lady-Advice',
        'description': 'Discuss anything related to ladies'
      },
    ];

    try {
      for (var category in categories) {
        await _supabase.from('categories').insert(category);
      }
      print('Default categories created successfully!');
    } catch (e) {
      print('Error creating categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: Text(
          'Create Thread',
          style: GoogleFonts.protestStrike(),
        ),
      ),
      backgroundColor: Colors.purple[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Category>(
                value: _selectedCategory,
                items: _categories.map((category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category
                        .name), // Assuming 'name' is a property of Category
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Select Category',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : ElevatedButton(
                      onPressed: _createThread,
                      child: Text(
                        'Create Thread',
                        style: GoogleFonts.oswald(fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
