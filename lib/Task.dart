class Task{
  int ID;
  String title;
  String description;
  DateTime date;
  bool isDone;
  Task({this.title, this.description, this.date, this.isDone});
  Map <String, dynamic> toMap(){
    final map = Map <String ,dynamic>();
    if (ID != null){
      map['id'] = ID;
    }
    map['title'] = title;
    map['date'] = date;
    map['idDone'] = isDone;
    return map;
  }
}