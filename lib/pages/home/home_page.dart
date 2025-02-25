import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/cart/cart_history_page.dart';
import 'package:food_delivery/pages/home/page_food_body.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  late PersistentTabController _controller;

  List pages = [
    PageFoodBody(),
    Container(child: Center(child: Text('next page')),),
    CartHistoryPage(),
    Container(child: Center(child: Text('next page page page')),),
  ];

  void onTapNav(int selectedIndex){
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }

  void initState(){
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: pages[_selectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       onTap: onTapNav,
  //       selectedItemColor: Colors.black,
  //       unselectedItemColor: Colors.grey,
  //       showSelectedLabels: true,
  //       showUnselectedLabels: false,
  //       currentIndex: _selectedIndex,
  //       items: [
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.home),
  //             label: "Home",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.archive),
  //           label: "History",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.shopping_cart_outlined),
  //           label: "Cart",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.person),
  //           label: "Profile",
  //         ),
  //       ],
  //     ),
  //   );
  // }

  List<Widget> _buildScreens() {
    return [
      PageFoodBody(),
      Container(child: Center(child: Text('next page')),),
      CartHistoryPage(),
      Container(child: Center(child: Text('next page page page')),),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.archive_outlined),
        title: ("History"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart_outlined),
        title: ("Cart"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_outline),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
