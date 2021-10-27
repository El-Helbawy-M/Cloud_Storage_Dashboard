import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_data_flutter/Data/Handlers/OpjectsHandler.dart';
import 'package:test_data_flutter/Layout/Tools/Providers/fileOperationsProvider.dart';
import 'package:test_data_flutter/Layout/Widgets/objectWidget.dart';
import "package:test_data_flutter/Domain/Models/object.dart";
import 'package:test_data_flutter/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Object> data;
  @override
  void initState() {
    ObjectHandler("test_data_flutter").getAllObjects().then((value) => setState(() => data = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Consumer<FileProvider>(
          builder: (context, listner, child) => FloatingActionButton.extended(
            label: Text("Add File"),
            icon: Icon(Icons.add),
            onPressed: () {
              listner.start(FileOperation.Upload, "MyFile", "test_data_flutter");
            },
          ),
        ),
        body: Consumer<FileProvider>(
          builder: (context, listner, child) => (data == null || listner.inProgress)
              ? Center(child: CircularProgressIndicator(value: listner.runSize))
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => (data[index].opjectName.contains("/") && !data[index].fileExtension.contains("plain"))
                        ? SizedBox()
                        : ChangeNotifierProvider(
                            create: (context) => FileProvider(data[index]),
                            builder: (context, child) => ObjectWidget(),
                          ),
                  ),
                ),
        ));
  }
}
