import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasklie_new/firebase_options.dart';
import 'package:tasklie_new/models/task_model.dart';
import 'package:tasklie_new/models/user_model.dart';
import 'package:tasklie_new/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tasklie_new/pages/task_home_screen.dart';

CollectionReference<Map<String, dynamic>> usersRef = FirebaseFirestore.instance.collection('users');
CollectionReference<Map<String, dynamic>> projectsRef = FirebaseFirestore.instance.collection('projects');
CollectionReference<Map<String, dynamic>> messagesRef = FirebaseFirestore.instance.collection('messages');
FirebaseAuth auth = FirebaseAuth.instance;
Reference storageRef = FirebaseStorage.instance.ref();
bool? signed;
UserModel? currentUser;
List<TaskModel> currentTasks = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Root());
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        debugPrint("User is currently signed out!");
        setState(() {
          signed = false;
        });
      } else {
        debugPrint("User is signed in!");
        await usersRef.doc(user.email).get().then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) async {
          currentUser = UserModel(
            name: documentSnapshot.data()!['name'],
            email: documentSnapshot.data()!['email'],
            photoUrl: documentSnapshot.data()!['photoUrl'],
            lastSeen: documentSnapshot.data()!['lastSeen'].toDate().toString(),
            createdAt: documentSnapshot.data()!['createdAt'].toDate().toString(),
          );
          List<TaskModel> userTasks = [];
          QuerySnapshot<Map<String, dynamic>> projects = await projectsRef.get();
          for (int i = 0; i < projects.docs.length; i++) {
            if ((projects.docs[i].data()['teams'] as Map).isNotEmpty) {
              for (String key in (projects.docs[i].data()['teams'] as Map).keys) {
                if ((projects.docs[i].data()['teams'][key]['teamMembers'] as List<dynamic>).contains(currentUser!.email)) {
                  userTasks.add(
                    TaskModel(
                      teamName: projects.docs[i].data()['teams'][key]['teamName'],
                      taskDescription: projects.docs[i].data()['teams'][key]['taskDescription'],
                      taskStartDate: projects.docs[i].data()['teams'][key]['taskStartDate'],
                      taskEndDate: projects.docs[i].data()['teams'][key]['taskEndDate'],
                      projectDocName: projects.docs[i].data()['teams'][key]['projectDocName'],
                      teamId: projects.docs[i].data()['teams'][key]['teamId'],
                      taskStatus: projects.docs[i].data()['teams'][key]['taskStatus'],
                      taskMembers: projects.docs[i].data()['teams'][key]['teamMembers'] as List<dynamic>,
                      taskMembersName: projects.docs[i].data()['teams'][key]['teamMembersName'] as List<dynamic>,
                      taskMembersPhotoUrl: projects.docs[i].data()['teams'][key]['teamMembersPhotoUrl'] as List<dynamic>,
                      taskMembersCount: projects.docs[i].data()['teams'][key]['taskMembersCount'] as int,
                    ),
                  );
                }
              }
            }
          }
          currentTasks = userTasks;
        });
        setState(() {
          signed = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (() {
        switch (signed) {
          case true:
            return const HomePage();
          case false:
            return const LoginPage();
          default:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
              ),
            );
        }
      }()),
    );
  }
}
