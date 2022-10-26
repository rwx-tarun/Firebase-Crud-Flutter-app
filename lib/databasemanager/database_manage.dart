import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseManager {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('profileInfo');

  Future<void> createUserData(
      String name, String gender, int salary, String uid) async {
    await profileList
        .doc()
        .set({'name': name, 'gender': gender, 'salary': salary});
  }

  Future getUserData() async {
    List dataList = [];
    try {
      await profileList.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          dataList.add(element);
        });
      });
      return dataList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future updateData(String name, String gender, int salary, String uid) async {
    return await profileList.doc(uid).update({
      'name': name,
      'gender': gender,
      'salary': salary,
    });
  }
}
