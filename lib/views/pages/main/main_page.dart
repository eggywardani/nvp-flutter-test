import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nvp_test/services/notification_service.dart';
import 'package:nvp_test/theme/app_color.dart';
import 'package:nvp_test/views/pages/account/account_page.dart';
import 'package:nvp_test/views/pages/home/home_page.dart';

class MainPage extends StatefulWidget {
  final int currentIndex;

  const MainPage({super.key, this.currentIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;

  List<Widget> _screens = [];

  void selectScreen(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    pageIndex = widget.currentIndex;
    _screens = [const HomePage(), const AccountPage()];
    NotificationService().requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    // Define items inside the build method to rebuild with updated translations
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.home),
          label: AppLocalizations.of(context)?.home ?? '',
          activeIcon: const Icon(CupertinoIcons.house_fill)),
      BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.person),
          label: AppLocalizations.of(context)?.account ?? '',
          activeIcon: const Icon(CupertinoIcons.person_fill)),
    ];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: pageIndex,
          children: _screens,
        ),
        extendBody: true,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: const Border(
                  top: BorderSide(color: Colors.grey, width: 1.0))),
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.grey,
            items: items,
            elevation: 0,
            currentIndex: pageIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: (value) {
              selectScreen(value);
            },
          ),
        ));
  }
}
