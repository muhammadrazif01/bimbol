import 'package:flutter/material.dart';

import '../util.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController judulController = TextEditingController();
  TextEditingController descController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Forum"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(45.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Judul"),
                controller: judulController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Description"),
                controller: descController,
                maxLines: 8,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'tidak boleh kosong';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    try {
                      final status = await Util.postForum(
                          judulController.text, descController.text);
                      if (status == 200) {
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("An error occured, please try again."),
                        ));
                      }
                    } catch (err) {
                      // print("ada error");
                    }
                  },
                  child: const Text("Buat Forum"))
            ],
          ),
        ),
      ),
    );
  }
}
