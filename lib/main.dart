import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController;

  List allSlides = [
    {'slideName': 'slideOne', 'selected': false},
    {'slideName': 'slideTwo', 'selected': false},
    {'slideName': 'slideThree', 'selected': false},
    {'slideName': 'slideFour', 'selected': false},
    {'slideName': 'slideFive', 'selected': false},
    {'slideName': 'slideSix', 'selected': false},
    {'slideName': 'slideSeven', 'selected': false},
    {'slideName': 'slideEight', 'selected': false},
    {'slideName': 'slideNine', 'selected': false}
  ];

  var selectedSlide;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(changeSelector);
    setState(() {
      selectedSlide = allSlides[0];
      selectedSlide['selected'] = true;
    });
  }

  changeSelector() {
    var maxScrollVal = _scrollController.position.maxScrollExtent;

    var divisor = (maxScrollVal / allSlides.length) + 20;

    var scrollValue = _scrollController.offset.round();
    var slideValue = (scrollValue / divisor).round();

    var currentSlide = allSlides.indexWhere((slide) => slide['selected']);

    setState(() {
      allSlides[currentSlide]['selected'] = false;
      selectedSlide = allSlides[slideValue];
      selectedSlide['selected'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scroll Tricks'),
          centerTitle: true,
        ),
        body: Row(
          children: <Widget>[
            SizedBox(width: 15.0),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: ListView(
                  children: allSlides.map((element) {
                return getTitles(element);
              }).toList()),
            ),
            SizedBox(width: 10.0),
            Container(
              width: (MediaQuery.of(context).size.width / 3) * 2 - 25.0,
              child: ListView(
                controller: _scrollController,
                children: allSlides.map((element) {
                  return getCards(element);
                }).toList(),
              ),
            )
          ],
        ));
  }

  Widget getCards(slide) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, right: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black, style: BorderStyle.solid, width: 1.0),
        ),
        height: 200.0,
        width: 125.0,
        child: Center(
          child: Text(
            slide['slideName'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  scrollToSlide(inputSlide) {
    var whichSlide = allSlides
        .indexWhere((slide) => slide['slideName'] == inputSlide['slideName']);

    var maxScrollValue = _scrollController.position.maxScrollExtent;

    var divisor = (maxScrollValue / allSlides.length) + 20;

    var scrollToValue = whichSlide * divisor;

    _scrollController.animateTo(scrollToValue,
        curve: Curves.easeIn, duration: Duration(milliseconds: 1000));
  }

  Widget getTitles(slide) {
    return InkWell(
      onTap: () {
        scrollToSlide(slide);
      },
      child: Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: Text(
          slide['slideName'],
          style: TextStyle(
              fontWeight:
                  slide['selected'] ? FontWeight.bold : FontWeight.normal,
              fontSize: 17.0),
        ),
      ),
    );
  }
}
