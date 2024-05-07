import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/models/language_model.dart';
import 'package:todo_app/providers/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/screens/auth/login_screen.dart';
import 'package:todo_app/widgets/my_elevated_button.dart';
import '../app_theme.dart';

class SettingTab extends StatefulWidget {
  static const String routeName='setting tab';

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {


  @override
  Widget build(BuildContext context) {
    double screenHeight =MediaQuery.of(context).size.height;
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    final List<LanguageModel> languages=[
       LanguageModel(name: AppLocalizations.of(context)!.english, code: 'en'),
       LanguageModel(name: AppLocalizations.of(context)!.arabic, code: 'ar'),
    ];
    return SizedBox(
        height: screenHeight,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: screenHeight*0.22,
              color: AppTheme.lightBlue,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(height: screenHeight*0.15,),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    height: screenHeight*0.65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         SizedBox(
                          width: double.infinity,
                          child: Text(
                            AppLocalizations.of(context)!.mode,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        DropdownButtonFormField(
                            items: [
                              DropdownMenuItem(
                                value: ThemeMode.dark,
                                child: Text(AppLocalizations.of(context)!.dark),
                              ),
                              DropdownMenuItem(
                                value: ThemeMode.light,
                                child: Text(AppLocalizations.of(context)!.light),
                              ),
                            ],
                            value: settingProvider.appMode,
                            onChanged: (value){
                              settingProvider.changeMode(value as ThemeMode);
                            },
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppTheme.lightBlue,
                            ),
                          isExpanded: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          dropdownColor: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            AppLocalizations.of(context)!.language,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        DropdownButtonFormField(
                            items: [
                              DropdownMenuItem(
                                value: languages[0].code,
                                child: Text(languages[0].name),
                              ),
                              DropdownMenuItem(
                                value: languages[1].code,
                                child: Text(languages[1].name),
                              ),
                            ],
                            value: settingProvider.appLanguage,
                            onChanged: (value){
                              settingProvider.changeLanguage(value as String);
                            },
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppTheme.lightBlue,
                            ),
                          isExpanded: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          dropdownColor: Theme.of(context).primaryColor,
                        ),
                        MyElevatedButton(
                            label: AppLocalizations.of(context)!.logout,
                            onPressed: (){
                              FirebaseUtils.logout();
                              Provider.of<TasksProvider>(context,listen: false).clear();
                              Provider.of<UserProvider>(context,listen: false).user=null;
                              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                            },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

    );
  }
}
