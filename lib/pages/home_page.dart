import 'package:flutter/material.dart';
import 'package:todo_app_flutter/utils/dialog_box.dart';
import 'package:todo_app_flutter/utils/todo_tile.dart';

class ToDoItem {
  String name;
  bool isCompleted;

  ToDoItem({required this.name, this.isCompleted = false});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  List<ToDoItem> toDoList = [
    ToDoItem(name: "make tutorial"),
    ToDoItem(name: "Do Exercise", isCompleted: false),
  ];

  void checkboxChanged(bool? value, int index) {
    setState(() {
      toDoList[index].isCompleted = !toDoList[index].isCompleted;
    });
  }

  void saveNewTask() {
    setState(() {
      toDoList.add(
        ToDoItem(
          name: _controller.text,
          isCompleted: false,
        ),
      );
      _controller.clear();
    });

    Navigator.of(context).pop();
  }

  void deleteTask(ToDoItem value) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Task"),
            content: const Text("Are you sure?"),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    toDoList.remove(value);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Yes",
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "No",
                ),
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () {
              _controller.clear();
              Navigator.of(context).pop();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text("To Do"),
        elevation: 0,
        backgroundColor: Colors.yellow[500],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          final task = toDoList[index];
          return GestureDetector(
            onLongPress: () => deleteTask(task),
            child: TodoTile(
              taskName: task.name,
              taskCompleted: task.isCompleted,
              onChanged: (value) => checkboxChanged(value, index),
            ),
          );
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(items: []),
    );
  }
}
