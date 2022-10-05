import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../SelectedPlaylistPage/body.dart';

class SelectedPlaylistPage extends StatefulWidget {
  const SelectedPlaylistPage({
    Key? key,
    required this.documentSnapshot,
  }) : super(key: key);

  final DocumentSnapshot documentSnapshot;
  @override
  State<SelectedPlaylistPage> createState() => _SelectedPlaylistPageState();
}

class _SelectedPlaylistPageState extends State<SelectedPlaylistPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Body(
          documentSnapshot: widget.documentSnapshot,
        ),
      ),
    );
  }
}
