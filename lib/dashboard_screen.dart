import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/Services/auth.dart';
import 'package:firebase_crud/Utils/UiUtils.dart';
import 'package:firebase_crud/databasemanager/database_manage.dart';
import 'package:firebase_crud/main.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthenticationServices _auth = AuthenticationServices();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();

  List dataList = [];
  String uid = "";

  @override
  void initState() {
    fetchUserID();
    fetchData();
    super.initState();
  }

  fetchUserID() async {
    var getUserId = await FirebaseAuth.instance.currentUser!;
    setState(() {
      uid = getUserId.uid;
    });
  }

  fetchData() async {
    dynamic response = await DataBaseManager().getUserData();
    print("         hello");
    print(response);
    if (response == null) {
      UiUtils.showErrorAlert(message: "Unable to Retrieve Data");
    } else {
      setState(() {
        dataList = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(
            onPressed: () {
              DialogueBox(context);
            },
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await _auth.signOut().then((value) => LoginScreen());
              Navigator.pop(context);
            },
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, idx) {
              return Card(
                child: ListTile(
                  title: Text(dataList[idx]["name"]),
                  subtitle: Text(dataList[idx]['gender']),
                  leading: CircleAvatar(
                    child: Image(
                      image: AssetImage(
                          'assets/profile-icon-design-free-vector.jpeg'),
                    ),
                  ),
                  trailing: Text(dataList[idx]['salary'].toString()),
                ),
              );
            }),
      ),
    );
  }

  Future DialogueBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit Details"),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                  TextField(
                    controller: _genderController,
                    decoration: const InputDecoration(
                      hintText: "Gender",
                    ),
                  ),
                  TextField(
                    controller: _salaryController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  submitAction(_nameController.text, _genderController.text,
                      uid, int.parse(_salaryController.text));
                  Navigator.pop(context);
                },
                child: Text("SUBMIT"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("CANCEL"),
              )
            ],
          );
        });
  }

  void submitAction(
      String name, String gender, String userid, int salary) async {
    await DataBaseManager().updateData(name, gender, salary, userid);
    await fetchData();
    _nameController.clear();
    _genderController.clear();
    _salaryController.clear();
  }
}
