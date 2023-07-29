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
      ToDo(id: '01', todoText: 'Meet math lecture'),
      ToDo(id: '02', todoText: 'Chech mails'),
      ToDo(id: '03', todoText: 'Statistics Assignment', isDone: true),
      ToDo(id: '04', todoText: 'Designing a flyer'),
      ToDo(id: '05', todoText: 'Shopping',isDone: true),


    ];
  }
}