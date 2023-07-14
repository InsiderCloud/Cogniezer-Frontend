import 'package:cogniezer_app/constants.dart';
import 'package:flutter/material.dart';

import '../todo.dart';

class toDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const toDoItem(
      {
        Key? key,
        required this.todo,
        this.onToDoChanged,
        this.onDeleteItem
      }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20),
          color: Colors.grey[200],
          child: ListTile(
            onTap: () {
              onToDoChanged(todo);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tileColor: Colors.white,
            leading: Icon(
              todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
              color: Colors.blue,
            ),
            title: Text(
              todo.todoText,
              style: TextStyle(
                fontSize: 16,
                color: kPrimaryColorG1,
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: Icon(Icons.delete),
                onPressed: () {
                  onDeleteItem(todo.id);
                },

              ),
            ),
          ),
        ),
      ],
    );
  }
}

