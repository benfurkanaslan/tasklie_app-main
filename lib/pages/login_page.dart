import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasklie_new/components/rounded_text_field.dart';
import 'package:tasklie_new/components/extension.dart';
import 'package:tasklie_new/main.dart';
import 'package:tasklie_new/models/user_model.dart';
import 'package:tasklie_new/pages/signmainpage.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/login.png',
                fit: BoxFit.cover,
                height: context.dynamicHeight(370),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Giriş Yap",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: Colors.black,
                      )),
                ),
              ),
              // SizedBox(height: 15.0),
              RoundedTextField(
                controller: emailController,
                obscureText: false,
                labelText: "Email",
                hintText: "Email giriniz",
              ),
              RoundedTextField(
                controller: passwordController,
                obscureText: true,
                labelText: "Şifre",
                hintText: "Şifre giriniz",
              ),
              const SizedBox(height: 20.0),
              InkWell(
                child: Container(
                  width: context.dynamicWidth(300),
                  height: context.dynamicHeight(50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [Color.fromARGB(255, 84, 119, 248), Color.fromARGB(255, 87, 171, 249)],
                      )),
                  child: const Center(
                    child: Text(
                      'Giriş Yap',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: () async {
                  await loginWithEmail(emailController.text, passwordController.text, context);
                },
              ),
              const SizedBox(height: 5.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignPage()));
                },
                child: const Text('Hesap oluştur'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginWithEmail(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      debugPrint('Signed in as ${userCredential.user!.email}!');
      await usersRef.doc(userCredential.user!.email).get().then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.exists) {
          debugPrint('Document data: ${documentSnapshot.data()}');
          currentUser = UserModel(
            name: documentSnapshot.data()!['name'],
            email: documentSnapshot.data()!['email'],
            photoUrl: documentSnapshot.data()!['photoUrl'],
            lastSeen: documentSnapshot.data()!['lastSeen'].toDate().toString(),
            createdAt: documentSnapshot.data()!['createdAt'].toDate().toString(),
          );
        } else {
          debugPrint('Document does not exist on the database');
        }
      });
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Root()), (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bu email adresi ile kayıtlı hesap bulunamadı.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Şifre yanlış.')));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
