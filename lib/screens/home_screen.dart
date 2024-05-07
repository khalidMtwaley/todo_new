import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/tabs/list_tab.dart';
import 'package:todo_app/tabs/setting_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/widgets/app_bottom_sheet.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName='/';


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs=[
      ListTab(),
     SettingTab(),
  ];

  int currentIndex =0;
  @override
  Widget build(BuildContext context) {
    List<String> tabsName=[
      AppLocalizations.of(context)!.toDoList,
     AppLocalizations.of(context)!.setting,
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: currentIndex ==1? true:false,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsetsDirectional.only(start: 25),
          child: Text(tabsName[currentIndex]),
        ),
      ),
      
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        notchMargin: 10,
        elevation: 0,
        padding: EdgeInsets.zero,
        shape:  const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.menu),
            label:AppLocalizations.of(context)!.list,
            ),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
            label:AppLocalizations.of(context)!.setting,
            ),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context)=> const AppBottomSheet(),
            );
          },
        shape: CircleBorder(
          side: BorderSide(color: AppTheme.white,width: 4)
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[currentIndex],
    );
  }
}
