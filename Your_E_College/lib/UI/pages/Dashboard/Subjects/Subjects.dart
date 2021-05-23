import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(fontFamily: 'Roboto'),
  home:Subjects(),
));

class Subjects extends StatefulWidget {
  @override
  _Subjects createState() => _Subjects();
}

class _Subjects extends State<Subjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Your Courses',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 243, 243, 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black87,
                            ),
                            hintText: "Search you're looking for",
                            hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 15)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'All courses',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          promoCard('https://image.freepik.com/free-vector/cute-book-pencil-cartoon-vector-icon-illustration-education-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-1448.jpg',"Course 1"),
                          promoCard('https://image.freepik.com/free-vector/cute-book-pencil-cartoon-vector-icon-illustration-education-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-1448.jpg',"Course 2"),
                          promoCard('https://image.freepik.com/free-vector/cute-book-pencil-cartoon-vector-icon-illustration-education-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-1448.jpg',"Course 3"),
                          promoCard('https://image.freepik.com/free-vector/cute-book-pencil-cartoon-vector-icon-illustration-education-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-1448.jpg',"Course 4"),
                          promoCard('https://image.freepik.com/free-vector/cute-book-pencil-cartoon-vector-icon-illustration-education-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-1448.jpg',"Course 5"),
                          promoCard('https://image.freepik.com/free-vector/cute-book-pencil-cartoon-vector-icon-illustration-education-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-1448.jpg',"Course 6"),
                        ],

                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget promoCard(image, text1) {
    return AspectRatio(
      aspectRatio: 2.92 / 3,
      child:
          Container(
          child: Column(
              children: [
                Text(text1,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                Text('C1 :     ',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, backgroundColor: Colors.white),),
                Text('C2 :     ',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,backgroundColor: Colors.white),),
                Text('C3 :     ',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,backgroundColor: Colors.white),),]

          ),
          margin: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)),
          ),
        ),
  /* Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
    0.1,
    0.9
    ], colors: [
    Colors.black.withOpacity(.8),
    Colors.black.withOpacity(.1)
    ]))),
       Column(
         children: [
           Text('Course',
             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
    Text('C1',
    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
    Text('C2',
    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
    Text('C3',
    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)]

       ), */

      );
  }
}