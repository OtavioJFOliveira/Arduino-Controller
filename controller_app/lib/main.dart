import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:swipedetector/swipedetector.dart';

import 'BluetoothPage.dart';
import 'KeyBoard.dart';
import 'Ultrasonic.dart';
import 'VoicePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

String variavel = "{-122.485046,37.820047,3000},{78.042202,27.172969,1500},{-43.210317,-22.951838,400},{-88.567935,20.683510,600},{12.492135,41.890079,600},{-72.545224,-13.163820,600},{35.441919,30.328456,600},{2.294473,48.857730,1000},{-0.124419,51.500769,500},{-74.044535,40.689437,500},{37.623446,55.752362,500},{-73.985359,40.748360,500},{-51.049260,0.030478,500},{31.132695,29.976603,500},{0.626502,41.617540,600},{116.562771,40.435456,500}";

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FSBStatus drawerStatus;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  SwipeDetector(
          onSwipeRight: (){
            setState(() {
              drawerStatus = FSBStatus.FSB_OPEN;
            });
          },
          onSwipeLeft: (){
            setState(() {
              drawerStatus = FSBStatus.FSB_CLOSE;
            });
          },
          child: FoldableSidebarBuilder(
            drawerBackgroundColor: Colors.blue,
            drawer: CustomDrawer(closeDrawer: (){
              setState(() {
                drawerStatus = FSBStatus.FSB_CLOSE;
              });
            },),
            screenContents: Scaffold(
              appBar: AppBar(
                title: Text("Arduino LG Controller"),
                backgroundColor: Colors.blue,
                leading: IconButton(icon: Icon(Icons.menu,color: Colors.white,size: 35,),
                    onPressed: (){
                      setState(() {
                        drawerStatus = drawerStatus == FSBStatus.FSB_OPEN ? FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
                      });
                    }),
              ),
              body: FoldableSidebarBuilder(
                screenContents: FirstScreen(), status: null, drawer: null,
              ),
            ),
            status: drawerStatus,
          ),
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SizedBox(
            child: RaisedButton(
              onPressed: (){

              },
              child: Text("Bluetooth Connect", style: TextStyle(
                  color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),
              ),
              color: Colors.blue,
              elevation: 10,
            ),
          ),
          width: 200,
          height: 100,
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {

  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: mediaQuery.size.width * 0.60,
      height: size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.blue.withAlpha(180),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/lg_logo.png",
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text("Liquid Galaxy",
                    style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),
                  )
                ],
              )),
          Expanded(
            child: Container(
              child: LayoutBuilder(
                builder: (_,constraints){
                  return Container(
                    height: constraints.maxHeight,
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BluetoothPage()));
                            closeDrawer();
                          },
                          leading: Icon(Icons.bluetooth_connected),
                          title: Text(
                            "Connect",
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>KeyBoardPage()));
                            closeDrawer();
                          },
                          leading: Icon(Icons.keyboard),
                          title: Text("Keyboard"),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VoicePage()));
                            closeDrawer();
                          },
                          leading: Icon(Icons.settings_voice),
                          title: Text("Voice Recognition"),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UltrasonicPage()));
                            closeDrawer();
                          },
                          leading: Icon(Icons.surround_sound),
                          title: Text("Ultrasonic"),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        ListTile(
                          onTap: () {
                            debugPrint("Accelerometer");
                          },
                          leading: Icon(Icons.vertical_align_center),
                          title: Text("Accelerometer"),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        ListTile(
                          onTap: () {
                            debugPrint("Settings");
                          },
                          leading: Icon(Icons.location_on),
                          title: Text("Places"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),


        ],
      ),
    );
  }
}