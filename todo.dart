import 'package:flutter/material.dart';

class Todo {
  String name;
  bool isChecked;

  Todo({required this.name, this.isChecked = false});
}


class TodoTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback onChanged;
  final VoidCallback onDelete;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: Checkbox(
          activeColor: Colors.blue,
          value: todo.isChecked,
          onChanged: (value) => onChanged(),
        ),
        title: Text(
          todo.name,
          style: TextStyle(
            decoration: todo.isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.blue),
          onPressed: onDelete,
        ),
      ),
    );
  }
}