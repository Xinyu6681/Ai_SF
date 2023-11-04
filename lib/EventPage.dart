import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letslevelup/post.dart';
import 'package:letslevelup/postDetail.dart';

class offeringEventDetailPage extends StatefulWidget {
  final String eventName;

  offeringEventDetailPage({required this.eventName});

  @override
  _offeringEventDetailPage createState() => _offeringEventDetailPage();
}

class _offeringEventDetailPage extends State<offeringEventDetailPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  String address = '';
  String uploadedImage = '';
  int quantity = 0;
  String description = '';
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Widget _imagePreview() {
    if (_imageFile == null) {
      return Icon(Icons.image, size: 150, color: Colors.grey);
    } else {
      return Image.file(File(_imageFile!.path), width: 150, height: 150, fit: BoxFit.cover);
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (e) {
      print("Image pick error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventName = widget.eventName;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(eventName),
        elevation: 0,
      ),
      body: SingleChildScrollView( // To ensure the keyboard does not hide inputs
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilderTextField(
                name: 'address',
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                onChanged: (value) {
                  address = value ?? '';
                },
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  final Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high,
                  );
                  address = 'Lat: ${position.latitude}, Lon: ${position.longitude}';
                  setState(() {});
                },
                icon: Icon(Icons.gps_fixed),
                label: Text('Get Current Location'),
                style: ElevatedButton.styleFrom(
                  primary: theme.primaryColor,
                  onPrimary: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                name: 'Event Name',
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  address = value ?? '';
                },
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: _pickImage,
                child: _imagePreview(),
              ),
              SizedBox(height: 10),
              FormBuilderTextField(
                name: 'quantity',
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  quantity = int.tryParse(value ?? '0') ?? 0;
                },
              ),
              SizedBox(height: 10),
              FormBuilderTextField(
                name: 'description',
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  description = value ?? '';
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: applyForEvent,
                  style: ElevatedButton.styleFrom(
                    primary: theme.primaryColorDark,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text('Post'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void applyForEvent() {
    if (_formKey.currentState!.saveAndValidate()) {
      Post newPost = Post(
        title: widget.eventName,
        description: description,
        imageUrl: uploadedImage,
        dateTime: DateTime.now(),
        quantities: quantity,
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PostDetailPage(post: newPost),
        ),
      );
    }
  }
}
