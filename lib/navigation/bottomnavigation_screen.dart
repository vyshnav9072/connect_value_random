import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color.dart';
import '../screens/expence_page/expence_page.dart';
import '../screens/followingleads_page/followingleadspage.dart';
import '../screens/home_page/homepage.dart';
import '../screens/leads_page/leadspage.dart';
import '../screens/profile_page/profilepage.dart';




class BottomTabsScreen extends StatefulWidget {
  const BottomTabsScreen({Key? key}) : super(key: key);

  @override
  State<BottomTabsScreen> createState() => _BottomTabsScreenState();
}

class _BottomTabsScreenState extends State<BottomTabsScreen> {
  int _selectedPageIndex = 0;

  void callback(){
    print("callback");
  }

  final List<Map<String, Object>> _pages = [
    {'page': home(), 'title': 'Dashboard'},
    {'page': expencepage(), 'title': 'Expense'},
    {'page': leadpage(), 'title': 'Addtask'},
    {'page': followingleads(), 'title': 'Tickets'},
    {'page': profilepage(), 'title': 'Profile'},
  ];
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Map<String, Object> get currentPage {
    return _pages[_selectedPageIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage['page'] as Widget,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: bottomtabbg,
            onTap: _selectPage,
            currentIndex: _selectedPageIndex,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.grey,
            unselectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/homedash.svg",
                  color: (_selectedPageIndex == 0)
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                label: 'Dashboard'
              ),

              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/expance.svg",
                  color: (_selectedPageIndex == 1)
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                label: 'Expense',
              ),

              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/leads1.svg",
                    color: (_selectedPageIndex == 2)
                        ? Theme.of(context).colorScheme.primary
                        : null,
                ),
                label: 'Leads',
              ),

              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/followingleads.svg",
                  color: (_selectedPageIndex == 3)
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                label: 'Following',
              ),

              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/profile.svg",
                  color: (_selectedPageIndex == 4)
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );

  }
}

