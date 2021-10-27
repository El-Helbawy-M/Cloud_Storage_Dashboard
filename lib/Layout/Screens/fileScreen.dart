import 'package:flutter/material.dart';
import 'package:test_data_flutter/Domain/Models/object.dart';
import 'package:test_data_flutter/Layout/Tools/Functions/unitConverter.dart';

class FileScreen extends StatelessWidget {
  const FileScreen({this.object});
  final Object object;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width, height = MediaQuery.of(context).size.height;
    String image = object.fileExtension.split("/")[1].toUpperCase();
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width,
                height: height / 2.5,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset("Assets/Images/${image}.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 18),
                child: Text(object.opjectName.split(".")[0], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListTile(leading: Icon(Icons.line_weight), title: Text(sizeConverter(object.size))),
              ),
              ListTile(leading: Icon(Icons.extension), title: Text(object.fileExtension))
            ],
          ),
        ),
      ),
    );
  }
}
