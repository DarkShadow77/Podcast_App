import 'package:flutter/material.dart';

import '../AuthorPage/body.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({
    Key? key,
    required this.podcast_author,
  }) : super(key: key);

  final String podcast_author;
  @override
  State<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Body(
          podcast_author: widget.podcast_author,
        ),
      ),
    );
  }
}
