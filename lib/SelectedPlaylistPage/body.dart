import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podcast/utils/colors.dart';
import 'package:podcast/widgets/background.dart';

import '../screens/playlistaudio.dart';
import '../utils/databasemethods.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/create_playlist_popover.dart';
import '../widgets/play_button.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.documentSnapshot,
  }) : super(key: key);

  final DocumentSnapshot documentSnapshot;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late ScrollController _scrollController;

  bool _isScrolled = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);

    super.initState();
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 50.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  int podcastNumber = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                centerTitle: true,
                expandedHeight: 70.0,
                elevation: 0,
                pinned: true,
                automaticallyImplyLeading: false,
                floating: true,
                stretch: true,
                backgroundColor: AppColors.backgroundColor,
                bottom: AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 70,
                  backgroundColor: Colors.transparent,
                  titleSpacing: 0,
                  elevation: 0,
                  title: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        BackButton(),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          widget.documentSnapshot['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('playlist')
                          .doc(widget.documentSnapshot['name'])
                          .collection('podcasts')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.data!.docs.length >= 1) {
                          podcastNumber = streamSnapshot.data!.docs.length;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white24,
                                      ),
                                      child: Icon(
                                        Icons.queue_music_rounded,
                                        size: 30,
                                        color: Colors.white38,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.documentSnapshot['name'],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w900,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          FutureBuilder(
                                            future: DatabaseMethods()
                                                .getUserFromDB(FirebaseAuth
                                                    .instance.currentUser!.uid),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<dynamic>
                                                    snapshot) {
                                              Map<String, dynamic> data =
                                                  snapshot.data!.data()
                                                      as Map<String, dynamic>;

                                              return Row(
                                                children: [
                                                  Text(
                                                    "Created by: ",
                                                    style: TextStyle(
                                                      color: Colors.white60,
                                                      fontSize: 15,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    data['username'],
                                                    style: TextStyle(
                                                      color: Colors.white60,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Number of podcasts: ${streamSnapshot.data!.docs.length}",
                                            style: TextStyle(
                                              color: Colors.white60,
                                              fontSize: 15,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: OutlinedButton.icon(
                                  label: Text("Play"),
                                  icon: ShaderMask(
                                    blendMode: BlendMode.srcATop,
                                    shaderCallback: (bounds) => LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Color(0xff30304B).withOpacity(0.5),
                                        Color(0xff30304B),
                                      ],
                                      stops: [0.5, 0.6, 0.7],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ).createShader(bounds),
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    primary: Colors.white,
                                    backgroundColor: Color(0xff30304B),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: podcastNumber,
                                itemBuilder: (context, index) {
                                  final DocumentSnapshot documentSnapshot =
                                      streamSnapshot.data!.docs[index];

                                  DocumentReference podcasts = FirebaseFirestore
                                      .instance
                                      .collection("Podcasts")
                                      .doc(documentSnapshot['podcast_author'])
                                      .collection("podcast_name")
                                      .doc(documentSnapshot['podcast_name'])
                                      .collection('podcast_episode')
                                      .doc(documentSnapshot[
                                          'podcast_episode_name']);

                                  return FutureBuilder(
                                    future: podcasts.get(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.hasData) {
                                        Map<String, dynamic> data =
                                            snapshot.data!.data()
                                                as Map<String, dynamic>;

                                        return GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 35,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                            data['image'],
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      data['podcast_name'],
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  data['podcast_episode_name'],
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 12,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: size.width * 0.70,
                                                      child: Column(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              data[
                                                                  'description'],
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white38,
                                                                fontSize: 11,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .timelapse,
                                                                    color: AppColors
                                                                        .lightgrey,
                                                                    size: 14,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    data[
                                                                        'timespan'],
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColors
                                                                          .lightgrey,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 40,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .date_range_rounded,
                                                                    color: AppColors
                                                                        .lightgrey,
                                                                    size: 14,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    data[
                                                                        'date'],
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColors
                                                                          .lightgrey,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return PlaylistAudioPage(
                                                                asyncSnapshot:
                                                                    streamSnapshot,
                                                                streamLength:
                                                                    podcastNumber,
                                                                id: index,
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      child: PlayButton(
                                                        diameter: 40,
                                                        iconsize: 25,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Padding(
                                  padding: const EdgeInsets.only(
                                    left: 30.0,
                                  ),
                                  child: Divider(
                                    height: 1,
                                    thickness: 1.5,
                                    color:
                                        AppColors.lightgrey.withOpacity(0.50),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white24,
                                        ),
                                        child: Icon(
                                          Icons.queue_music_rounded,
                                          size: 30,
                                          color: Colors.white38,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.documentSnapshot['name'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w900,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            FutureBuilder(
                                              future: DatabaseMethods()
                                                  .getUserFromDB(FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<dynamic>
                                                      snapshot) {
                                                Map<String, dynamic> data =
                                                    snapshot.data!.data()
                                                        as Map<String, dynamic>;

                                                return Row(
                                                  children: [
                                                    Text(
                                                      "Created by: ",
                                                      style: TextStyle(
                                                        color: Colors.white60,
                                                        fontSize: 15,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      data['username'],
                                                      style: TextStyle(
                                                        color: Colors.white60,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Number of podcasts: ${podcastNumber}",
                                              style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 15,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                Container(
                                  height: size.width * 0.25,
                                  width: size.width * 0.25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff262837),
                                  ),
                                  child: Icon(
                                    Icons.music_off_rounded,
                                    size: 50,
                                    color: Colors.white54,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "No Podcast Added !",
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    /*Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Your Playlists",
                              style: TextStyle(
                                  color: AppColors.subTitle,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              _createPlaylistHandleFABPressed();
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              side: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(right: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: size.width * 0.08,
                                        width: size.width * 0.08,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff262837),
                                        ),
                                        child: Icon(
                                          Icons.playlist_add,
                                          size: 20,
                                          color: Colors.white54,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        "Create a new Playlist",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white70,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Divider(
                              height: 1,
                              thickness: 1.5,
                              color: AppColors.lightgrey.withOpacity(0.50),
                            ),
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('playlist')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (streamSnapshot.hasData) {
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: streamSnapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                        streamSnapshot.data!.docs[index];

                                    return Column(
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20),
                                            side: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                right: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: size.width * 0.08,
                                                      width: size.width * 0.08,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Color(0xff262837),
                                                      ),
                                                      child: Icon(
                                                        Icons
                                                            .queue_music_rounded,
                                                        size: 20,
                                                        color: Colors.white54,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 25,
                                                    ),
                                                    Text(
                                                      documentSnapshot['name'],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons.more_vert_rounded,
                                                  color: Colors.white70,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Divider(
                                      height: 1,
                                      thickness: 1.5,
                                      color:
                                          AppColors.lightgrey.withOpacity(0.50),
                                    ),
                                  ),
                                );
                              }
                              return Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                    ),
                                    Container(
                                      height: size.width * 0.25,
                                      width: size.width * 0.25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff262837),
                                      ),
                                      child: Icon(
                                        Icons.playlist_add,
                                        size: 50,
                                        color: Colors.white54,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "No Playlist!!",
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Create a new Playlist",
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),*/
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ],
          ),
          BottomBar(),
        ],
      ),
    );
  }

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
