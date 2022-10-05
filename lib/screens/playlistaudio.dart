import 'package:flutter/material.dart';

import '../PlaylistAudioPage/body.dart';

class PlaylistAudioPage extends StatefulWidget {
  const PlaylistAudioPage({
    Key? key,
    required this.id,
    required this.asyncSnapshot,
    required this.streamLength,
  }) : super(key: key);

  final int id;
  final AsyncSnapshot asyncSnapshot;
  final int streamLength;

  @override
  State<PlaylistAudioPage> createState() => _PlaylistAudioPageState();
}

class _PlaylistAudioPageState extends State<PlaylistAudioPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Body(
          asyncSnapshot: widget.asyncSnapshot,
          streamLength: widget.streamLength,
          id: widget.id,
        ),
      ),
    );
  }
}
