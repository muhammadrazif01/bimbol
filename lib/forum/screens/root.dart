import 'package:flutter/material.dart';
import 'package:pbpbimbol/forum/widgets/kartu.dart';
import 'package:pbpbimbol/forum/util.dart';
import 'package:pbpbimbol/forum/models.dart';
import 'package:pbpbimbol/forum/screens/create.dart';

class ForumRoot extends StatefulWidget {
  const ForumRoot({Key? key}) : super(key: key);

  @override
  _ForumRootState createState() => _ForumRootState();
}

class _ForumRootState extends State<ForumRoot> {
  late Future<List<Forum>> futureForum;

  @override
  void initState() {
    super.initState();
    futureForum = Util.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          'Forum Diskusi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            fontFamily: 'DancingScript1',
            color: Colors.white70,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: FutureBuilder<List<Forum>>(
          future: futureForum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.all(8),
                children: List.generate(
                    snapshot.data!.length,
                    (index) => Kartu(
                        snapshot.data![index].id, //gatau
                        snapshot.data![index].title,
                        snapshot.data![index].desc,
                        snapshot.data![index].created,
                        snapshot.data![index].author)),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePage()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
    );
  }
}
