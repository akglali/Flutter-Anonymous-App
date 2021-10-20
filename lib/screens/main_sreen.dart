import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:responsiv_login_page_flutter/screens/home_screen.dart';
import 'package:responsiv_login_page_flutter/screens/post_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int tabIndex = 0;

  List<Widget> bottomNavBar = [
    HomeScreen(),
    PostScreen(),
    LogOutScreen(),
  ];

  List<PersistentBottomNavBarItem> _navbarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(initialRoute: '/'),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add_box_rounded,color: Colors.black,),
        title: ("Add Post"),
        iconSize: 30,
        activeColorPrimary: Colors.redAccent,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(initialRoute: '/'),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.logout),
        title: ("LogOut"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(initialRoute: '/'),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller = PersistentTabController();
    return Scaffold(
        body:Container(
          child:  buildPersistentBottomNavbar(context, _controller),
        )
    );
  }

  PersistentTabView buildPersistentBottomNavbar(BuildContext context,
      PersistentTabController controller) {
    return PersistentTabView(context,
        controller: controller,
        screens: bottomNavBar,
        items: _navbarItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset:
        true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows:
        true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Color(0xFF8ECAE6),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),

        navBarStyle:
        NavBarStyle.style17 // Choose the nav bar style with this property.
    );
  }
}






class LogOutScreen extends StatelessWidget {
  const LogOutScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This is the Exit Page"),
      ],
    );
  }
}
