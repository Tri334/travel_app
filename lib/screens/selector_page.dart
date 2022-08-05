import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/bloc/bloc_filter_data/filter_data_bloc.dart';
import 'package:travel_app/bloc/bloc_get_favorite/favorite_get_bloc.dart';
import 'package:travel_app/models/style_color.dart';
import 'package:travel_app/models/travel_icons_icons.dart';
import 'package:travel_app/screens/explore/explore_page.dart';
import 'package:travel_app/screens/favorite/favorite_page.dart';
import 'package:travel_app/screens/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class PageSelector extends StatefulWidget {
  PageSelector({Key? key, this.routedIndex = 0}) : super(key: key);
  static String routeName = '/selectorpage';
  int routedIndex;
  @override
  State<PageSelector> createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  static final List<Widget> _opsiWidget = [
    const HomePage(),
    ExplorePage(),
    const Center(child: Text('Notification')),
    const FavoritePage(),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      context.read<FilterDataBloc>().add(const EventFilterBy('-'));
    }
    setState((() {
      widget.routedIndex = index;
    }));
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(widget.routedIndex.toString());
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: _opsiWidget.elementAt(widget.routedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  TravelIcons.home,
                  size: 15.sp,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  TravelIcons.explore,
                  size: 15.sp,
                ),
                label: 'Explore'),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  TravelIcons.notification,
                  size: 15.sp,
                ),
                label: 'Notification'),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  TravelIcons.favorite,
                  size: 15.sp,
                ),
                label: 'Favorite'),
          ],
          elevation: 20,
          currentIndex: widget.routedIndex,
          unselectedItemColor: const Color(0xffABABAB),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: styleColor.style,
          onTap: _onItemTapped,
        ),
      );
    });
  }
}
