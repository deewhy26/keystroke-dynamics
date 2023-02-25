import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keyboard2/controller/KeyboardController.dart';
import 'package:sensors_plus/sensors_plus.dart';


var mKeyboardController = KeyboardController();

void resetKeyboard(
    ) {

  mKeyboardController.isCapsOn.value = false;
  mKeyboardController.isNumOn.value = false;
  Obx(() {
    return Keyboard().ColumnNumOn;
  });
  Obx(() {
    return Keyboard().ColumnIsCapOff;
  });
}

class Keyboard extends StatelessWidget {
  Keyboard({Key? key}) : super(key: key);
  bool isEnabled = false;
  var ColumnNumOn = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      KeyRow(letterString: mKeyboardController.row1StrNum),
      KeyRow(letterString: mKeyboardController.row2StrNum),
      KeyRow3(letterString: mKeyboardController.row3StrNum),
      const KeyRow4()
    ],
  );
  var ColumnIsCapOn = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      KeyRow(letterString: mKeyboardController.row1Str.toUpperCase()),
      KeyRow(letterString: mKeyboardController.row2Str.toUpperCase()),
      KeyRow3(letterString: mKeyboardController.row3Str.toUpperCase()),
      const KeyRow4()
    ],
  );

  var ColumnIsCapOff = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      KeyRow(letterString: mKeyboardController.row1Str),
      KeyRow(letterString: mKeyboardController.row2Str),
      KeyRow3(letterString: mKeyboardController.row3Str),
      const KeyRow4()
    ],
  );

  @override
  Widget build(BuildContext context) {
    mKeyboardController.isCapsOn.value = false;
    mKeyboardController.isNumOn.value = false;

    gyroscopeEvents.listen((GyroscopeEvent event) {
      mKeyboardController.updateRotation(event);
    });
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: const BoxDecoration(color: Color(0xff292E32)),
        padding: EdgeInsets.only(bottom: 41.w),
        // padding: EdgeInsets.symmetric(vertical: 41.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              // enabled: isEnabled,
              autofocus: true,
              controller: mKeyboardController.inputField,
              showCursor: true,
              readOnly: true,
            ),
            // ElevatedButton( onPressed: ()
            //      {
            //   mKeyboardController.addToDb();
            // }, child: Text("Submit")),
            Obx(() {
              if (mKeyboardController.isNumOn.value) {
                return ColumnNumOn;
              } else {
                if (mKeyboardController.isCapsOn.value) {
                  return ColumnIsCapOn;
                } else {
                  return ColumnIsCapOff;
                }
              }
              return const SizedBox();
            }),
            // KeyRow1(),
            // KeyRow2(),
            // KeyRow1(),
            // KeyRow1(),
            // KeyRow2(),
            // KeyRow3(),
            // KeyRow4()
          ],
        ),
      ),
    );
  }
}

class KeyRow4 extends StatelessWidget {
  const KeyRow4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        NumSwitchButton(),
        MKey(letter: ","),
        SpaceBarButton(),
        MKey(letter: "."),
        EnterButton()
      ],
    );
  }
}

class NumSwitchButton extends StatelessWidget {
  const NumSwitchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WithPointerEvent(
        mWidget: GestureDetector(
      onTap: () {
        mKeyboardController.numSwitch();

      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xff484C4F),
            borderRadius: BorderRadius.all(Radius.circular(6.w))),
        height: 41.w,
        width: 49.w,
        margin: EdgeInsets.all((2.5).w),
        child: Center(
            child: Text(
              mKeyboardController.isNumOn.value ? "abc" :"?123", style: TextStyle(
              fontSize: 18.w, color: Colors.white,
              // fontWeight: FontWeight.w300
              // decorationColor: Colors.white
            ),
            )),
      ),
    ));
  }
}

class SpaceBarButton extends StatelessWidget {
  const SpaceBarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: WithPointerEvent(mWidget:
      GestureDetector(
        onTap: () {
          mKeyboardController.addLetter(" ");
        },
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xff484C4F),
              borderRadius: BorderRadius.all(Radius.circular(6.w))),
          height: 41.w,
          margin: EdgeInsets.all((2.5).w),
          child: Row(mainAxisSize: MainAxisSize.max,children: const [],),
        ),
      )),
    );
  }
}

