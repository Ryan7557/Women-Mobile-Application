import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateCategoryForm extends StatefulWidget {
  const CreateCategoryForm({super.key});

  @override
  State<CreateCategoryForm> createState() => _CreateCategoryFormState();
}

class _CreateCategoryFormState extends State<CreateCategoryForm> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _createCategory() async {
    try {
      await Supabase.instance.client.from('categories').insert([
        {
          'name': _nameController.text,
          'description': _descriptionController.text,
        }
      ]);
      Navigator.pop(context);
    } catch (e) {
      print('Error creating category');
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Category')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Category Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: _createCategory,
              child: Text('Create Category'),
            ),
          ],
        ),
      ),
    );
  }
}