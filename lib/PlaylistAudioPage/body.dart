import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:podcast/AudioPage/options_popover.dart';
import 'package:podcast/AudioPage/playback_popover.dart';
import 'package:podcast/utils/colors.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../utils/utils.dart';
import '../widgets/add_playlist_popover.dart';
import '../widgets/back_arrow.dart';
import '../widgets/background.dart';
import '../widgets/custom_draw.dart';
import '../widgets/pause_button.dart';
import '../widgets/play_button.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
    required this.id,
    required this.asyncSnapshot,
    required this.streamLength,
  }) : super(key: key);

  final AsyncSnapshot asyncSnapshot;
  int id;
  final int streamLength;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String url = "";

  double currentVol = 0.5;
  Color muteColor = Colors.white30;
  Color volumeColor = Colors.white;

  double audioPlaybackSpeed = 1.0;

  @override
  void initState() {
    super.initState();

    PerfectVolumeControl.hideUI =
        true; //set if system UI is hided or not on volume up/down
    Future.delayed(Duration.zero, () async {
      currentVol = await PerfectVolumeControl.getVolume();
      setState(() {
        //refresh UI
      });
    });

    PerfectVolumeControl.stream.listen((volume) {
      setState(() {
        currentVol = volume;
      });
    });

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.setPlaybackRate(audioPlaybackSpeed);

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        position = Duration(seconds: 0);
        if (onRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          onRepeat = false;
        }
      });
    });
  }

  setAudio(String url) {
    audioPlayer.setUrl(url);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  bool onRepeat = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DocumentSnapshot documentss = widget.asyncSnapshot.data!.docs[widget.id];

    DocumentReference podcasts = FirebaseFirestore.instance
        .collection("Podcasts")
        .doc(documentss['podcast_author'])
        .collection("podcast_name")
        .doc(documentss['podcast_name'])
        .collection('podcast_episode')
        .doc(documentss['podcast_episode_name']);

    return Background(
      child: FutureBuilder(
        future: podcasts.get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            setAudio(data['podcast_url']);

            url = data['podcast_url'];
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackArrow(),
                          IconButton(
                            icon: Icon(
                              Icons.more_vert_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                            onPressed: () {
                              /*_optionHandleFABPressed(documentss);*/
                            },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    CupertinoIcons.volume_off,
                                    color: muteColor,
                                    size: 18,
                                  ),
                                  Icon(
                                    CupertinoIcons.speaker_2_fill,
                                    color: volumeColor,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(12),
                            child:
                                RotatedBox(quarterTurns: 2, child: CustomArc()),
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
                                  max: 1,
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
                                  initialValue: currentVol,
                                  onChange: (double value) {
                                    currentVol = value;
                                    PerfectVolumeControl.setVolume(
                                        currentVol); //set new volume
                                    setState(() {});
                                  },
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
                                          image: NetworkImage(
                                            data['image'],
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(65),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 1,
                                            color:
                                                Colors.white.withOpacity(0.25),
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
                                SizedBox(
                                  width: size.width * 0.60,
                                  child: Text(
                                    data['podcast_episode_name'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: size.width * 0.50,
                                  child: Text(
                                    data['podcast_name'],
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.50),
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                                      image:
                                          AssetImage("assets/downloading.png"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
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
                    SizedBox(
                      height: 10,
                    ),
                    Slider(
                      activeColor: AppColors.containerthree.withOpacity(0.50),
                      inactiveColor: Colors.white10,
                      thumbColor: AppColors.containertwo,
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await audioPlayer.seek(position);

                        await audioPlayer.resume();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            formatTime(position),
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
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            formatTime(duration),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.50),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                if (widget.id != 0) {
                                  widget.id -= 1;
                                  print(widget.id);
                                } else {
                                  Utils.showSnackBar("No previous podcast");
                                }
                              });
                            },
                            child: Icon(Icons.skip_previous_rounded,
                                color: Colors.white, size: 30),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (isPlaying) {
                                await audioPlayer.pause();
                              } else {
                                await audioPlayer.resume();
                              }
                            },
                            child: isPlaying
                                ? PauseButton()
                                : PlayButton(
                                    diameter: 62,
                                    iconsize: 40,
                                  ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                if ((widget.streamLength - 1) > widget.id) {
                                  widget.id += 1;
                                  print(widget.id);
                                } else {
                                  Utils.showSnackBar("No next podcast");
                                }
                              });
                            },
                            child: Icon(
                              Icons.skip_next_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  /*_addPlaylistHandleFABPressed(documentss);*/
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/add-playlist.png"),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Add to Playlist",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (onRepeat == false) {
                                    audioPlayer
                                        .setReleaseMode(ReleaseMode.LOOP);
                                    setState(() {
                                      onRepeat = !onRepeat;
                                    });
                                  } else if (onRepeat == true) {
                                    audioPlayer
                                        .setReleaseMode(ReleaseMode.RELEASE);
                                    setState(() {
                                      onRepeat = !onRepeat;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.repeat,
                                  color: onRepeat == true
                                      ? Colors.white
                                      : Colors.white30,
                                ),
                              ),
                              Text(
                                "Repeat",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  _playbackHandleFABPressed();
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Color(0xff464660),
                                  side: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "x",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      audioPlaybackSpeed.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.white30,
                                        size: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "Playback Speed",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
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
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _optionHandleFABPressed(DocumentSnapshot documentSnapshot) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => OptionPopover(
        documentSnapshot: documentSnapshot,
      ),
    );
  }

  void _addPlaylistHandleFABPressed(DocumentSnapshot documentSnapshot) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => AddPlaylistPopover(
        documentSnapshot: documentSnapshot,
      ),
    );
  }

  void _playbackHandleFABPressed() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => PlaybackPopover(
        firstPress: () {
          setState(() {
            audioPlaybackSpeed = 1;
            audioPlayer.setPlaybackRate(1.0);
            Navigator.of(context).pop();
          });
        },
        secondPress: () {
          setState(() {
            audioPlaybackSpeed = 2;
            audioPlayer.setPlaybackRate(2.0);
            Navigator.of(context).pop();
          });
        },
        thirdPress: () {
          setState(() {
            audioPlaybackSpeed = 3;
            audioPlayer.setPlaybackRate(3.0);
            Navigator.of(context).pop();
          });
        },
        fourthPress: () {
          setState(() {
            audioPlaybackSpeed = 4;
            audioPlayer.setPlaybackRate(4.0);
            Navigator.of(context).pop();
          });
        },
        fifthPress: () {
          setState(() {
            audioPlaybackSpeed = 5;
            audioPlayer.setPlaybackRate(5.0);
            Navigator.of(context).pop();
          });
        },
      ),
    );
  }
}