class EnterButton extends StatelessWidget {
  const EnterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {

        if (mKeyboardController.inputField.text != "esPbt?917") {
          Get.snackbar("Data upload unsuccessful", "Please enter the correct password",
            backgroundColor: Colors.red


              );
          mKeyboardController.clearInput();
        }
        else {
          mKeyboardController.addToSession();
          mKeyboardController.clearInput();
        }
        resetKeyboard(); //multiple sessions use
        //
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xff484C4F),
            borderRadius: BorderRadius.all(Radius.circular(6.w))),
        height: 41.w,
        width: 49.w,
        margin: EdgeInsets.all((2.5).w),
        child: Center(
            child: Transform.rotate(
              angle: pi,
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            )),
      ),
    );
  }


}

class KeyRow extends StatelessWidget {
  final String letterString;

  const KeyRow({super.key, required this.letterString});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [...getListOfKeys(letterString)],
    );
  }
}

class CapsButton extends StatelessWidget {
  const CapsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WithPointerEvent(
        mWidget: GestureDetector(
      onTap: () {
        mKeyboardController.oneTapCaps();
        // mKeyboardController.addLetter(letter);
        // print(letter);
      },

      onDoubleTap: () {
        mKeyboardController.oneDoubleTapCaps();
        //   print("double tap");
      }, //use only on shift
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xff484C4F),
            borderRadius: BorderRadius.all(Radius.circular(6.w))),
        height: 41.w,
        margin: EdgeInsets.all((2.5).w),
        child: Center(
            child: Obx(() => Transform.rotate(
                  angle: mKeyboardController.isCapsOn.value ? pi : 0,
                  child: const Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.white,
                  ),
                ))),
      ),
    ));
  }
}

// _onTapDown(TapDownDetails details) {
//   PointerEvent
// }

class WithPointerEvent extends StatelessWidget {
  final Widget mWidget;

  const WithPointerEvent({super.key, required this.mWidget});

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.opaque,

      onPointerDown: (PointerDownEvent details) {

        mKeyboardController.addKeyStrokeData(details);
      },
      onPointerUp: (PointerUpEvent details) {
        mKeyboardController.addKeyStrokeDataPointerUp(details);
      },
      child: mWidget,
    );
  }
}

class ClearButton extends StatelessWidget {
  const ClearButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    // return WithPointerEvent(
    //     mWidget: GestureDetector(
      // onDoubleTap: () {
      //   print("doublee tap");
      // },
      onTap: () {
        resetKeyboard();
        mKeyboardController.clearLetter();

      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xff484C4F),
            borderRadius: BorderRadius.all(Radius.circular(6.w))),
        height: 41.w,
        margin: EdgeInsets.all((2.5).w),
        child: const Center(
            child: Icon(
          Icons.backspace,
          color: Colors.white,
        )),
      ),
    );
  }


}

class KeyRow3 extends StatelessWidget {
  final String letterString;

  const KeyRow3({super.key, required this.letterString});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(child: CapsButton()),
        Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...getListOfKeys(letterString)],
        ),
        const Flexible(child: ClearButton())
      ],
    );
  }
}

getListOfKeys(String s) {
  var res = [];
  for (var i = 0; i < s.length; i++) {
    res.add(MKey(letter: s[i]));
  }
  return res;
}

var test =
TextStyle(
  fontSize: 20.w, color: Colors.white,
  // fontWeight: FontWeight.w300
  // decorationColor: Colors.white
);

class MKey extends StatelessWidget {
  final String letter;

  const MKey({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return WithPointerEvent(
      mWidget: GestureDetector(
        onTap: () {
          mKeyboardController.addLetter(letter);
          print(letter);
        }, // onDoubleTap: () {
        //   print("double tap");
        // }, //use only on shift
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xff484C4F),
              // borderRadius: BorderRadius.all(Radius.circular(6.w))
    ),
          width: 31.w,
          height: 41.w,
          margin: EdgeInsets.all((2.5).w),
          child: Center(
              child: Text(
            letter,
            style: TextStyle(
              fontSize: 20.w, color: Colors.white,
              // fontWeight: FontWeight.w300
              // decorationColor: Colors.white
            ),
          )),
        ),
      ),
    );
  }
}
