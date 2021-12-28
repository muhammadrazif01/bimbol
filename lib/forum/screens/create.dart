import 'package:flutter/material.dart';
import 'package:pbpbimbol/forum/models.dart';

import '../util.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController judulController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buat Forum"),
      ),
      body: Column(
        children: [
          Text("Judul"),
          TextField(
            controller: judulController,
          ),
          Text("description"),
          TextField(
            controller: descController,
            maxLines: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  final status = await Util.postForum(
                      judulController.text, descController.text);
                  if (status == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Curhat baru berhasil disimpan!"),
                    ));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("An error occured, please try again."),
                    ));
                  }
                } catch (err) {
                  print("ada error");
                }
              },
              child: Text("Buat Forum"))
        ],
      ),
    );
  }
}
