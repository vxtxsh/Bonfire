import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:mhealth2/cal/event_page.dart';
import 'package:mhealth2/main.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final EventController _eventController = EventController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black, // Dark blue
        scaffoldBackgroundColor:
            const Color.fromARGB(255, 38, 38, 38), // Black background
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black, // Dark blue app bar
          titleTextStyle: const TextStyle(
            color: Colors.white, // White text
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white, // White icons
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.amber, // White text for selected tab
          unselectedLabelColor: Colors.grey, // Grey text for unselected tabs
          // indicator: BoxDecoration(
          //     color: Colors.amber,
          //     borderRadius: BorderRadius.circular(8) // Dark blue indicator
          //     ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // White text
          bodyMedium: TextStyle(color: Colors.white), // White text
          titleLarge: TextStyle(color: Colors.white), // White text
        ),
      ),
      home: CalendarControllerProvider(
        controller: _eventController,
        child: Scaffold(
          appBar: AppBar(
            
            centerTitle: true,
            title: const Text('Diary'),
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const EventsPage()),
                ),
                icon: const Icon(Icons.add),
              ),
              IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) =>  HomePage()),
                ),
          ),
            ],
            
            bottom: TabBar(
              controller: _tabController,
              labelStyle: const TextStyle(
                fontSize: 18,
              ),
              labelPadding: const EdgeInsets.all(10),
              tabs: const [
                Text('Day View'),
                Text('Week View'),
                Text('Month View'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const <Widget>[
              DayView(
                backgroundColor: Colors.black,
              ), // Display the Day View
              WeekView(
                backgroundColor: Colors.black,
              ), // Display the Week View
              MonthView(), // Display the Month View
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
