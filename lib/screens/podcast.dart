import 'package:flutter/material.dart';
import 'package:podcast/PodcastPage/body.dart';

class PodcastPage extends StatelessWidget {
  PodcastPage({
    Key? key,
    required this.podcast_name_doc,
    required this.podcast_author_doc,
  }) : super(key: key);

  final String podcast_name_doc;
  final String podcast_author_doc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Body(
          podcast_author_doc: podcast_author_doc,
          podcast_name_doc: podcast_name_doc,
        ),
      ),
    );
  }
}
