import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class KDDb {
  final db = FirebaseFirestore.instance;

  void addKDData(data, user) {
    // final data = <String, dynamic>{data};

    if (user == "") {
      Get.snackbar("Data upload unsuccessful", "Please enter UID");
    }
    else {
      print("here");

      db.collection("data_v1").doc(user).set(data, SetOptions(merge: true));
      {
        print('DocumentSnapshot added with ID: $user');
        Get.snackbar("Data Added Successfully",
            "Session data added to database successfully\nID: $user");
      }
    }
    // var clearUsername = clearUsername();
  }
}
