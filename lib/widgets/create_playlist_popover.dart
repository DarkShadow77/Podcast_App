import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/utils.dart';

class CreatePlaylistPopover extends StatefulWidget {
  CreatePlaylistPopover({
    Key? key,
  }) : super(key: key);

  @override
  State<CreatePlaylistPopover> createState() => _CreatePlaylistPopoverState();
}

class _CreatePlaylistPopoverState extends State<CreatePlaylistPopover> {
  final formKey = GlobalKey<FormState>();

  final playlistController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    playlistController.dispose();
    super.dispose();
  }

  Future create() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      Map<String, dynamic> playlistInfo = {
        "name": playlistController.text.trim(),
      };

      var playlist = FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("playlist");

      playlist.doc(playlistController.text.trim()).set(playlistInfo);
    } on FirebaseException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: 500,
      height: 250,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.darkgrey,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Create a New Playlist",
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
                    "Choose your preferred playlist name",
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
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: playlistController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: AppColors.containerone, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color(0xff66687a), width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    gapPadding: 8,
                  ),
                  hintText: "Enter Your Playlist Name",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Color(0xff9394ad),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (user) => user != null && user.length < 2
                    ? 'Enter min. 2 character'
                    : null,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  create();
                  Navigator.pop(context);
                  Utils.showSnackBar("Playlist Created");
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 16, color: AppColors.containerone),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
