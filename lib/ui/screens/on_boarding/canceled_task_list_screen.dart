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

class CanceledTaskListScreen extends StatefulWidget {
  const CanceledTaskListScreen({super.key});

  @override
  State<CanceledTaskListScreen> createState() => _CanceledTaskListScreenState();
}

class _CanceledTaskListScreenState extends State<CanceledTaskListScreen> {

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
  Future<void> getCanceledTasks() async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.canceledTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Canceled tasks get failed')));
      }
    }
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }


  DeleteItem(taskId)async{
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Delete!",style: TextStyle(color: Colors.blue)),
            content: const Text("once delete,you can not get it back",style:TextStyle(color: Colors.grey)),
            actions: [
              ElevatedButton(onPressed: () async {
                Navigator.pop(context);
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
              }, child: const Text("Yes",style:TextStyle(color: Colors.red))),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text("No",style:TextStyle(color: Colors.green)))
            ],
          );
        }
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCanceledTasks();
      getCountSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileAppBar(),
            isLoading
                ? const LinearProgressIndicator(
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
                itemCount:  _taskListModel.data?.length ?? 0,
                itemBuilder: (context, index) {
                   return TaskListTile(
                         data: _taskListModel.data![index],
                         onDeleteTap: () {DeleteItem(_taskListModel.data![index].sId!);},
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
        shape: const CircleBorder(),
        elevation: 10,
        child: const Icon(Icons.add,color: Colors.white,size: 30,),
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
