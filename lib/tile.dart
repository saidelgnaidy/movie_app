import 'package:flutter/material.dart';
import 'package:movieapp/reused.dart';



movieTile({required Size size ,required Movie movie ,bool? active})  {

  return Stack(
    alignment: Alignment.topCenter,
    children: <Widget>[
      Positioned(
        top: 0,
        width: size.width*.8-50,
        height: size.height*.53,
        child: Hero(
          tag: movie.poster!,
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 20,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20),),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(movie.poster!),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: size.height*.53,
        child: FadeIn(
          active: active,
          duration: Duration(milliseconds: 300),
          delay: 0.1,
          child: Text(movie.name!,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
        ),
      ),
      Positioned(
        top: size.height*.58,
        height: 20,
        child: FadeIn(
          active: active,
          duration: Duration(milliseconds: 300),
          delay: 0.2,
          child: Center(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 20);
              },
              itemCount: movie.genres!.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30),),
                      border: Border.all(width: .8,color: isDark ?  Colors.white : Colors.black)
                  ),
                  child: Text(movie.genres![index]),
                );
              },
            ),
          ),
        ),
      ),
      Positioned(
        top: size.height*.62,
        child: FadeIn(
          active: active,
          duration: Duration(milliseconds: 300),
          delay: 0.4,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Icon(Icons.star,color: Colors.orange,size: 60),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Text(movie.rate!,style: TextStyle(fontSize: 15),),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: size.height*.68,
        child: FadeIn(
          active: active,
          duration: Duration(milliseconds: 300),
          delay: 0.5,
          child: Text('...',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
        ),
      ),
    ],
  );
}
