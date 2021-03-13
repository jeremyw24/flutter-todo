import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/services/database.dart';
import 'package:todo/widgets/app_bar.dart';
import 'package:todo/helpers/date_time_helper.dart';

class Home extends StatefulWidget {
  final String username;
  final String userEmail;
  final String userId;
  Home({this.username, this.userEmail, this.userId});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream taskStream;
  String date;

  TextEditingController taskEditingController = new TextEditingController();

  @override
  void initState() {
    var now = DateTime.now();
    date =
        "${HelpersFunction.getWeekDay(now.weekday)} ${HelpersFunction.getMonth(now.month)} ${now.day}";

    DatabaseServices().getTasks(widget.userId).then((val) {
      taskStream = val;
      setState(() {});
    });

    super.initState();
  }

  Widget taskList() {
    return new StreamBuilder(
      stream: taskStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(top: 16),
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TaskTile(
                    snapshot.data.docs[index].data()['isCompleted'],
                    snapshot.data.docs[index].data()['task'],
                    snapshot.data.docs[index].id,
                    widget.userId,
                  );
                })
            : Container(
                padding: EdgeInsets.all(20),
                child: Text("No Tasks - Add a task to get started..."),
              );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets().mainAppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          width: 600,
          child: Column(
            children: [
              Text("My Day",
                  style: TextStyle(
                    fontSize: 18,
                  )),
              Text("$date"),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: taskEditingController,
                      decoration: InputDecoration(hintText: "Add a Task"),
                      onChanged: (val) {
                        //taskEditingController.text = val;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  taskEditingController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            Map<String, dynamic> taskMap = {
                              "task": taskEditingController.text,
                              "isCompleted": false
                            };
                            DatabaseServices()
                                .createTask(widget.userId, taskMap);
                            taskEditingController.text = "";
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              child: Text("ADD")))
                      : Container()
                ],
              ),
              taskList()
            ],
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatefulWidget {
  final bool isCompleted;
  final String task;
  final String id;
  final String userId;

  TaskTile(this.isCompleted, this.task, this.id, this.userId);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Map<String, dynamic> taskMap = {
                "task": widget.task,
                "isCompleted": !widget.isCompleted
              };
              DatabaseServices().updateTask(widget.userId, taskMap, widget.id);
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              child: widget.isCompleted
                  ? Icon(Icons.check, color: Colors.green)
                  : Container(),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            widget.task,
            style: TextStyle(
                color: widget.isCompleted
                    ? Colors.black87
                    : Colors.black87.withOpacity(0.7),
                fontSize: 17,
                decoration: widget.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              DatabaseServices().deleteTask(widget.userId, widget.id);
            },
            child: Icon(
              Icons.close,
              size: 13,
              color: Colors.black87.withOpacity(0.7),
            ),
          )
        ],
      ),
    );
  }
}
