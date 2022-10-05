import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/podcast.dart';

class PodcastItems extends StatefulWidget {
  const PodcastItems({Key? key}) : super(key: key);

  @override
  State<PodcastItems> createState() => _PodcastItemsState();
}

class _PodcastItemsState extends State<PodcastItems> {
  PageController pageController = PageController(viewportFraction: 0.3);

  final CollectionReference _popularpodcasts =
      FirebaseFirestore.instance.collection('popular');

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: StreamBuilder(
        stream: _popularpodcasts.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return PageView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              padEnds: false,
              physics: BouncingScrollPhysics(),
              controller: pageController,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                final podcast_name_doc = documentSnapshot['podcast_name'];
                final podcast_author_doc = documentSnapshot['podcast_author'];

                DocumentReference podcasts = FirebaseFirestore.instance
                    .collection("Podcasts")
                    .doc(podcast_author_doc)
                    .collection("podcast_name")
                    .doc(podcast_name_doc);

                return FutureBuilder(
                    future: podcasts.get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return PodcastPage(
                                    podcast_name_doc: podcast_name_doc,
                                    podcast_author_doc: podcast_author_doc,
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    color: Colors.grey,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        data['image'],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data['podcast_name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  data['podcast_author'],
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 10,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
