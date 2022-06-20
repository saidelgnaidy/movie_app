import 'package:flutter/material.dart';
import 'package:movieapp/reused.dart';

class Pay extends StatefulWidget {
  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  @override
  void initState() {
    autoClose();
    super.initState();
  }

  autoClose() {
    Future.delayed(Duration(seconds: 2), () => Navigator.of(context));
  }

  @override
  Widget build(BuildContext context) {
    String successful = 'SUCCESSFUL';
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: successful.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: FadeIn(
                duration: Duration(milliseconds: 500),
                active: true,
                delay: index * 0.2,
                child: Text(
                  successful[index],
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
