import 'package:flutter/material.dart';
import 'package:movieapp/pay.dart';
import 'package:movieapp/reused.dart';
import 'package:video_player/video_player.dart';

class CheckOut extends StatefulWidget {
  final Movie movie;

  CheckOut({required this.movie});

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  late VideoPlayerController controller;
  bool selectedSeat = false;
  int cost = 0;
  double bottom = 15.0;
  List<int> selected = [];
  _videoPlayer(String url) {
    controller = VideoPlayerController.network(url);
    controller.initialize().then((value) {
      setState(() {
        controller.play();
      });
    });
  }

  onPressed() {
    setState(() {
      selectedSeat = !selectedSeat;
    });
  }

  @override
  void initState() {
    _videoPlayer(widget.movie.trailer!);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Hero(
              tag: 'btn',
              child: Container(
                height: size.height,
                width: size.width,
              ),
            ),
            Positioned(
              top: 20,
              child: Container(
                width: size.width - 50,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Placeholder(),
                ),
              ),
            ),
            Positioned(
              top: size.height * .33,
              child: Container(
                width: size.width - 50,
                height: size.width - 200,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 13,
                  ),
                  itemCount: 104,
                  itemBuilder: (BuildContext context, int index) {
                    if (index % 13 == 6) {
                      return SizedBox(
                        width: 20,
                        height: 20,
                      );
                    }
                    return FadeIn(
                      duration: Duration(milliseconds: 200),
                      delay: index % 13 * 0.05,
                      active: true,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            bottom = 29;
                            if (selected.contains(index)) {
                              selected.remove(index);
                              cost = cost - 8;
                            } else {
                              selected.add(index);
                              cost = cost + 8;
                            }
                          });
                        },
                        child: Icon(
                          Icons.event_seat,
                          color: selected.contains(index)
                              ? Colors.orange
                              : index <= 20
                                  ? Colors.black
                                  : Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: size.height * .66,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FadeIn(
                    duration: Duration(milliseconds: 300),
                    active: true,
                    delay: 0.5,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Text(
                            'Available',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  FadeIn(
                    duration: Duration(milliseconds: 300),
                    active: true,
                    delay: 0.9,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          maxRadius: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Text(
                            'Taken',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeIn(
                    duration: Duration(milliseconds: 300),
                    active: true,
                    delay: 1.3,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.orange,
                          maxRadius: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Text(
                            'Selected',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: size.height * .73,
              child: Container(
                width: size.width,
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: FadeIn(
                          active: true,
                          duration: Duration(milliseconds: 250),
                          delay: index / 10 + .2,
                          child: Container(
                            width: 60,
                            height: 75,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white.withOpacity(.5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('${index * 6 + 1}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                Text(
                                  'June',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                                Text('0${index + 8}:00')
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Positioned(
              bottom: 15,
              child: FadeIn(
                active: true,
                delay: 1.0,
                duration: Duration(milliseconds: 300),
                child: Hero(
                  tag: 'pay',
                  child: Container(
                    width: size.width * .6,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(Colors.grey[900])),
                      onPressed: () {
                        myNavigator(context, Pay());
                      },
                      child: Text('Pay      ', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              bottom: bottom,
              left: size.width * .5 + 5,
              duration: Duration(milliseconds: 300),
              child: Container(
                height: 20,
                width: 40,
                child: cost == 0 ? SizedBox() : Text("$cost \$", style: TextStyle(color: Colors.orangeAccent, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
