import 'package:flutter/material.dart';
import 'package:task_manager_2/data/models/task_list_model.dart';

class TaskListTile extends StatelessWidget {

  final VoidCallback onDeleteTap, onEditTap;

  const TaskListTile({
    super.key, required this.data, required this.onDeleteTap, required this.onEditTap,
  });


  final TaskData data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:  Text(data.title ?? 'unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.description ?? ''),
          Text(data.createdDate ?? ''),
          Row(
            children: [
               Chip(
                label: Text(
                  data.status ?? 'New',
                  style: const TextStyle(color: Colors.white),),
                    backgroundColor: Colors.blue,
                  ),
              const Spacer(),
              IconButton(
                  onPressed:onEditTap,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: onDeleteTap,
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red.shade300,
                  )),
            ],
          )
        ],
      ),
    );
  }
}