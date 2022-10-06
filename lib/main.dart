import 'package:flutter/material.dart';
import 'package:flutter_template/tab1.dart';
import 'package:flutter_template/tab2.dart';
import 'package:flutter_template/tab3.dart';
import 'package:flutter_template/tab4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Template',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Template'),
    );
  }
}

class Tab {
  IconData icon;
  IconData activeIcon;
  String? label;
  Widget widget;

  Tab(this.icon, this.activeIcon, this.label, this.widget);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Tab> _tabs = <Tab>[
    Tab(Icons.home_outlined, Icons.home, '탭1', Tab1Page()),
    Tab(Icons.business_outlined, Icons.business, '탭2', Tab2Page()),
    Tab(Icons.school_outlined, Icons.school, '탭3', Tab3Page()),
    Tab(Icons.settings_outlined, Icons.settings, '탭4', Tab4Page())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: _tabs.elementAt(_selectedIndex).widget
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _tabs.map((tab) => BottomNavigationBarItem(
            icon: Icon(tab.icon),
            activeIcon: Icon(tab.activeIcon),
            label: tab.label
        )).toList(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        showSelectedLabels: true,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (int index) { setState(() { _selectedIndex = index; }); },
      )
    );
  }
}
