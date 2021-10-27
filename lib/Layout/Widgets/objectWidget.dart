import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:test_data_flutter/Domain/Models/object.dart";
import 'package:test_data_flutter/Layout/Screens/fileScreen.dart';
import 'package:test_data_flutter/Layout/Tools/Functions/unitConverter.dart';
import 'package:test_data_flutter/Layout/Tools/Providers/fileOperationsProvider.dart';
import 'package:test_data_flutter/constants.dart';

class ObjectWidget extends StatelessWidget {
  const ObjectWidget();

  @override
  Widget build(BuildContext context) {
    var listner = Provider.of<FileProvider>(context);
    String image = listner.object.fileExtension.split("/")[1].toUpperCase();
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FileScreen(object: listner.object))),
            child: ListTile(
              leading: (image == "PLAIN") ? Icon(Icons.folder) : Image.asset("Assets/Images/${image}.png", width: 25, height: 25),
              title: Text(listner.object.opjectName),
              subtitle: Consumer<FileProvider>(
                builder: (BuildContext context, listner, Widget child) => Row(children: [
                  (listner.inProgress)
                      ? Expanded(
                          child: LinearProgressIndicator(
                            value: listner.runSize,
                          ),
                        )
                      : Text(
                          "${listner.object.bucket},",
                          overflow: TextOverflow.ellipsis,
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(sizeConverter(listner.object.size)),
                  ),
                ]),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.download),
          onPressed: () => listner.start(FileOperation.Download),
        ),
      ],
    );
  }
}
