import 'package:flutter/material.dart';
import 'package:pbpbimbol/forum/util.dart';
import 'package:pbpbimbol/forum/models.dart';
import 'package:pbpbimbol/forum/widgets/replies.dart';

class Detail extends StatefulWidget {
  final int id;
  final String judul;
  final String desc;
  final String created;
  final String author;

  const Detail(this.id, this.judul, this.desc, this.created, this.author,
      {Key? key})
      : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Future<List<Reply>> futureReplies;

  @override
  void initState() {
    super.initState();
    futureReplies = _getReplies();
  }

  Future<List<Reply>> _getReplies() async {
    return await Util.forum(widget.id);
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
      body: Column(
        children: [
          // FittedBox(
          //   child: Padding(
          //     padding: const EdgeInsets.all(15),
          //     child: Column(
          //       children: [
          Text(
            widget.judul,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white70,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white70,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'created by ${widget.author} at ${widget.created.substring(0, 10)} ${widget.created.substring(11, 16)}',
            style: const TextStyle(
              fontSize: 13.0,
              fontFamily: 'DancingScript1',
              color: Colors.white70,
            ),
          ),

          Divider(
            color: Theme.of(context).secondaryHeaderColor,
            height: 25,
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: FutureBuilder<List<Reply>>(
              future: futureReplies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Reply> replies = snapshot.data!;
                  return ListView(
                    padding: const EdgeInsets.all(8),
                    children: List.generate(snapshot.data!.length, (index) {
                      if (snapshot.data![index].parent == 0) {
                        // return Text(snapshot.data![index].desc);
                        return Replies(
                            snapshot.data![index].id,
                            snapshot.data![index].desc,
                            snapshot.data![index].user,
                            replies);
                      }
                      return const SizedBox.shrink();
                    }),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const Text(
                  "Loading Replies...",
                  style: TextStyle(color: Colors.white70),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
