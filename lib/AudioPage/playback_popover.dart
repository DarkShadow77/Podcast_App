import 'package:flutter/material.dart';

import '../utils/colors.dart';

class PlaybackPopover extends StatelessWidget {
  const PlaybackPopover({
    Key? key,
    required this.firstPress,
    required this.secondPress,
    required this.thirdPress,
    required this.fourthPress,
    required this.fifthPress,
  }) : super(key: key);

  final VoidCallback firstPress;
  final VoidCallback secondPress;
  final VoidCallback thirdPress;
  final VoidCallback fourthPress;
  final VoidCallback fifthPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.45,
        builder: (_, controller) => Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.only(
                  right: 20.0, left: 20.0, top: 80.0, bottom: 20.0),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.darkgrey,
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              ),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            OutlinedButton(
                              onPressed: firstPress,
                              child: Text(
                                "1",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: Divider(
                                height: 1,
                                color: AppColors.lightgrey.withOpacity(0.25),
                                thickness: 1.5,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: secondPress,
                              child: Text(
                                "2",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: Divider(
                                height: 1,
                                color: AppColors.lightgrey.withOpacity(0.25),
                                thickness: 1.5,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: thirdPress,
                              child: Text(
                                "3",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: Divider(
                                height: 1,
                                color: AppColors.lightgrey.withOpacity(0.25),
                                thickness: 1.5,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: fourthPress,
                              child: Text(
                                "4",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: Divider(
                                height: 1,
                                color: AppColors.lightgrey.withOpacity(0.25),
                                thickness: 1.5,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: fifthPress,
                              child: Text(
                                "5",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
                      "Playback Speed",
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
                        "Choose your preferred playback speed",
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
}
