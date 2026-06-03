import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // 1. أضيفي هذا السطر هنا في الأعلى
import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';

void main() {
  runApp(const MacrosApp());
}

class MacrosApp extends StatelessWidget {
  const MacrosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Macros App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
        // 2. احذفي سطر fontFamily القديم واكتبي هذا البديل للخط العربي:
        textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme),
      ),
      home: const MainNavigation(),
    );
  }
}

// ويدجيت للتنقل السفلي بين الشاشات الرئيسية
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [const HomeScreen(), const ExploreScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                _selectedIndex == 0
                    ? Icons.dashboard
                    : Icons.dashboard_outlined,
                key: ValueKey(_selectedIndex == 0),
              ),
            ),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return RotationTransition(turns: animation, child: child);
              },
              child: Icon(
                _selectedIndex == 1 ? Icons.explore : Icons.explore_outlined,
                key: ValueKey(_selectedIndex == 1),
              ),
            ),
            label: 'استكشاف',
          ),
        ],
      ),
    );
  }
}
