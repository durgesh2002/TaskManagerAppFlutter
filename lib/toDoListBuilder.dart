// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ToDoListBuilder extends StatefulWidget {
  List<String> toDoList;
  void Function() updateToDoList;
  ToDoListBuilder({super.key,required this.toDoList,required this.updateToDoList});

  @override
  State<ToDoListBuilder> createState() => _ToDoListBuilderState();
}

class _ToDoListBuilderState extends State<ToDoListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: widget.toDoList.length,itemBuilder: (BuildContext context,int index){
      return ListTile(
        trailing: IconButton(onPressed: (){
          setState(() {
            widget.toDoList.removeAt(index);
            widget.updateToDoList();
          });

        }, icon: const Icon(Icons.delete_outline)),
        leading: const  Icon(Icons.event_note),
        title: Text(widget.toDoList[index]),

      );
    });
  }
}
