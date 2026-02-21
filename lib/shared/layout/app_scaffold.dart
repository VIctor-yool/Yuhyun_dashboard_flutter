import 'package:flutter/material.dart';
import '../../features/dashboard/ui/dashboard_screen.dart';
import '../../features/dashboard/ui/placeholder_screen.dart';
import '../../features/auth/ui/login_page.dart';
import 'app_menu_drawer.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  AppMenuItem _currentMenu = AppMenuItem.integratedDashboard;

  Widget _buildScreen() {
    switch (_currentMenu) {
      case AppMenuItem.integratedDashboard:
        return const DashboardScreen();
      case AppMenuItem.realtimeMonitoring:
        return PlaceholderScreen(title: AppMenuItem.realtimeMonitoring.label);
      case AppMenuItem.alerts:
        return PlaceholderScreen(title: AppMenuItem.alerts.label);
      case AppMenuItem.qrLookup:
        return PlaceholderScreen(title: AppMenuItem.qrLookup.label);
      case AppMenuItem.autoReport:
        return PlaceholderScreen(title: AppMenuItem.autoReport.label);
    }
  }

  void _onMenuSelected(AppMenuItem item) {
    setState(() => _currentMenu = item);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentMenu.label),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            child: const Text('로그인/회원가입'),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: '메뉴',
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: AppMenuDrawer(
          selectedItem: _currentMenu,
          onItemSelected: _onMenuSelected,
        ),
      ),
      body: _buildScreen(),
    );
  }
}
