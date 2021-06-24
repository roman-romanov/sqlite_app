import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqlite_app/data/db.dart';
import 'package:sqlite_app/model/grocery.dart';

class Home extends StatefulWidget {
  final String? title;
  const Home({Key? key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? selectedID;
  TextEditingController? textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: TextField(controller: textController),
      ),
      body: Center(
        child: FutureBuilder<List<Grocery>>(
          future: DB.instance.getGroceries(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Grocery>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading...'));
            }
            return snapshot.data!.isEmpty
                ? Center(child: Text('No groceries in List'))
                : ListView(
                    children: snapshot.data!.map((grocery) {
                    return Center(
                        child: Card(
                      color: selectedID == grocery.id
                          ? Colors.white70
                          : Colors.white,
                      child: ListTile(
                        title: Text(grocery.name!),
                        onTap: () {
                          setState(() {
                            if (selectedID == null) {
                              textController!.text = grocery.name!;
                              selectedID = grocery.id;
                            } else {
                              textController!.text = '';
                              selectedID = null;
                            }
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            DB.instance.remove(grocery.id!);
                          });
                        },
                      ),
                    ));
                  }).toList());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DB.instance.add(Grocery(name: textController!.text));
          selectedID != null
              ? await DB.instance.update(
                  Grocery(
                    id: selectedID,
                    name: textController!.text,
                  ),
                )
              : setState(() {
                  textController!.clear();
                  selectedID = null;
                });
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
