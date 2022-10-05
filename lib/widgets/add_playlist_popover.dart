import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:podcast/utils/utils.dart';

import '../utils/colors.dart';
import 'create_playlist_popover.dart';

class AddPlaylistPopover extends StatefulWidget {
  const AddPlaylistPopover({
    Key? key,
    required this.documentSnapshot,
  }) : super(key: key);

  final DocumentSnapshot documentSnapshot;

  @override
  State<AddPlaylistPopover> createState() => _AddPlaylistPopoverState();
}

class _AddPlaylistPopoverState extends State<AddPlaylistPopover> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        builder: (_, controller) => Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.only(
                  right: 20.0, left: 20.0, top: 100.0, bottom: 20.0),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.darkgrey,
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pop();
                        _createPlaylistHandleFABPressed();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: AppColors.backgroundColor,
                                        shape: BoxShape.circle),
                                    padding: EdgeInsets.all(8),
                                    child: Center(
                                      child: Icon(
                                        Icons.playlist_add,
                                        color: Colors.white70,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Create New Playlist",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Divider(
                            height: 1,
                            thickness: 1.5,
                            color: AppColors.lightgrey.withOpacity(0.50),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('playlist')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ListView.builder(
                            itemCount: streamSnapshot.data!.docs.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              return OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();

                                  /*int podcast_size = FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection("playlist")
                                      .doc(documentSnapshot.toString())
                                      .collection("podcasts")
                                      .get()
                                      .then((value) =>
                                          {value.docs.length + 1}) as int;*/

                                  Map<String, dynamic> podcastData = {
                                    "podcast_author": widget
                                        .documentSnapshot['podcast_author'],
                                    "podcast_episode_name":
                                        widget.documentSnapshot[
                                            'podcast_episode_name'],
                                    "podcast_name":
                                        widget.documentSnapshot['podcast_name'],
                                  };

                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection("playlist")
                                      .doc(documentSnapshot["name"])
                                      .collection("podcasts")
                                      .doc(widget.documentSnapshot[
                                          'podcast_episode_name'])
                                      .set(podcastData);

                                  Utils.showSnackBar("Added to Playlist");
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.containerone,
                                                    shape: BoxShape.circle),
                                                padding: EdgeInsets.all(8),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                documentSnapshot['name'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 30.0),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1.5,
                                        color: AppColors.lightgrey
                                            .withOpacity(0.50),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return const Center();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildHandle(context),
                    Text(
                      "Add to Playlist",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        "Choose your preferred playlist to add your podcast",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff545568),
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.20,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 15.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: Color(0xff1f212e),
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }

  WillPopScope openDialog() => WillPopScope(
        child: Dialog(
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          backgroundColor: AppColors.darkgrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: CreatePlaylistPopover(),
        ),
        onWillPop: () => Future.value(false),
      );

  void _createPlaylistHandleFABPressed() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            backgroundColor: AppColors.darkgrey,
            content: CreatePlaylistPopover());
      },
    );
  }
}
