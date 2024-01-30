import 'dart:io';

import 'package:favourite_place/widgets/input_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_places.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  void _savePlace() {
    final _enteredTitle = _titleController.text;
    if (_enteredTitle == null || _enteredTitle.isEmpty || _selectedImage==null) {
      showDialog(
        context: context,
        builder: (ctx) => Text('Title cannot be empty'),
      );
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(_enteredTitle,_selectedImage!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            SizedBox(
              height: 16,
            ),
            ImageInput(onSelectImage: (image){
              _selectedImage=image;
            }),
            SizedBox(
              height: 16,
            ),
            LocationInput(),
            SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed:_savePlace,
              label: Text('Add Place'),
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
