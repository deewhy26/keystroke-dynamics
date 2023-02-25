import 'dart:collection';

class KDData {
  var key = "";
  var keyPressTimeStamp;
  var keyReleaseTimeStamp;
  var fingerArea;
  var rotationAroundX;
  var rotationAroundY;
  var rotationAroundZ;
  var holdTime;
  var UU;
  var DD;
  var UD;
  var DU;
  var orientation;
  var touchMajor;
  var touchMinor;
  var x;
  var y;


  Map<dynamic, dynamic> toJson() {
    final data = HashMap<String, dynamic>();
    data["key"] = key;
    data["keyPressTimeStamp"] = keyPressTimeStamp;
    data["keyReleaseTimeStamp"] = keyReleaseTimeStamp;
    data["fingerArea"] = fingerArea;
    data["rotationAroundX"] = rotationAroundX;
    data["rotationAroundY"] = rotationAroundY;
    data["holdTime"] = holdTime;
    data["UU"] = UU;
    data["DD"] = DD;
    data["UD"] = UD;
    data["DU"] = DU;
    data["orientation"] = orientation;
    data["touchMajor"] = touchMajor;
    data["touchMinor"] = touchMinor;
    data["x"] = x;
    data["y"] = y;
    return data;
  }
}
