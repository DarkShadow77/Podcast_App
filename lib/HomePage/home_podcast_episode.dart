import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/play_button.dart';

class Home_Podcast_Episode extends StatelessWidget {
  const Home_Podcast_Episode({
    Key? key,
    required this.size,
    required this.press,
  }) : super(key: key);

  final Size size;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      image: AssetImage("assets/images/ted.png"),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) {
                  //         return PodcastPage();
                  //       },
                  //     ),
                  //   );
                  // },
                  child: Text(
                    "Ted Talks Daily",
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Our Longing for cosmic truth and poetic beauty | Maria Popova",
              maxLines: 2,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.70,
                  child: Column(
                    children: [
                      Text(
                        "Linking together the histories of Henrietta Swan Leavitt, Edwin Hubble and Tracy K. Smith, poet and thinker Maria Popova crafts an astonishing story of how humanity came to see the edge of the observable universe. (Followed by an animated excerpt of 'My God, It's Full of Stars,' by Tracy K. Smith)",
                        maxLines: 2,
                        style: TextStyle(
                          color: AppColors.lightgrey,
                          fontSize: 10,
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
                                "8 min",
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
                                "2 Days ago",
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
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AudioPage();
                        },
                      ),
                    );*/
                  },
                  child: PlayButton(
                    diameter: 40,
                    iconsize: 25,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: AppColors.lightgrey,
            ),
          ],
        ),
      ),
    );
  }
}
