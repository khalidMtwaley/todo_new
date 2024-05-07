

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/screens/edit_task_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../app_theme.dart';
import '../providers/user_provider.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;
  late Widget isDoneWidget;
  late Color color;
  TaskItem(this.task);
  @override
  Widget build(BuildContext context) {
    final userProvider =Provider.of<UserProvider>(context);
    if(task.isDone){
      isDoneWidget=Text(
        AppLocalizations.of(context)!.done,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
        color: AppTheme.green,
        fontSize: 22,
      ),);
      color=AppTheme.green;
    }else{
      isDoneWidget= Container(
        height: 34,
        width: 69,
        decoration: BoxDecoration(
            color:AppTheme.lightBlue,
            borderRadius: BorderRadius.circular(10)
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 38,
        ),
      );
      color=AppTheme.lightBlue;
    }

    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(
            EditTaskScreen.routeName,
          arguments: task,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Slidable(
          key: UniqueKey(),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children:  [
              SlidableAction(
                onPressed:(BuildContext ctx){
                  FirebaseUtils.deleteTask(task.id,userProvider.user!.userId).then( (value){
                    Provider.of<TasksProvider>(context,listen: false).getTasks(userProvider.user!.userId);
                      }).catchError((_){
                    Fluttertoast.showToast(
                        msg: "OPS! something went wrong.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  });
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!.delete,
              ),
            ],
          ),
          child:   Container(
            width: double.infinity,
            height: 115,
            padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20
            ),
            decoration: BoxDecoration(
                color:Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(10)),
            ),
            child: Row(
              children: [
                Container(
                  height: double.infinity,
                  width: 4,
                  color: color,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title,
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: color
                      ),
                    ),
                    Text(task.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: (){
                    FirebaseUtils.editTaskSituation(task.id,userProvider.user!.userId).then(
                            (_){
                          Provider.of<TasksProvider>(context,listen: false).getTasks(userProvider.user!.userId);
                        }
                    ).catchError(
                        (_){
                          Fluttertoast.showToast(
                              msg: "OPS! something went wrong.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                    );
                  },
                  child: isDoneWidget,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

