import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/widgets/my_elevated_button.dart';
import 'package:todo_app/widgets/myTextFormField.dart';
import 'package:todo_app/widgets/select_date.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/user_provider.dart';


class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet({super.key});

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  DateTime selectedDate = DateTime.now();
  final  taskNameController=TextEditingController();
  final taskDescController=TextEditingController();
  final dateFormat = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    final userProvider =Provider.of<UserProvider>(context);
    return Padding(
      padding:  EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.addNewTask,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              MyTextFormField(
                  controller: taskNameController,
                  labelText: AppLocalizations.of(context)!.enterTaskTitle,
              ),
              MyTextFormField(
                  controller: taskDescController,
                  labelText: AppLocalizations.of(context)!.addDescription,
                maxLines: 6,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  AppLocalizations.of(context)!.selectDate,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              SelectDate(
                  onTab: () async {
                final selected = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: now,
                  lastDate: now.add(
                    const Duration(days: 365),
                  ),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                );
                selected != null ? selectedDate = selected : null;
                setState(() {});
              },
                text: dateFormat.format(selectedDate),
              ),
              MyElevatedButton(
                  label: AppLocalizations.of(context)!.addTask,
                  margin: const EdgeInsets.symmetric(
                    horizontal:50,
                    vertical: 20
                  ),
                  onPressed: () {
                    FirebaseUtils.addTaskToFireBase(
                      TaskModel(
                      title: taskNameController.text,
                      description: taskDescController.text,
                      dateTime: selectedDate,
                    ),
                        userProvider.user!.userId
                    ).then(
                            (value) {
                          Provider.of<TasksProvider>(context,listen: false).getTasks(userProvider.user!.userId);
                          Navigator.of(context).pop(context);
                        }
                    ).catchError((_){
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
