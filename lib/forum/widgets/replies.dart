import 'package:flutter/material.dart';
import 'package:pbpbimbol/forum/models.dart';

import '../util.dart';

class Replies extends StatefulWidget {
  final int id;
  final String desc;
  final String user;
  final List<Reply> replies;

  const Replies(this.id, this.desc, this.user, this.replies, {Key? key})
      : super(key: key);

  @override
  _RepliesState createState() => _RepliesState();
}

class _RepliesState extends State<Replies> {
  @override
  Widget build(BuildContext context) {
    List<Widget> cildren = [
      Text(widget.desc, style: TextStyle(color: Colors.white70)),
      Text('by ${widget.user}',
          style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic)),
    ];
    cildren.addAll(List.generate(widget.replies.length, (index) {
      if (widget.replies[index].parent == widget.id) {
        return Replies(widget.replies[index].id, widget.replies[index].desc,
            widget.replies[index].user, widget.replies);
      }
      return const SizedBox.shrink();
    }));
    return Container(
      margin: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
      padding: const EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0.0),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(width: 3.5, color: Colors.blue.shade900))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cildren,
      ),
    );
  }
}
