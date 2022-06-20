import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movieapp/checkout.dart';
import 'package:movieapp/reused.dart';

class MovieInformation extends StatefulWidget {
  final Movie movie;
  final int? index;
  MovieInformation({required this.movie, this.index});

  @override
  _MovieInformationState createState() => _MovieInformationState();
}

class _MovieInformationState extends State<MovieInformation> {
  double btnWidth = MediaQueryData.fromWindow(window).size.width * .75;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.movie.poster!),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.black.withOpacity(0.0),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            child: Hero(
              tag: widget.movie.poster!,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  image: DecorationImage(
                    image: AssetImage(widget.movie.poster!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Hero(
              tag: 'container${widget.index}',
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: size.height * .8,
                width: size.width,
                decoration: BoxDecoration(
                  color: isDark ? Colors.black.withOpacity(.5) : Colors.white.withOpacity(.5),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * .22,
            child: FadeIn(
              active: true,
              duration: Duration(milliseconds: 400),
              delay: .2,
              child: Text(widget.movie.name!, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          ),
          Positioned(
            top: size.height * .262,
            child: FadeIn(
              active: true,
              duration: Duration(milliseconds: 400),
              delay: .2,
              child: Row(
                children: <Widget>[
                  Text('Director : '),
                  Text(widget.movie.director!, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * .30,
            height: 20,
            width: size.width,
            child: FadeIn(
              active: true,
              duration: Duration(milliseconds: 400),
              delay: .3,
              child: Center(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 20);
                  },
                  itemCount: widget.movie.genres!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return FadeIn(
                      active: true,
                      duration: Duration(milliseconds: 400),
                      delay: index * .3,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          border: Border.all(width: .8, color: isDark ? Colors.white : Colors.black),
                        ),
                        child: Text(widget.movie.genres![index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * .335,
            child: FadeIn(
              active: true,
              duration: Duration(milliseconds: 400),
              delay: .4,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Text(widget.movie.rate!, style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * .425,
            height: 160,
            width: size.width,
            child: FadeIn(
              active: true,
              duration: Duration(milliseconds: 400),
              delay: .5,
              child: Center(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 20);
                  },
                  itemCount: widget.movie.actors!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return FadeIn(
                      active: true,
                      duration: Duration(milliseconds: 400),
                      delay: index * .3,
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(widget.movie.actors![index].pic),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            width: 110,
                            height: 130,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(widget.movie.actors![index].name),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * .65,
            child: FadeIn(
              active: true,
              duration: Duration(milliseconds: 400),
              delay: .6,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Storyline..',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: size.width - 30,
                      height: 150,
                      child: Text(widget.movie.des!),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            child: Hero(
              tag: 'btn',
              child: AnimatedContainer(
                width: btnWidth,
                height: 50,
                duration: Duration(milliseconds: 120),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(Colors.grey[900])),
                  onPressed: () {
                    setState(() {
                      btnWidth = size.width;
                      Future.delayed(Duration(milliseconds: 120)).then((value) {
                        myNavigator(
                          context,
                          CheckOut(
                            movie: widget.movie,
                          ),
                        );
                        setState(() {
                          btnWidth = size.width * .75;
                        });
                      });
                    });
                  },
                  child: Text('BUY A TICKET', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
