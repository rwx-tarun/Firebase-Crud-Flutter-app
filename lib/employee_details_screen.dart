import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/add_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  const EmployeeDetailsScreen({Key? key}) : super(key: key);

  @override
  _EmployeeDetailsScreenState createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  final Stream<QuerySnapshot> employeeStream =
      FirebaseFirestore.instance.collection("employee").snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: employeeStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("some error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List data = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {});
          return Scaffold(
            appBar: AppBar(
              title: const Text("EMPLOYEE DETAILS"),
              actions: [
                InkWell(
                  child: IconButton(
                    iconSize: 100,
                    icon: const Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      Get.to(AddEmployeeScreen());
                    },
                  ),
                )
              ],
            ),
            body: Text("hel"),
          );
        });
  }
}
