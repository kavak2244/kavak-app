import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shamsi_date/shamsi_date.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مدیریت مالی',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.teal,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Vazirmatn'),
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', ''),
      ],
      locale: const Locale('fa'),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<String> _tabTitles = [
    'سالانه', 'ماهانه', 'هزینه بیزنس', 'درآمد بیزنس',
    'چک دریافتی', 'چک پرداختی', 'کرایه‌ها', 'هزینه شخصی', 'نمودارها'
  ];

  static final List<Widget> _pages = [
    YearlyPage(),
    Center(child: Text('ماهانه')),
    Center(child: Text('هزینه بیزنس')),
    Center(child: Text('درآمد بیزنس')),
    Center(child: Text('چک دریافتی')),
    Center(child: Text('چک پرداختی')),
    Center(child: Text('کرایه‌ها')),
    Center(child: Text('هزینه شخصی')),
    Center(child: Text('نمودارها')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tabTitles[_selectedIndex])),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'سالانه'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_view_month), label: 'ماهانه'),
          BottomNavigationBarItem(icon: Icon(Icons.money_off), label: 'هزینه بیزنس'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'درآمد'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'چک دریافتی'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'چک پرداختی'),
          BottomNavigationBarItem(icon: Icon(Icons.house), label: 'کرایه‌ها'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'شخصی'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'نمودار'),
        ],
      ),
    );
  }
}

class YearlyPage extends StatelessWidget {
  final List<String> headers = [
    'تاریخ', 'چک پرداختی', 'چک دریافتی', 'درآمد 1', 'درآمد 2', 'درآمد 3', 'درآمد 4', 'درآمد 5',
    'شخصی', 'اقساط', 'کرایه‌ها', 'هزینه 1', 'هزینه 2', 'هزینه 3', 'نقدینگی'
  ];

  YearlyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final yearDays = List.generate(365, (i) => Jalali(1403, 1, 1).addDays(i));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          columns: headers.map((h) => DataColumn(label: Text(h))).toList(),
          rows: yearDays.map((day) {
            return DataRow(
              cells: [
                DataCell(Text('${day.formatCompactDate()}')),
                ...List.generate(14, (index) => const DataCell(Text('-'))),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

extension on Jalali {
  String formatCompactDate() => '$year/${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}';
}