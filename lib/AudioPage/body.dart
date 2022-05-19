import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podcast/utils/colors.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../widgets/backgound.dart';
import '../widgets/custom_draw.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool play = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.white.withOpacity(0.50),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.share_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.more_vert_rounded,
                            color: Colors.white,
                            size: 35,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  width: 300,
                  height: 300,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff171925),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.only(bottom: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                CupertinoIcons.volume_off,
                                color: Colors.white30,
                                size: 18,
                              ),
                              Icon(
                                CupertinoIcons.speaker_2_fill,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(12),
                        child: RotatedBox(quarterTurns: 2, child: CustomArc()),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            SleekCircularSlider(
                              min: 0,
                              max: 100,
                              appearance: CircularSliderAppearance(
                                size: 250,
                                angleRange: 180,
                                startAngle: 180,
                                counterClockwise: true,
                                customWidths: CustomSliderWidths(
                                  progressBarWidth: 5,
                                  trackWidth: 5,
                                  handlerSize: 10,
                                ),
                                customColors: CustomSliderColors(
                                  trackColor: Colors.white38,
                                  progressBarColors: [
                                    Color(0xfff25656),
                                    Color(0xff985ee1),
                                  ],
                                  hideShadow: true,
                                  gradientStartAngle: 120,
                                  dotColor: Colors.white,
                                ),
                              ),
                              initialValue: 50,
                              onChange: (double value) {},
                            ),
                            Container(
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff181A27),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff181A27),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff6B4399),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/music_thumbnail.jpg'),
                                    ),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(65),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.white.withOpacity(0.25),
                                      ),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black38,
                                        border: Border.all(
                                          width: 0.5,
                                          color: Colors.white54,
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.backgroundColor,
                                          border: Border.all(
                                            width: 0.5,
                                            color: Colors.white60,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage("assets/play.png"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '15324',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.50),
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  'Plays',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.50),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Dele Divoneh',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Ahllam',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.50),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/downloading.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/add_user.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/like.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: Slider(
                    value: 10,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white.withOpacity(0.50),
                    thumbColor: Color(0xffEB8C89),
                    onChanged: null,
                    max: 100,
                    min: 0,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '01:25',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        '/',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.50),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '03:46',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.50),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/previous.png"),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            play = true;
                          });
                        },
                        child: play == true
                            ? PlayButton(icon: Icons.play_arrow_rounded)
                            : PlayButton(icon: Icons.stop_rounded),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/next.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/playlist.png"),
                          ),
                        ),
                      ),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/repeat.png"),
                          ),
                        ),
                      ),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/shuffle.png"),
                          ),
                        ),
                      ),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/add_playlist.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff464660),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.50),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.5,
                        0.5,
                      ],
                    ).createShader(bounds),
                    child: Icon(
                      Icons.keyboard_double_arrow_up_rounded,
                      size: 30,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Container(
          width: 62,
          height: 62,
          padding: EdgeInsets.all(0.3),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xffEB8C89),
                  Color(0xffA54982),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(1, 1),
                  blurRadius: 4,
                  color: Color(0xffEB8C89),
                ),
                BoxShadow(
                  offset: Offset(-1, -1),
                  blurRadius: 4,
                  color: Color(0xffA54982),
                ),
              ]),
          child: Center(
            child: Container(
              width: 59,
              height: 59,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xffF77277).withOpacity(0.75),
                    Color(0xffBD4D87).withOpacity(0.75),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffF77277),
                        Color(0xffBD4D87),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Colors.white,
                        Color(0xffF897AA).withOpacity(0.5),
                        Color(0xffF897AA),
                      ],
                      stops: [0.5, 0.6, 0.7],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ).createShader(bounds),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                  /*child: Icon(
                    icon,
                    color: Colors.white,
                    size: 38,
                  ),*/
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
