import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keyboard2/view/Keyboard.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      //don't change this
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          // initialBinding: HomeBinding(),
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            // colorScheme: ColorScheme.dark(
            //
            //     primary: Color(0xFF2E92DA)
            //   // primaryContainer: Color(0xFF303031), //button
            //   // tertiary: Color(0xFF000000),
            //   // tertiaryContainer: Color(0xFF000000),
            //   // background: Color(0xFFFFFF),
            //   // onBackground: Colors.black,
            //   // surface: Color(0xFF000000),
            //   // onSurface: Color(0xFF000000)
            //
            //   // t: Color(0xFF000000),
            //
            //
            //
            //
            // ),
            // scaffoldBackgroundColor: Color(0xff000512),
            // scaffoldBackgroundColor: Color(0xff000512),

          ),
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 100, 2, 0),
                    // padding: const EdgeInsets.fromLTRB(20, 100, 2, 100),
                    child: Text('1. Enter your UID\n2. Enter esPbt?917 in the visible keyboard input and hit the enter(>) icon\n3.Repeat step 2, 5 times',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ) ,
                      textAlign: TextAlign.left,


                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    // padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    child: TextField(
                      controller: mKeyboardController.usernameController,
                      style: const TextStyle(
                          color: Colors.black),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter UID",

                      ),
                      // on: () {
                      //
                      //   }
                      //
                      //   }

                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Keyboard(),
                  ),
                ]
            )),

        );
      },
      // child: const MyHomePage(title: 'First Method'),


    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
  }
}
