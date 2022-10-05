import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../AudioPage/body.dart';

class AudioPage extends StatefulWidget {
  const AudioPage(
      {Key? key,

      required this.id,
      required this.documentSnapshot,
      required this.asyncSnapshot,
      required this.streamLength})
      : super(key: key);

  final int id;
  final DocumentSnapshot documentSnapshot;
  final AsyncSnapshot asyncSnapshot;
  final int streamLength;

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Body(
          id: widget.id,
          documentSnapshot: widget.documentSnapshot,
          asyncSnapshot: widget.asyncSnapshot,
          streamLength: widget.streamLength,
        ),
      ),
    );
  }
}
