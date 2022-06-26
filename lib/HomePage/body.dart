import 'package:flutter/material.dart';
import 'package:podcast/widgets/backgound.dart';

import '../widgets/rounded_input_field.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Background(
      child: CustomScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            expandedHeight: 150.0,
            elevation: 0,
            pinned: true,
            automaticallyImplyLeading: false,
            floating: true,
            stretch: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                titlePadding:
                    EdgeInsets.only(left: 20, right: 20, bottom: 70, top: 10),
                stretchModes: [
                  StretchMode.blurBackground,
                  // StretchMode.fadeTitle
                ],
                title: Container(
                  child: Row(
                    children: [
                      Container(
                        decoration: ,
                      )
                    ],
                  ),
                )),
            bottom: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: RoundedInputField(
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [],
            ),
          ),
        ],
      ),
    );
  }
}
