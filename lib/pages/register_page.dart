import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasklie_new/main.dart';
import 'package:tasklie_new/models/user_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _passwordAgainController = TextEditingController();
File? _imageFile;
ImagePicker _picker = ImagePicker();
XFile? _pickedFile;
bool _isLoading = false;

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Kayıt Ol"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                _imageFile == null ? const Text('Resim seçilmedi.') : SizedBox(height: 200, child: Image.file(_imageFile!)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Ad Soyad',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Şifre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _passwordAgainController,
                    decoration: const InputDecoration(
                      hintText: 'Şifre Tekrar',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                _isLoading
                    ? const SizedBox(
                        width: 100,
                        height: 42,
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          await createAccountWithEmail(_emailController.text, _passwordController.text, context);
                        },
                        child: Container(
                          width: 100,
                          height: 42,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              "Kayıt Ol",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: getImage,
          tooltip: 'Pick Image',
          label: Text(_imageFile == null ? 'Fotoğraf Yükle' : 'Fotoğrafı Değiştir'),
          icon: const Icon(Icons.add_a_photo),
        ),
      ),
    );
  }

  Future getImage() async {
    _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (_pickedFile != null) {
        _imageFile = File(_pickedFile!.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future<void> createAccountWithEmail(String email, String password, BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen bir fotoğraf seçin.')));
      return;
    }
    try {
      String downloadUrl = "*";
      if (_imageFile != null) {
        TaskSnapshot taskSnapshot = await storageRef.child('profileImages/${_emailController.text}').putFile(File(_imageFile!.path));
        downloadUrl = await taskSnapshot.ref.getDownloadURL();
      }
      await usersRef.doc(_emailController.text).set({
        'email': _emailController.text,
        'name': _nameController.text,
        'photoUrl': downloadUrl,
        'createdAt': DateTime.now(),
        'lastSeen': DateTime.now(),
      }).catchError((error) => debugPrint('Firebase Error: $error'));
      currentUser = UserModel(
        name: _nameController.text,
        email: _emailController.text,
        photoUrl: downloadUrl,
        lastSeen: DateTime.now().toString(),
        createdAt: DateTime.now().toString(),
      );
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Root()), (route) => false);
      _isLoading = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Şifre çok zayıf.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bu email adresi zaten kullanılıyor.')));
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Geçersiz email adresi.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bilinmeyen bir hata oluştu.')));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
