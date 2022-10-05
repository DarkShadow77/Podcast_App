import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/audio.dart';
import '../utils/colors.dart';
import '../widgets/play_button.dart';
import '../widgets/podcast_popover.dart';

class Podcast_Episode extends StatelessWidget {
  const Podcast_Episode({
    Key? key,
    required this.size,
    required this.image,
    required this.podcast_name_doc,
    required this.podcast_author_doc,
  }) : super(key: key);

  final Size size;
  final String image;
  final String podcast_name_doc;
  final String podcast_author_doc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Podcasts')
          .doc(podcast_author_doc)
          .collection('podcast_name')
          .doc(podcast_name_doc)
          .collection('podcast_episode')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.data!.docs.length >= 1) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: streamSnapshot.data!.docs.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return OutlinedButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => Podcast_Popover(
                      documentSnapshot: documentSnapshot,
                    ),
                  );
                  print(index);
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          documentSnapshot['podcast_episode_name'],
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    documentSnapshot['description'],
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: AppColors.lightgrey,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
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
                                            Icons.timelapse,
                                            color: AppColors.lightgrey,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            documentSnapshot['timespan'],
                                            style: TextStyle(
                                              color: AppColors.lightgrey,
                                              fontSize: 14,
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
                                            Icons.date_range_rounded,
                                            color: AppColors.lightgrey,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            documentSnapshot['date'],
                                            style: TextStyle(
                                              color: AppColors.lightgrey,
                                              fontSize: 14,
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
                                      return AudioPage(
                                        id: index,
                                        documentSnapshot: documentSnapshot,
                                        asyncSnapshot: streamSnapshot,
                                        streamLength:
                                            streamSnapshot.data!.docs.length,
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  color: AppColors.lightgrey,
                ),
              );
            },
          );
        }
        return Column(
          children: [
            SizedBox(
              height: 50,
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
              "No Episode Added !",
              style: TextStyle(
                color: Colors.white60,
                fontSize: 25,
              ),
            ),
          ],
        );
      },
    );
  }
}
