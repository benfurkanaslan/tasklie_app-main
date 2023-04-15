import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasklie_new/main.dart';
import 'package:tasklie_new/models/user_model.dart';
import 'package:tasklie_new/pages/add_team_members.dart';

TextEditingController _createTeamNameController = TextEditingController();
TextEditingController _taskDescriptionController = TextEditingController();
List<UserModel> _teamMembers = [];
File? _imageFile;
ImagePicker _picker = ImagePicker();
XFile? _pickedFile;

class CreateTeams extends StatefulWidget {
  final String projectID, projectName, projectDiscription, projectDocName;
  final int categoryIndex;
  final DateTime startDate, endDate;
  const CreateTeams({
    super.key,
    required this.projectID,
    required this.projectName,
    required this.projectDiscription,
    required this.categoryIndex,
    required this.startDate,
    required this.endDate,
    required this.projectDocName,
  });

  @override
  State<CreateTeams> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CreateTeams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Takım Oluştur', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _imageFile == null
                  ? const Center(
                      child: Text('Resim seçilmedi.'),
                    )
                  : Center(
                      child: SizedBox(
                        height: 200,
                        child: Image.file(
                          _imageFile!,
                          errorBuilder: (context, error, stackTrace) => const Center(
                            child: Text('Resim yüklenemedi.'),
                          ),
                        ),
                      ),
                    ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Text('Takım Adı'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _createTeamNameController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(RegExp(r'[-]')),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('Yapılacak işi Açıklayın'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _taskDescriptionController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('Takım Üyeleri'),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _teamMembers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: (() {
                      if (_teamMembers[index].photoUrl == '*') {
                        return const CircleAvatar(
                          child: Icon(CupertinoIcons.person),
                        );
                      } else {
                        return CircleAvatar(
                          backgroundImage: NetworkImage(_teamMembers[index].photoUrl),
                        );
                      }
                    }()),
                    title: Text(_teamMembers[index].name),
                    subtitle: Text(_teamMembers[index].email),
                  );
                },
              ),
              Center(
                child: OutlinedButton(
                  onPressed: () async {
                    UserModel newUser = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTeamMembers()));
                    if (newUser.email.isNotEmpty) {
                      setState(() {
                        _teamMembers.add(newUser);
                      });
                    }
                  },
                  child: const Text('Takım Üyelerini Ekle'),
                ),
              ),
              Center(
                child: OutlinedButton(
                  onPressed: () async {
                    if (_createTeamNameController.text.isNotEmpty) {
                      await _createTeam();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen Tüm Alanları Doldurunuz.')));
                    }
                  },
                  child: const Text('Projeyi Oluştur'),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _getImage,
        tooltip: 'Pick Image',
        label: Text(_imageFile == null ? 'Fotoğraf Yükle' : 'Fotoğrafı Değiştir'),
        icon: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Future _getImage() async {
    _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (_pickedFile != null) {
        _imageFile = File(_pickedFile!.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future _createTeam() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen bir fotoğraf seçin.')));
      return;
    }
    String downloadUrl = "";
    if (_imageFile != null) {
      TaskSnapshot taskSnapshot = await storageRef.child('groupImages/${widget.projectDocName}').putFile(File(_imageFile!.path));
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
    }
    String result = '';
    Random random = Random();
    for (int i = 0; i < 20; i++) {
      result += random.nextInt(10).toString();
    }
    await projectsRef.doc(widget.projectDocName).set({
      'photoUrl': downloadUrl,
      'category': widget.categoryIndex,
      'projectName': widget.projectName,
      'projectDocName': widget.projectDocName,
      'creator': currentUser!.email,
      'creatorName': currentUser!.name,
      'creatorPhotoUrl': currentUser!.photoUrl,
      'currentAdmin': currentUser!.email,
      'currentAdminName': currentUser!.name,
      'currentAdminPhotoUrl': currentUser!.photoUrl,
      'teams': {
        _createTeamNameController.text: {
          'projectDocName': widget.projectDocName,
          'teamName': _createTeamNameController.text,
          'teamMembers': _teamMembers.map((e) => e.email).toList(),
          'teamMembersName': _teamMembers.map((e) => e.name).toList(),
          'teamMembersPhotoUrl': _teamMembers.map((e) => e.photoUrl).toList(),
          'tasksMembersCount': _teamMembers.length,
          'taskDescription': _taskDescriptionController.text,
          'taskStatus': '1-Running',
          'taskStartDate': widget.startDate,
          'taskEndDate': widget.endDate,
          'teamId': result,
        },
      },
    });
    _createTeamNameController.clear();
    _taskDescriptionController.clear();
    _teamMembers.clear();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Root()), (route) => false);
  }
}
