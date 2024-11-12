import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var nameCon = TextEditingController();
  var nameVal = "No value saved";

  @override
  void initState() {
    super.initState();
    getValue();  // Retrieve saved value during initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameCon,
              decoration: InputDecoration(
                labelText: 'Enter your name',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Save the entered name to SharedPreferences
                var prefs = await SharedPreferences.getInstance();
                prefs.setString("name", nameCon.text.toString());

                // Fetch the updated value
                getValue();
              },
              child: Text('SAVE'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(nameVal),  // Display the saved name or default message
          ],
        ),
      ),
    );
  }

  Future<void> getValue() async {
    var prefs = await SharedPreferences.getInstance();

    // Retrieve the saved name or return default message if null
    var getName = prefs.getString("name");

    setState(() {
      nameVal = getName != null ? getName : "No value saved";
    });
  }
}
