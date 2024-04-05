import 'package:flutter/material.dart';
import 'package:gigimu/presentation/screens/myBookingPage.dart';

import 'package:gigimu/presentation/screens/profilPage.dart';

import 'listDokterPage.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black26,
                // You can load the user's photo here if available
              ),
              child: Icon(
                Icons.add,
              ),
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_rounded),
            label: 'MyBooks',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return ProfilPage();
      case 1:
        return ListDokterPage();
      case 2:
        return MyBookingPage();
      default:
        return Container();
    }
  }

  Widget _buildSettingsPage() {
    return Center(
      child: Text('Settings Page'),
    );
  }
}
