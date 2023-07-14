class ToDo {
  String? id;
  String todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Meet math lecture', isDone: true),
      ToDo(id: '02', todoText: 'Chech mails', isDone: true),
      ToDo(id: '03', todoText: 'Work on group project'),
      ToDo(id: '04', todoText: 'Statistics Assignment'),
      ToDo(id: '05', todoText: 'Designing a flyer'),
      ToDo(id: '06', todoText: 'Shopping'),


    ];
  }
}