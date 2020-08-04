import 'package:flutter/material.dart';
import 'package:logic_gates_drawer/logicGates.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logic Gates Drawer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Logic Gates Drawer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*
  static int size = 5;
  List<List<int>> _dataGates = List<List<int>>.generate(
      size, (i) => List<int>.generate(size, (j) => i * size + j));
  */
  static int width = 50;
  static int height = 50;
  List<List<int>> _dataGates = drawLogicGates(width, height);

  void getNewGates() {
    _dataGates = drawLogicGates(width, height);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 700,
              width: 700,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey[500]),
                boxShadow: [],
              ),
              child: CustomPaint(
                painter:
                    GatesDrawer(dataGates: _dataGates, color: Colors.blue[700]),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.25,
              padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
              child: RaisedButton(
                child: Text("Generate New"),
                onPressed: () => getNewGates(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GatesDrawer extends CustomPainter {
  // use animated builder to get cool effect bud
  List<List<int>> dataGates;
  Color color;

  GatesDrawer({this.dataGates, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final paint2 = Paint()..color = Colors.black;
    final widthRect = size.width / dataGates.length;
    final heightRect = size.width / dataGates.length;

    for (int i = 0; i < dataGates.length; i++) {
      for (int j = 0; j < dataGates[0].length; j++) {
        Rect rTest = Rect.fromPoints(Offset(i * widthRect, j * heightRect),
            Offset((i + 1) * widthRect, (j + 1) * heightRect));
        var currColor = paint2;
        if (dataGates[i][j] != 0) {
            currColor = paint;
        }
                  canvas.drawRect(rTest, currColor);

      }
    }
  }

  @override
  bool shouldRepaint(GatesDrawer oldDelegate) {
    return dataGates != oldDelegate.dataGates;
  }
}
