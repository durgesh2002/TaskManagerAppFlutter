import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/addTask.dart';
import 'package:taskmanager/toDoListBuilder.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<String> toDoList = [];


  void changeText ({required String addToDo}){
    if(toDoList.contains(addToDo)){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title:const  Text('Task Already Exists'),
          actions: [TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('Close',style: TextStyle(color: Colors.orangeAccent),))],

        );
      });
      return;
    }
    setState(() {
    toDoList.insert(0, addToDo);
    });
    updateToDoList();
    Navigator.pop(context);
  }

  void updateToDoList() async{
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
// Save an list of strings to 'items' key.
    await prefs.setStringList('toDoList', toDoList);
  }
  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }
  void loadData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      toDoList = (prefs.getStringList('toDoList')??[]).toList();
    });
  }

  void addTaskToList(){
    showModalBottomSheet(context: context, builder: (context){
      return  Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 300,
          width: double.infinity,
          padding: const  EdgeInsets.all(20),
          child:  SingleChildScrollView(
              physics:const  BouncingScrollPhysics(),
              child:  AddTask(changeText:changeText,)),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.purple[400],
          height: 100,
              width: double.infinity,
              child:const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('TaskManager',style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white,fontSize: 22
                  ),),
                  SizedBox(height: 10,)
                ],
              )),
          ]
        ),
      ),
      appBar: AppBar(
        backgroundColor:Colors.purple[400] ,
        elevation: 3,
        centerTitle: true,
        title: const   Text('TaskManager',style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white,fontSize: 22
        ),
            ),
        actions: [
         InkWell(
           onTap:addTaskToList,
           child:const  Padding(
             padding:  EdgeInsets.all(12.0),
             child: Icon (Icons.note_add,
             color: Colors.white,
             size: 30,
             ),
           ),
         ),
        ],
      ),

      body: ToDoListBuilder(toDoList:toDoList,updateToDoList:updateToDoList,)
    );
  }
}
