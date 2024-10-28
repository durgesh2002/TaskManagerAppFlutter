
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {

  final void Function({required String addToDo}) changeText;
 const  AddTask({super.key, required this.changeText});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  TextEditingController addToDo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const   Text('Add Task :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
       const  SizedBox(
          height: 20,
        ),
        TextField(
          autofocus: true,
          cursorColor: Colors.white,
          decoration:const  InputDecoration(
            hintText: 'Write your task here....',
            prefixIcon: Icon(Icons.event_note_sharp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          controller: addToDo,
        ),
        const  SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize:const Size(100, 50),
                backgroundColor: Colors.orangeAccent[400]
              ),onPressed: (){
                if(addToDo.text.isNotEmpty){
                  widget.changeText(addToDo:addToDo.text);
                }else{
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title:const  Text('Enter the task'),
                      actions: [TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: const Text('Close',style: TextStyle(color: Colors.orangeAccent),))],

                    );
                  });
                  return;
                }

                addToDo.text ='';
            }, child: const Text('submit',style: TextStyle(color: Colors.white,fontSize: 16),)),
          ],
        )
      ],
    );
  }
}
