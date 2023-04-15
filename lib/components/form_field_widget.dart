import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  final String label;
  // final Function onChanged;
  final List<String> items;

  const FormFieldWidget(
      {super.key,
      required this.label,
      // required this.onChanged,
      required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          ProjectForm(),
        ],
      ),
    );
  }
}

class ProjectForm extends StatelessWidget {
  const ProjectForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: "Proje Adı"),
            validator: (value) {
              // if (value.isEmpty) {
              //   return 'Lütfen proje adı girin';
              // }
              return null;
            },
            onSaved: (newValue) {},
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Tarih",
            ),
            validator: (value) {
              // if (value.isEmpty) {
              //   return 'Lütfen tarih girin';
              // }
              return null;
            },
            onSaved: (newValue) {},
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(labelText: "Başlangıç Tarihi"),
            validator: (value) {
              // if (value.isEmpty) {
              //   return 'Lütfen başlangıç tarihini girin';
              // }
              return null;
            },
            onSaved: (newValue) {},
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(labelText: "Bitiş Tarihi"),
            validator: (value) {
              // if (value.isEmpty) {
              //   return 'Lütfen bitiş tarihini girin';
              // }
              return null;
            },
            onSaved: (newValue) {},
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(labelText: "Açıklama"),
            validator: (value) {
              // if (value.isEmpty) {
              //   return 'Lütfen açıklama girin';
              // }
              return null;
            },
            onSaved: (newValue) {},
            maxLines: 3,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
