import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sdla/components/appbar_button.dart';
import 'package:sdla/components/button.dart';
import 'package:sdla/constants/constant.dart';
import 'package:sdla/services/http_service.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String nama = "loading...";
  String image = "null";

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  final String name = 'daffa12';
  final String email = 'daffa12@gmail.com';

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_imageFile != null) {
      await updateDataUser(name, email, imageFile: _imageFile);
    } else {
      await updateDataUser(name, email);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      var response = await getUserDetails();
      nama = response['name'];
      image = response['image'];
      nameController = TextEditingController(text: response['name']);
      emailController = TextEditingController(text: response['email']);
      setState(() {});
    } catch (e) {
      nama = "Fetch data error";
      print('Fetch data error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 242,
            decoration: const BoxDecoration(gradient: kGradientBlue),
            child: SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: (image == "null")
                                    ? const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: CircularProgressIndicator(
                                            color: kWhite,
                                          ),
                                        ),
                                      )
                                    : MyNetworkImage(
                                        imageURL: image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: _pickImage,
                                  child: const AppBarButton(
                                    width: 35,
                                    height: 35,
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          nama,
                          style: kSemiBoldTextStyle.copyWith(
                              fontSize: 20, color: kWhite),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            color: kWhite,
            padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: nameController,
                  decoration:
                      kTextFieldInputDecoration.copyWith(hintText: 'Username'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: emailController,
                  decoration:
                      kTextFieldInputDecoration.copyWith(hintText: 'Email'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 45,
                ),
                MainButton(
                  title: 'Save',
                  onTap: _uploadImage,
                  gradient: kGradientBlue,
                ),
                const SizedBox(
                  height: 20,
                ),
                SecondaryButton(
                  title: 'Batal',
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
