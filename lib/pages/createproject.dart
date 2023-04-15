import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasklie_new/main.dart';
import 'package:tasklie_new/pages/create_team.dart';
import 'package:tasklie_new/project_details/extension.dart';

class CreateProjectPage extends StatefulWidget {
  final String title = "Proje Oluştur";
  const CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

DateTime _selectedStartDate = DateTime.now();
DateTime _selectedFinishDate = DateTime.now().add(const Duration(days: 1));
TextEditingController _nameController = TextEditingController();
TextEditingController _projectDescriptionController = TextEditingController();
int _categoryIndex = 0;
String _projectDocName = '';

class _CreateProjectPageState extends State<CreateProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Proje Adı",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Proje adı boş bırakılamaz";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // hintText: "Proje Adı",
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          _selectStartDate(context);
                        },
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(const BorderSide(color: Colors.grey, width: 2)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                        child: Text(
                          "Başlangıç Tarihi",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("${_selectedStartDate.day.toString().padLeft(2, '0')}/${_selectedStartDate.month.toString().padLeft(2, '0')}/${_selectedStartDate.year}"),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          _selectFinishDate(context);
                        },
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(const BorderSide(color: Colors.grey, width: 2)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                        child: Text(
                          "Bitiş Tarihi",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("${_selectedFinishDate.day.toString().padLeft(2, '0')}/${_selectedFinishDate.month.toString().padLeft(2, '0')}/${_selectedFinishDate.year}"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Açıklama",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: TextFormField(
                controller: _projectDescriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Proje açıklaması boş bırakılamaz";
                  }
                  return null;
                },
                minLines: 3,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Kategori",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const _SelectableButtons(),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {
                String result = '';
                Random random = Random();
                for (int i = 0; i < 20; i++) {
                  result += random.nextInt(10).toString();
                }
                if (_categoryIndex == 0) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lütfen bir kategori seçiniz")));
                  return;
                }
                if (_nameController.text.isNotEmpty && _projectDescriptionController.text.isNotEmpty) {
                  _projectDocName = '$_categoryIndex-${_nameController.text}-${currentUser!.email}-$result';
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateTeams(
                        projectID: result,
                        projectName: _nameController.text,
                        projectDiscription: _projectDescriptionController.text,
                        categoryIndex: _categoryIndex,
                        startDate: _selectedStartDate,
                        endDate: _selectedFinishDate,
                        projectDocName: _projectDocName,
                      ),
                    ),
                  );
                } else {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lütfen tüm alanları doldurunuz")));
                  return;
                }
                _projectDocName = '$_categoryIndex-${_nameController.text}-${currentUser!.email}-$result';
              },
              child: Container(
                width: context.dynamicWidth(300),
                height: context.dynamicHeight(50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color.fromARGB(255, 84, 119, 248), Color.fromARGB(255, 87, 171, 249)],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Takım Oluşturmaya Geç',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedStartDate) {
      if (picked.isAfter(_selectedFinishDate)) {
        _selectedFinishDate = picked.add(const Duration(days: 1));
      }
      setState(() {
        _selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectFinishDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedFinishDate,
      firstDate: _selectedStartDate.add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedFinishDate) {
      setState(() {
        _selectedFinishDate = picked;
      });
    }
  }
}

class _SelectableButtons extends StatefulWidget {
  const _SelectableButtons();

  @override
  _SelectableButtonsState createState() => _SelectableButtonsState();
}

class _SelectableButtonsState extends State<_SelectableButtons> {
  List<bool> _selected = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton(0),
            _buildButton(1),
            _buildButton(2),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton(3),
            _buildButton(4),
            _buildButton(5),
          ],
        ),
      ],
    );
  }

  Container _buildButton(int index) {
    return Container(
      width: 100,
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(
          color: _selected[index] ? Colors.blue : Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _categoryIndex = index;
              _selected = [false, false, false, false, false, false];
              _selected[index] = true;
            });
          },
          child: Center(
            child: Text(
              'Button $index',
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w300,
                color: _selected[index] ? const Color.fromARGB(255, 87, 123, 255) : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
