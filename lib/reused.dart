import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

bool isDark = false;

class Movie {
  final String? poster, name, rate, des, director, trailer;
  final List<String>? genres;
  final List<Actor>? actors;

  Movie({this.trailer, this.director, this.actors, this.des, this.poster, this.name, this.rate, this.genres});
}

class Actor {
  final name, pic;
  Actor({this.name, this.pic});
}

enum _AniProps { opacity, translateX }

class FadeIn extends StatelessWidget {
  final double delay;
  final Widget child;
  final Duration duration;
  final bool? active;

  FadeIn({required this.delay, required this.child, required this.duration, required this.active});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(
        _AniProps.opacity,
        Tween(begin: 0.0, end: 1.0),
      )
      ..add(_AniProps.translateX, Tween(begin: 200.0, end: 0.0));

    return active!
        ? PlayAnimation<MultiTweenValues<_AniProps>>(
            delay: Duration(milliseconds: (500 * delay).round()),
            duration: Duration(milliseconds: 500),
            tween: tween,
            child: child,
            curve: Curves.easeOutCubic,
            builder: (context, child, value) => Opacity(
              opacity: value.get(_AniProps.opacity),
              child: Transform.translate(
                offset: Offset(0, value.get(_AniProps.translateX)),
                child: child,
              ),
            ),
          )
        : SizedBox();
  }
}

myNavigator(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation.drive(CurveTween(curve: Curves.easeOut));
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return widget;
      },
    ),
  );
}

List<Movie> movies = [
  Movie(
      name: 'Breaking Bad',
      poster: 'assets/bb.jpg',
      rate: '9.3',
      genres: [
        'Crime',
        'Drama',
        'Thriller',
      ],
      des:
          'When chemistry teacher Walter White is diagnosed with Stage III cancer and given only two years to live, he decides he has nothing to lose. He lives with his teenage son, who has cerebral palsy, and his wife, in New Mexico. Determined to ensure that his family will have a secure future, Walt embarks on a career of drugs and crime. He proves to be remarkably proficient in this new world as he begins manufacturing and selling methamphetamine with one of his former students. The series tracks the impacts of a fatal diagnosis on a regular, hard working man, and explores how a fatal diagnosis affects his morality and transforms him into a major player of the drug trade.',
      actors: [
        Actor(name: 'Bryan Cranston', pic: 'assets/bry.jpg'),
        Actor(name: 'Aaron Paul', pic: 'assets/aa.jpg'),
        Actor(name: 'Giancarlo Esposito', pic: 'assets/gi.jpg'),
      ],
      director: 'Vince Gilligan',
      trailer: 'https://cdn-b-east.streamable.com/video/mp4/lxty31.mp4?token=FDyZiNU2YuFJ77eTH_ud4g&expires=1593235080'),
  Movie(
      name: 'JOKER',
      poster: 'assets/joker.jpg',
      rate: '8.5',
      genres: [
        'Drama',
        'Thriller',
        'Crime',
      ],
      actors: [
        Actor(name: 'Joaquin Phoenix', pic: 'assets/jo.jpg'),
        Actor(name: 'Robert De Niro', pic: 'assets/ro.jpg'),
        Actor(name: 'Zazie Beetz', pic: 'assets/za.jpg'),
      ],
      director: 'Todd Phillips',
      des:
          'Arthur Fleck works as a clown and is an aspiring stand-up comic. He has mental health issues, part of which involves uncontrollable laughter. Times are tough and, due to his issues and occupation, Arthur has an even worse time than most. Over time these issues bear down on him, shaping his actions, making him ultimately take on the persona he is more known as...Joker',
      trailer: 'https://cdn-b-east.streamable.com/video/mp4/0k9ips.mp4?token=vaQgVStd2aRZWeF_HPmMlw&expires=1593235020'),
  Movie(
      name: 'Avengers: Endgame',
      poster: 'assets/end.jpg',
      rate: '8.4',
      genres: [
        'Action',
        'Adventure',
        'Drama',
      ],
      des:
          'After the devastating events of Avengers: Infinity War (2018), the universe is in ruins due to the efforts of the Mad Titan, Thanos. With the help of remaining allies, the Avengers must assemble once more in order to undo Thanos'
          's actions and undo the chaos to the universe, no matter what consequences may be in store, and no matter who they face...',
      actors: [
        Actor(name: 'Robert Downey', pic: 'assets/rob.jpg'),
        Actor(name: 'Chris Evans', pic: 'assets/chr.jpg'),
        Actor(name: 'Scarlett Johansson', pic: 'assets/sca.jpg'),
        Actor(name: 'Mark Ruffalo', pic: 'assets/mar.jpg'),
      ],
      director: 'Anthony Russo',
      trailer: 'https://cdn-b-east.streamable.com/video/mp4/skjwzz.mp4?token=CnKQb4HKkO0KYPnSeyBP8Q&expires=1593235080'),
  Movie(
      name: 'Inception',
      poster: 'assets/ins.jpg',
      rate: '8.8',
      genres: ['Action', 'Adventure', 'Sci-Fi', 'Thriller'],
      des:
          'Dom Cobb is a skilled thief, the absolute best in the dangerous art of extraction, stealing valuable secrets from deep within the subconscious during the dream state, when the mind is at its most vulnerable. Cobb'
          's rare ability has made him a coveted player in this treacherous new world of corporate espionage, but it has also made him an international fugitive and cost him everything he has ever loved. Now Cobb is being offered a chance at redemption. One last job could give him his life back but only if he can accomplish the impossible, inception. Instead of the perfect heist, Cobb and his team of specialists have to pull off the reverse: their task is not to steal an idea, but to plant one.',
      actors: [
        Actor(name: 'Leonardo DiCaprio', pic: 'assets/leo.jpg'),
        Actor(name: 'Joseph Gordon', pic: 'assets/jos.jpg'),
        Actor(name: 'Ellen Page', pic: 'assets/ell.jpg'),
        Actor(name: 'Tom Hardy', pic: 'assets/tom.jpg'),
      ],
      director: 'Christopher Nolan',
      trailer: 'https://cdn-b-east.streamable.com/video/mp4/bl2o7h.mp4?token=TBzEO4GkJ6dAAH1zkYFgfg&expires=1593234960'),
];
