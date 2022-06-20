import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movieapp/checkout.dart';
import 'package:movieapp/fullinfo.dart';
import 'package:movieapp/reused.dart';
import 'tile.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _toggleDark() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Ar',
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      home: MovieView(
        toggleDark: () {
          _toggleDark();
        },
      ),
    );
  }
}

class MovieView extends StatefulWidget {
  final Function? toggleDark;

  MovieView({this.toggleDark});

  @override
  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  PageController _pageController = PageController(viewportFraction: 0.8);
  PageController _backController = PageController();
  int currentPage = 0;
  double btnWidth = MediaQueryData.fromWindow(window).size.width * .5;
  double btnHeight = 120.0;
  bool buyPressed = false;

  @override
  void initState() {
    _pageController.addListener(() {
      _backController.position.jumpTo(_pageController.position.pixels + (_pageController.page!.round() * MediaQuery.of(context).size.width * .2));
      if (currentPage != _pageController.page!.round()) {
        setState(() {
          currentPage = _pageController.page!.round();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: movies.length,
            controller: _backController,
            pageSnapping: false,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(movies[index].poster!),
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.0),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 60,
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.black.withOpacity(.5) : Colors.white.withOpacity(.5),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              padding: EdgeInsets.fromLTRB(15, 8, 15, 2),
              child: Text(
                'This Week Shows',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [isDark ? Colors.black : Colors.white, Colors.transparent],
                stops: [.1, 0.5],
              ),
            ),
          ),
          Container(
            height: size.height * .8,
            child: PageView.builder(
              itemCount: movies.length,
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: <Widget>[
                    Hero(
                      tag: 'container$index',
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                          color: isDark ? Colors.black.withOpacity(.5) : Colors.white.withOpacity(.5),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(15, currentPage == index ? 0 : 80, 15, 25),
                        duration: Duration(milliseconds: 350),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        myNavigator(
                            context,
                            MovieInformation(
                              movie: movies[index],
                              index: index,
                            ));
                      },
                      child: AnimatedContainer(
                        margin: EdgeInsets.fromLTRB(0, currentPage == index ? 0 : 80, 0, 25),
                        duration: Duration(milliseconds: 350),
                        height: size.height,
                        child: movieTile(
                          size: size,
                          movie: movies[index],
                          active: currentPage == index ? true : false,
                        ),
                        width: size.width,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            bottom: 8,
            child: Hero(
              tag: 'btn',
              child: AnimatedContainer(
                width: btnWidth,
                height: 45,
                curve: Curves.easeOutCubic,
                duration: Duration(milliseconds: 200),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(Colors.grey[900])),
                  onPressed: () {
                    setState(() {
                      btnWidth = size.width;
                      Future.delayed(Duration(milliseconds: 100)).then((value) {
                        myNavigator(
                            context,
                            CheckOut(
                              movie: movies[_pageController.page!.round()],
                            ));
                        setState(() {
                          btnWidth = size.width * .5;
                        });
                      });
                    });
                  },
                  child: Text(
                    'BUY A TICKET',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? Colors.black.withOpacity(.5) : Colors.white.withOpacity(.5),
              ),
              child: IconButton(
                  icon: Icon(Icons.brightness_6),
                  onPressed: () {
                    widget.toggleDark!();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
