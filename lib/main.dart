import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app798564/Task.dart';

List <Task> _todoTasks =[
  Task(
    title: "title1",
    description: "desc",
    isDone: false,
  ),
  Task(
    title: "title2",
    description: "des2",
    isDone: false,
  ),
  Task(
    title: "title3",
    description: "des3",
    isDone: false,
  )
];



void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    brightness: Brightness.light,
  ),
  home: MyApp(),
));
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  int counter = _todoTasks.length;
  @override
  Widget build(BuildContext context) {
    counter = _todoTasks.length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My Task" , style: TextStyle(fontSize: 20),),
            SizedBox(width: 10,),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                    counter.toString(),style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
      body: HomePage(),
    );
  }

}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color color = Colors.white;
  void callBack(){
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: _todoTasks.length,
        itemBuilder: (BuildContext context , int index){
          return TextButton(
            onPressed: (){
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => task(_todoTasks[index])));
              });
            },
            child: Container(

              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.green[700],
                          value: _todoTasks[index].isDone,
                          onChanged: (bool value) {
                            print(value);
                            setState(() {
                              _todoTasks[index].isDone = value;
                            }
                            );
                          }
                      ),
                      SizedBox(width: 12,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_todoTasks[index].title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),),
                          Text(_todoTasks[index].description, style: TextStyle(fontSize: 18, color: Colors.black),),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          _todoTasks.removeAt(index);
                        });
                      }, icon: Icon(Icons.delete, size: 35,color: Colors.black,),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(
            Icons.add,
        ),
        onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (_) => addTask(this)));
          });
        },
      ),
    );
  }

}
class addTask extends StatefulWidget {
  var widget;
  addTask(var widget){
    this.widget = widget;
  }
  @override
  _addTaskState createState() => _addTaskState(widget);
}

// ignore: camel_case_types
class _addTaskState extends State<addTask> {
  var w;
  _addTaskState(var widget){
    this.w = widget;
  }
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  handleDatePicker () async {
    final DateTime date = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2000), lastDate: DateTime(2100));
    if (_date != null && date != _date){
      setState(() {
        _date = date;
      });
      _dateController.text = date.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        shadowColor: Colors.red[900],
        title: Text ("Add Task"),
      ),
      body: SingleChildScrollView(
        child: Form(key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(left: 2.5, right: 2.5),
                child: TextFormField(
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hoverColor: Colors.red,
                    focusColor: Colors.red,
                    filled: true,
                    labelText: "Title",
                    suffixIcon: Icon(Icons.check)
                  ),
                  validator: (input) => input.trim().isEmpty ? 'Please Enter a title' : null,
                  onSaved: (input) => title = input,
                  initialValue: title,
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(left: 2.5, right: 2.5),
                child: TextFormField(
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    labelText: "Description",
                      filled: true,
                      suffixIcon: Icon(Icons.description)
                  ),
                  validator: (input) => input.trim().isEmpty ? 'Please Enter a description' : null,
                  onSaved: (input) => description = input,
                  initialValue: description,
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(left: 2.5, right: 2.5),
                child: TextFormField(
                  controller: _dateController,
                  //onTap: handleDatePicker(),
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    labelText: "Date",
                      filled: true,
                      suffixIcon: Icon(Icons.date_range)
                  ),
                ),
              ),
              SizedBox(height: 100,),
              Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()){
                          _formKey.currentState.save();
                          setState(() {
                            Task td = new Task(title: title, description: description, date: DateTime.now(), isDone: false);
                            _todoTasks.add(td);
                            print(_todoTasks);
                            Navigator.pop(context);
                            this.w.callBack();
                          });
                        }
                      },
                      child:
                      Text("Add",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}


class task extends StatelessWidget {
  Task tasklist;
  task(Task tasklist){
    this.tasklist = tasklist;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(tasklist.title, style: TextStyle(fontSize: 22),),
        actions: [
          Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.green[700],
              value:tasklist.isDone,
              onChanged: (bool value) {
                print(value);
                  tasklist.isDone = value;
              }
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 100,
                width: double.infinity,
                margin: EdgeInsets.only(left: 5, right: 5, top: 3),
                padding: EdgeInsets.all(20),
                child: Center(child: Text(tasklist.title, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),)),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 100,
                width: double.infinity,
                margin: EdgeInsets.only(left: 5, right: 5, top: 3),
                padding: EdgeInsets.all(20),
                child: Center(child: Text(tasklist.description, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 100,
                width: double.infinity,
                margin: EdgeInsets.only(left: 5, right: 5, top: 3),
                padding: EdgeInsets.all(20),
                child: Center(child: Text(tasklist.date.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
      )

      /*Text("Title : " + tasklist.title + "\n" +
          "Description : " + tasklist.description + "\n"
          + "Date : " + tasklist.date.toString(),
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),*/
    );

  }
}

