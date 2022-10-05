import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PodcastItem extends StatefulWidget {
  const PodcastItem({Key? key}) : super(key: key);

  @override
  State<PodcastItem> createState() => _PodcastItemState();
}

class _PodcastItemState extends State<PodcastItem> {
  PageController pageController = PageController(viewportFraction: 0.3);

  final CollectionReference _popularpodcasts =
      FirebaseFirestore.instance.collection('Popular Podcast');

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
                return GestureDetector(
                  onTap: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PodcastPage(
                            userId: documentSnapshot['userId'].toString(),
                          );
                        },
                      ),
                    );*/
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
                                documentSnapshot['image'],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          documentSnapshot['podcast_name'],
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
                          documentSnapshot['podcast_author'],
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

/*GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PodcastPage();
              },
            ),
          );
        },
        child: Container(
          height: 130,
          child: PageView.builder(
            padEnds: false,
            physics: BouncingScrollPhysics(),
            controller: pageController,
            itemCount: 5,
            itemBuilder: (content, position) {
              return _buildPageItem(position);
            },
          ),
        ),
      ),*/
  Widget _buildPageItem(int index) {
    return Container(
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
                image: AssetImage("assets/images/ted.png"),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Ted Talks Daily",
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
            "Ted",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10,
            ),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
