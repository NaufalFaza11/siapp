import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/pekerjaan_page.dart';

void main() {
  runApp(const SiapKoskuApp());
}

class SiapKoskuApp extends StatelessWidget {
  const SiapKoskuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIAP KOSKU',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    PekerjaanPage(),
    Center(
      child: Text(
        'Riwayat',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding =
        MediaQuery.of(context).viewPadding.bottom;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 430,
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: pages[selectedIndex],
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              bottom: bottomPadding > 24
                  ? bottomPadding
                  : 0,
            ),
            child: NavigationBar(
              selectedIndex: selectedIndex,
              backgroundColor: const Color(0xFFEFF6FF),
              indicatorColor: const Color(0xFFDBEAFE),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Color(0xFF64748B),
                  ),
                  selectedIcon: Icon(
                    Icons.home,
                    color: Color(0xFF2563EB),
                  ),
                  label: 'Beranda',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.assignment_outlined,
                    color: Color(0xFF64748B),
                  ),
                  selectedIcon: Icon(
                    Icons.assignment,
                    color: Color(0xFF2563EB),
                  ),
                  label: 'Pekerjaan',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.history_outlined,
                    color: Color(0xFF64748B),
                  ),
                  selectedIcon: Icon(
                    Icons.history,
                    color: Color(0xFF2563EB),
                  ),
                  label: 'Riwayat',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}