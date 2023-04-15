import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasklie_new/main.dart';
import 'package:tasklie_new/models/user_model.dart';

class AddTeamMembers extends StatefulWidget {
  const AddTeamMembers({super.key});

  @override
  State<AddTeamMembers> createState() => _AddTeamMembersState();
}

class _AddTeamMembersState extends State<AddTeamMembers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Takım Üyeleri Ekle', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: _getDatas(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data.docs[index].data()['name']),
                  subtitle: Text(snapshot.data.docs[index].data()['email']),
                  leading: (() {
                    if (snapshot.data.docs[index].data()['photoUrl'] == '*') {
                      return const CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      );
                    } else {
                      return CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data.docs[index].data()['photoUrl']),
                      );
                    }
                  }()),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      UserModel newUser = UserModel(
                        name: snapshot.data.docs[index].data()['name'],
                        email: snapshot.data.docs[index].data()['email'],
                        photoUrl: snapshot.data.docs[index].data()['photoUrl'],
                        lastSeen: snapshot.data.docs[index].data()['lastSeen'].toDate().toString(),
                        createdAt: snapshot.data.docs[index].data()['createdAt'].toDate().toString(),
                      );
                      Navigator.pop(context, newUser);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getDatas() async {
    QuerySnapshot<Map<String, dynamic>> users = await usersRef.get();
    return users;
  }
}
