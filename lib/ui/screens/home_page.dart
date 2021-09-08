import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rd_expanse/ui/screens/pages/add_expense_page/add_expense_page.dart';
import 'package:rd_expanse/ui/screens/pages/all_expenses_page/all_expenses_page.dart';
import 'package:rd_expanse/ui/screens/pages/notes_page/notes_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  DateTime? _currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    final activeColorNavBar = Theme.of(context).primaryColor;
    final inactiveColorNavBar = Theme.of(context).primaryColor.withAlpha(110);
    final middleButtonBgColor = Theme.of(context).primaryColor.withOpacity(0.85);
    final bgColorNavBar = Theme.of(context).cardColor;

    final _tabController = TabController(
      initialIndex: 1,
      length: 3,
      vsync: this,
    );

    Future<bool> _onWillPopScope() {
      DateTime _now = DateTime.now();

      if (_currentBackPressTime == null || _now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
        _currentBackPressTime = _now;

        Fluttertoast.showToast(
          msg: "Press again to exit",
          textColor: Theme.of(context).textTheme.bodyText1!.color,
          backgroundColor: Theme.of(context).backgroundColor,
        );

        return Future.value(false);
      }
      Fluttertoast.cancel();
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: () => _onWillPopScope(),
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: const <Widget>[
            AllExpensesPage(),
            AddExpensePage(),
            NotesPage(),
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          top: -(0.018015883 * MediaQuery.of(context).size.height),
          height: 55.0,
          curve: Curves.bounceInOut,
          color: inactiveColorNavBar,
          controller: _tabController,
          elevation: 3.5,
          onTap: (index) {},
          backgroundColor: bgColorNavBar,
          style: TabStyle.fixedCircle,
          activeColor: activeColorNavBar,
          items: [
            TabItem(
              title: "Expenses",
              icon: SvgPicture.asset(
                'assets/icons/nav_bar/expense.svg',
                color: inactiveColorNavBar,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/nav_bar/expense.svg',
                color: activeColorNavBar,
              ),
            ),
            TabItem(
              icon: CircleAvatar(
                backgroundColor: middleButtonBgColor,
                child: Image.asset('assets/avatars/avatar-64x64-456317.png'),
              ),
            ),
            TabItem(
              title: "Debug",
              icon: SvgPicture.asset(
                'assets/icons/nav_bar/notes.svg',
                color: inactiveColorNavBar,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/nav_bar/notes.svg',
                color: activeColorNavBar,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
