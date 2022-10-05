import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podcast/PodcastPage/podcast_episode.dart';

import '../screens/author.dart';
import '../utils/colors.dart';
import '../widgets/back_arrow.dart';
import '../widgets/background.dart';
import '../widgets/bottom_bar.dart';

class Body extends StatefulWidget {
  const Body(
      {Key? key,
      required this.podcast_name_doc,
      required this.podcast_author_doc})
      : super(key: key);

  final String podcast_name_doc;
  final String podcast_author_doc;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isExpanded = true;
  bool isExpanded2 = true;
  late ScrollController _scrollController;
  late ScrollController _scrollControllers;

  bool _isScrolled = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollControllers = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    CollectionReference podcast =
        FirebaseFirestore.instance.collection('Popular Podcast');
    DocumentReference podcasts = FirebaseFirestore.instance
        .collection("Podcasts")
        .doc(widget.podcast_author_doc)
        .collection("podcast_name")
        .doc(widget.podcast_name_doc);

    return Background(
      child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollControllers,
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    FutureBuilder(
                      future: podcasts.get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;

                          return Column(
                            children: [
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: AnimatedContainer(
                                  margin: EdgeInsets.all(10),
                                  curve: Curves.easeOutCirc,
                                  duration: Duration(milliseconds: 700),
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.lightgrey
                                            .withOpacity(0.7),
                                        blurRadius: 10,
                                        offset: Offset(7, 7),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Stack(
                                          children: [
                                            ColorFiltered(
                                              colorFilter: ColorFilter.mode(
                                                  AppColors.backgroundColor,
                                                  BlendMode.color),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      "${data['image']}",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaY: 5, sigmaX: 5),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: AppColors.lightgrey
                                                          .withOpacity(0.70),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                BackArrow(),
                                                SizedBox(
                                                  width: size.width * 0.7,
                                                )
                                              ],
                                            ),
                                            Center(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .containerone,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                          "${data['image']}",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "${data['podcast_name']}",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return AuthorPage(
                                                              podcast_author:
                                                                  "${data['podcast_author']}",
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                              width: 2,
                                                              color: Colors
                                                                  .white54),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "${data['podcast_author']}",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white54,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width:
                                                            size.width * 0.48,
                                                        height:
                                                            size.width * 0.11,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              AppColors
                                                                  .containerone
                                                                  .withOpacity(
                                                                      0.80),
                                                              AppColors
                                                                  .containertwo,
                                                              AppColors
                                                                  .containerthree
                                                                  .withOpacity(
                                                                      0.90),
                                                            ],
                                                            stops: [
                                                              0.03,
                                                              0.4,
                                                              0.6,
                                                            ],
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                                size: 22,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                "Follow",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        width: size.width * 0.1,
                                                        height:
                                                            size.width * 0.11,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white54,
                                                              width: 1),
                                                        ),
                                                        child: Icon(
                                                          Icons.share_outlined,
                                                          color: Colors.white,
                                                          size: 22,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${data['description']}",
                                                    maxLines:
                                                        isExpanded ? 3 : 10,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      height: 2,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {},
                                child: AnimatedContainer(
                                  height: size.height * 0.45,
                                  curve: Curves.easeOutCirc,
                                  duration: Duration(milliseconds: 700),
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundColor,
                                  ),
                                  child: CustomScrollView(
                                    controller: _scrollController,
                                    physics: BouncingScrollPhysics(),
                                    slivers: [
                                      SliverList(
                                        delegate: SliverChildListDelegate(
                                          [
                                            Podcast_Episode(
                                              size: size,
                                              image: "${data['image']}",
                                              podcast_name_doc:
                                                  widget.podcast_name_doc,
                                              podcast_author_doc:
                                                  widget.podcast_author_doc,
                                            ),
                                            SizedBox(
                                              height: isExpanded ? 100 : 300,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );

                          /*Container(
                  child: Column(
                    children: [
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: AnimatedContainer(
                          margin: EdgeInsets.all(10),
                          curve: Curves.easeOutCirc,
                          duration: Duration(milliseconds: 700),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.lightgrey.withOpacity(0.7),
                                blurRadius: 10,
                                offset: Offset(7, 7),
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Stack(
                                  children: [
                                    ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          AppColors.backgroundColor,
                                          BlendMode.color),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              "${data['image']}",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaY: 5, sigmaX: 5),
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: AppColors.lightgrey
                                                  .withOpacity(0.70),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        BackArrow(),
                                        SizedBox(
                                          width: size.width * 0.7,
                                        )
                                      ],
                                    ),
                                    Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: AppColors.containerone,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  "${data['image']}",
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${data['podcast_name']}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return AuthorPage(
                                                      podcast_author:
                                                          "${data['podcast_author']}",
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 2,
                                                      color: Colors.white54),
                                                ),
                                              ),
                                              child: Text(
                                                "${data['podcast_author']}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white54,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: size.width * 0.48,
                                                height: size.width * 0.11,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      AppColors.containerone
                                                          .withOpacity(0.80),
                                                      AppColors.containertwo,
                                                      AppColors.containerthree
                                                          .withOpacity(0.90),
                                                    ],
                                                    stops: [
                                                      0.03,
                                                      0.4,
                                                      0.6,
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 22,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Follow",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: size.width * 0.1,
                                                height: size.width * 0.11,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.white54,
                                                      width: 1),
                                                ),
                                                child: Icon(
                                                  Icons.share_outlined,
                                                  color: Colors.white,
                                                  size: 22,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${data['description']}",
                                            maxLines: isExpanded ? 3 : 10,
                                            softWrap: true,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              height: 2,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {},
                        child: AnimatedContainer(
                          height: size.height * 0.45,
                          curve: Curves.easeOutCirc,
                          duration: Duration(milliseconds: 700),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                          ),
                          child: CustomScrollView(
                            controller: _scrollController,
                            physics: BouncingScrollPhysics(),
                            slivers: [
                              SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    Podcast_Episode(
                                      size: size,
                                      image: "${data['image']}",
                                      podcast_name_doc: widget.podcast_name_doc,
                                      podcast_author_doc:
                                          widget.podcast_author_doc,
                                    ),
                                    SizedBox(
                                      height: 100,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );*/
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
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

  /*void _handleFABPressed() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => Podcast_Popover(),
    );
  }*/
}
