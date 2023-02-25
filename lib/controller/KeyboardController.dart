
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:keyboard2/database/database.dart';
import 'package:keyboard2/model/KDData.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../view/Keyboard.dart';

class KeyboardController extends GetxController {
  final TextEditingController usernameController = TextEditingController();

  var inputField = TextEditingController();
  var isCapsOn = false.obs;
  var isDoubleTapCapsOn = false;
  var isNumOn = false.obs;
  var row1Str = "qwertyuiop";
  var row1StrNum = "1234567890";

  var row2Str = "asdfghjkl";
  var row2StrNum = "`@#%()-_:;";

  var row3Str = "zxcvbnm";
  var row3StrNum = '"' "'" "!?/\\";

  var rotationX = 0.0;
  var rotationY = 0.0;
  var rotationZ = 0.0;
  var start_time = 0;

  List<KDData> singleEntryData = <KDData>[]; //locally
  var sessionData = [];
  var sessionSize = 5;

  void addLetter(String s) {

    inputField.text += s;
    inputField.selection = inputField.selection.copyWith(
      baseOffset: inputField.text.length,
      extentOffset: inputField.text.length,
    );

    if (!isDoubleTapCapsOn) {
      isCapsOn.value = false;
    }
    if (s != "") {
      addToSingleEntry(s);
    }
    else {

      print("bruh");
    }

  }

  void clearUsername() {
    usernameController.clear();
  }

  void oneTapCaps() {
    isCapsOn.value = !isCapsOn.value;
    isDoubleTapCapsOn = false;
    singleEntryData.last.key = "[SHIFT]";
  }

  void oneDoubleTapCaps() {
    isCapsOn.value = !isCapsOn.value;
    isDoubleTapCapsOn = isCapsOn.value;

    singleEntryData.last.key = "[DOUBLE-SHIFT-2/2]";
    singleEntryData[singleEntryData.length - 1 - 1].key = "[DOUBLE-SHIFT-1/2]";
  }

  void clearLetter() {
    // inputField.text = "";
    //error here
    if (singleEntryData.isNotEmpty) {
      singleEntryData.removeLast();
      if (inputField.text != "") {
        inputField.text =
            inputField.text.substring(0, inputField.text.length - 1);
        inputField.selection = inputField.selection.copyWith(
            baseOffset: inputField.text.length,
            extentOffset: inputField.text.length);
      }
      else {
        singleEntryData.clear();
      }
    }

    // singleEntryData.clear();
  }

  void addKeyStrokeData(PointerDownEvent details) {
    var newKDDData = KDData();

    newKDDData.touchMajor = details.radiusMajor;
    newKDDData.touchMinor = details.radiusMinor;
    newKDDData.fingerArea = details.size;
    newKDDData.rotationAroundX = rotationX;
    newKDDData.rotationAroundY = rotationY;
    newKDDData.rotationAroundZ = rotationZ;
    newKDDData.orientation = details.orientation;
    if (singleEntryData.isEmpty) {
        start_time = DateTime.now().microsecondsSinceEpoch;
        newKDDData.keyPressTimeStamp = 0;
    }
    else {
      newKDDData.keyPressTimeStamp = DateTime
          .now()
          .microsecondsSinceEpoch - start_time;
    }
    newKDDData.x = details.position.dx;
    newKDDData.y = details.position.dy;

    singleEntryData.add(newKDDData);

  }

  void addKeyStrokeDataPointerUp(PointerUpEvent details) {
    singleEntryData.last.keyReleaseTimeStamp =
        DateTime.now().microsecondsSinceEpoch - start_time;
  }

  void updateRotation(GyroscopeEvent event) {
    rotationX = event.x;
    rotationY = event.y;
    rotationZ = event.z;
  }

  void addToSingleEntry(String s) {
    singleEntryData.last.key = s;

    print(singleEntryData);
  }

  void numSwitch() {
    if (isNumOn.value) {
      addToSingleEntry("[NUMSWITCH 2/2]");
    } else {
      addToSingleEntry("[NUMSWITCH 1/2]");
    }
    isNumOn.value = !isNumOn.value;

  }

  void addToSession() {
    final copySingleEntryData = [...singleEntryData];
    if (sessionData.length == 5) {
        // mKeyboardController.clearLetter();
        addToDb();

    }
    else {
      // List<KDData> copySingleEntryData = singleEntryData;
      sessionData.add(copySingleEntryData);
      print(sessionData); //has value before reset
      resetSingleEntryData();
      print("after sessionData");
      print(sessionData);
    }
  }

  void resetSingleEntryData() {
    singleEntryData.clear();
    clearLetter();
  }

  void addToDb() {
    print("herer");
    // addToSession();
    var listToAdd = [];
    if (sessionData.isEmpty) {
      return;
    }
    // sessionData[0].holdTime =
    //     sessionData[0].keyReleaseTimeStamp - sessionData[0].keyPressTimeStamp;
    // listToAdd.add(sessionData[0].toJson());

    var i = 0;
    var j = 0;
    final mMap = <String, dynamic>{};
    while ( i < 5 && i < sessionData.length) {
      while (j < sessionData[i].length) {
        if (j == 0) {
          sessionData[i][j].holdTime = sessionData[i][j].keyReleaseTimeStamp -
              sessionData[i][j].keyPressTimeStamp;
        } else {
          sessionData[i][j].DD = sessionData[i][j].keyPressTimeStamp -
              sessionData[i][j - 1].keyPressTimeStamp;
          sessionData[i][j].UU = sessionData[i][j].keyReleaseTimeStamp -
              sessionData[i][j - 1].keyReleaseTimeStamp;
          sessionData[i][j].UD = sessionData[i][j].keyReleaseTimeStamp -
              sessionData[i][j - 1].keyPressTimeStamp;
          sessionData[i][j].DU = sessionData[i][j].keyPressTimeStamp -
              sessionData[i][j - 1].keyReleaseTimeStamp;
          sessionData[i][j].holdTime = sessionData[i][j].keyReleaseTimeStamp -
              sessionData[i][j].keyPressTimeStamp;
        }
        listToAdd.add(sessionData[i][j].toJson());
        j += 1;
      }
      // listToAdd.add(sessionData[i].toJson());
      var deepcpyListtoadd = [...listToAdd];
      mMap[i.toString()] = deepcpyListtoadd;
      listToAdd.clear();

      i++;
      j = 0;
    }
    sessionData.clear();
    var username = usernameController.text;
    clearUsername();
    var db = KDDb();


    db.addKDData({DateTime.now().toString():mMap}, username);
  }

  void clearInput() {
    singleEntryData.clear();
    mKeyboardController.inputField.clear();
  }
}
