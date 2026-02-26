import 'package:flutter/material.dart';
import '../../core/theme/app_design_system.dart';
import '../../features/dashboard/ui/dashboard_screen.dart';
import '../../features/dashboard/ui/monitoring_screen.dart';
import '../../features/dashboard/ui/alerts_screen.dart';
import '../../features/dashboard/ui/qr_screen.dart';
import '../../features/dashboard/ui/reports_screen.dart';
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
        return const MonitoringScreen();
      case AppMenuItem.alerts:
        return const AlertsScreen();
      case AppMenuItem.qrLookup:
        return const QrScreen();
      case AppMenuItem.autoReport:
        return const ReportsScreen();
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
        backgroundColor: AppDesignSystem.bgPrimary,
        foregroundColor: AppDesignSystem.textTitle,
        toolbarHeight: AppDesignSystem.mobileAppBarHeight,
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
        backgroundColor: AppDesignSystem.sidebarBg,
        child: AppMenuDrawer(
          selectedItem: _currentMenu,
          onItemSelected: _onMenuSelected,
        ),
      ),
      body: _buildScreen(),
    );
  }
}
