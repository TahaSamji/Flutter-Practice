import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Products.dart';

import 'package:flutter_application_1/models/User.dart';
import 'package:http/http.dart' as http;

class MyProducts extends StatefulWidget {
  const MyProducts({super.key});

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  Future<List<Products>> fetchAllPosts() async {
    final res = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (res.statusCode == 200) {
      var jsonResponse = jsonDecode(res.body);
      List products = jsonResponse['products'];

      return products.map((post) => Products.fromJson(post)).toList();
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
                                  ListTile(
                                    title: Text(snap.data![index].title),
                                    leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            snap.data![index].images[0])),
                                    subtitle: Wrap(
                                        spacing:
                                            8.0, // Horizontal space between chips
                                        runSpacing:
                                            4.0, // Vertical space between lines
                                        children: snap.data![index].tags
                                            .map<Widget>((tag) {
                                          return Text(tag);
                                        }).toList()),
                                  ),
                                  Text(snap.data![index].reviews[0].comment)
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
