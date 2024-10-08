import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/User.dart';
import 'package:http/http.dart' as http;

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({super.key});

  @override
  State<MyJobsPage> createState() => _MyjobsPageState();
}

class _MyjobsPageState extends State<MyJobsPage> {
  Future<List<User>> fetchAllPosts() async {
    final res = await http.get(Uri.parse('https://jsonplaceholder.org/users'));
    if (res.statusCode == 200) {
      List jsonResponse = jsonDecode(res.body);

      return jsonResponse.map((post) => User.fromJson(post)).toList();
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shadowColor: Colors.black,
          surfaceTintColor: Colors.white,
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text(
            "Users",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              color: const Color.fromARGB(255, 90, 1, 105),
              tooltip: 'Notification Icon',
              onPressed: () {},
            )
          ],
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            const DrawerHeader(child: Text("headers")),
            ListTile(
              title: const Text("Item 1"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Item 2"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Item 3"),
              onTap: () {},
            )
          ],
        )),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: FutureBuilder(
              future: fetchAllPosts(),
              builder: (context, snap) {
                if (snap.hasData) {
                  return ListView.builder(
                      itemCount: snap.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  16.0), // Padding added inside the card
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snap.data![index].firstname),
                                  Text(snap.data![index].lastname),
                                  Text(snap.data![index].email),
                                  Text(snap.data![index].street),
                                  Text(snap.data![index].companyname),
                                  Text(snap.data![index].latitude),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else if (snap.hasError) {
                  return const Text("No data");
                }
                return const CircularProgressIndicator();
              }),
        ));
  }
}
