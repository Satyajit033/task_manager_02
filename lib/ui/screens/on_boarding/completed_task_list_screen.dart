import 'package:flutter/material.dart';
import 'package:task_manager_2/custom_widgets/app_bar.dart';
import 'package:task_manager_2/custom_widgets/screen_background.dart';
import 'package:task_manager_2/custom_widgets/summary_card.dart';
import 'package:task_manager_2/custom_widgets/task_list_tile.dart';
import 'package:task_manager_2/custom_widgets/update_task_status.dart';
import 'package:task_manager_2/data/models/network_response.dart';
import 'package:task_manager_2/data/models/summary_count_model.dart';
import 'package:task_manager_2/data/models/task_list_model.dart';
import 'package:task_manager_2/data/services/network_caller.dart';
import 'package:task_manager_2/data/utils/urls.dart';
import 'package:task_manager_2/ui/screens/others/add_new_task_screen.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskListScreen> createState() => _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {


  bool isLoading = false;
  TaskListModel _taskListModel = TaskListModel();
  SummaryCountModel _summaryCountModel = SummaryCountModel();

  Future<void> getCountSummary() async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('get new task data failed')));
      }
    }
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNewTasks() async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.newTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('New task data get failed')));
      }
    }
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getCompletedTasks() async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.completedTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Completed tasks get failed')));
      }
    }
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Deletion of task has been failed')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCompletedTasks();
      getCountSummary();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            UserProfileAppBar(),
            isLoading
                ? LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.green))
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _summaryCountModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return SummaryCard(
                        number: _summaryCountModel.data![index].sum??0,
                        title:_summaryCountModel.data![index].sId??'Total'
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 4,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.green)),
              )
                  :  ListView.separated(
                itemCount: _taskListModel.data?.length??0,
                itemBuilder: (context, index) {
                  return TaskListTile(
                    data: _taskListModel.data![index],
                    onDeleteTap: () {deleteTask(_taskListModel.data![index].sId!);},
                    onEditTap: () {
                      showStatusUpdateBottomSheet(_taskListModel.data![index]);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 4,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        shape: CircleBorder(),
        elevation: 10,
        child: Icon(Icons.add,color: Colors.white,size: 30,),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen()));
        },
      ),
    );

  }
  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(task: task, onUpdate: () {
          getNewTasks();
        });
      },
    );
  }
}
