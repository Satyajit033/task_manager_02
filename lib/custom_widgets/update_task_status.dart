
import 'package:flutter/material.dart';
import 'package:task_manager_2/data/models/network_response.dart';
import 'package:task_manager_2/data/models/task_list_model.dart';
import 'package:task_manager_2/data/services/network_caller.dart';
import 'package:task_manager_2/data/utils/urls.dart';


class UpdateTaskStatusSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskStatusSheet(
      {super.key, required this.task, required this.onUpdate});

  @override
  State<UpdateTaskStatusSheet> createState() => _UpdateTaskStatusSheetState();
}

class _UpdateTaskStatusSheetState extends State<UpdateTaskStatusSheet> {
  List<String> taskStatusList = ['New', 'Progress', 'Canceled', 'Completed'];
  late String _selectedTask;
  bool updateTaskInProgress = false;

  @override
  void initState() {
    _selectedTask = widget.task.status!.toLowerCase();
    super.initState();
  }

  Future<void> updateTask(String taskId, String newStatus) async {
    updateTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.updateTask(taskId, newStatus));
    updateTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      widget.onUpdate();
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Update task status has been failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.all(16), child:  Text(
            "Update Status",
            style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400,),
          ),),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: taskStatusList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _selectedTask = taskStatusList[index];
                      setState(() {});
                    },
                    title: Text(taskStatusList[index].toUpperCase()),
                    trailing: _selectedTask == taskStatusList[index]
                        ? const Icon(Icons.check,color: Colors.green,)
                        : null,
                  );

                }),
          ),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Visibility(
                  visible: updateTaskInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(color: Colors.green,),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        updateTask(widget.task.sId!, _selectedTask);

                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const Text("Update",style: TextStyle(color: Colors.white),),
                    ),
                  ),))
        ],
      ),
    );
  }
}
