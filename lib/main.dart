import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class ToDo {
  String title;
  String description;

  ToDo(this.title, this.description);
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}
class _ToDoListScreenState extends State<ToDoListScreen> {
  List<ToDo> toDoList = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController editTitleController = TextEditingController();
  final TextEditingController editDescriptionController = TextEditingController();

  void _addTask() {
    String title = titleController.text;
    String description = descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      setState(() {
        toDoList.add(ToDo(title, description));
        titleController.clear();
        descriptionController.clear();
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  void _editTask(BuildContext context, int index) {
    ToDo selectedTask = toDoList[index];
    titleController.text = selectedTask.title;
    descriptionController.text = selectedTask.description;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5),
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: "Add Title",
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Add Description',
                      hintText: "Add Description",
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedTask.title = titleController.text;
                      selectedTask.description = descriptionController.text;
                      Navigator.of(context).pop();
                    });
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(30, 10, 30,10)), // Add padding here
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: Text('ADD'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              size: 30.0,
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [

          Container(
            margin: EdgeInsets.all(5),
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: "Add Title",
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Add Description',
                hintText: 'Add Description',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(

            onPressed: _addTask,
            child: Text(
              'ADD',
              style: TextStyle(fontSize: 20.0),
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(30, 10, 30,10)), // Add padding here
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
          ),


          Expanded(
            child: ListView.separated(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(toDoList[index].title),
                  subtitle: Text(toDoList[index].description),
                  trailing: Icon(Icons.arrow_forward),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(

                          title: Text("Edit or Delete?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () { Navigator.of(context).pop();
                              _editTask(context,index);

                              },
                              child: Text("Edit"),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteTask(index);
                                Navigator.of(context).pop();
                              },
                              child: Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              }, separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 2.0,
                color: Colors.grey,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
              );
            },
            ),
          ),
        ],
      ),
    );
  }
}