import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:mhealth2/cal/calendar_page.dart';
import 'package:mhealth2/diary/models/moodcard.dart';
import 'package:mhealth2/diary/screens/chart.dart';
import 'package:mhealth2/diary/screens/chat.dart';
import 'package:mhealth2/diary/screens/homepage.dart';
import 'package:mhealth2/diary/screens/start.dart';
import 'package:mhealth2/diary/screens/vroom.dart';
import 'package:mhealth2/profile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    CalendarControllerProvider(
      controller: EventController(), // Provide the EventController
      child:  MentalHealthApp(),
    ),
  );
}

class MentalHealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MoodCard>(
      create: (_) => MoodCard(
        datetime: '',
        mood: '',
        image: '',
        actimage: '',
        actname: '',
        date: '',
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bonfire',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color.fromARGB(255, 5, 6, 7),
          fontFamily: 'Poppins',
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),
        home: HomePage(),
        routes: {
          '/home_screen': (ctx) => HomeScreen(),
          '/chart': (ctx) => MoodChart(),
          '/start': (ctx) => StartPage(),
          '/profile': (ctx) => ProfilePage(), 
          '/home' : (ctx) => HomePage(),
          '/diary': (context) => HomePage1(),
        },
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _bonfireAnimation;
  late Animation<double> _featuresAnimation;
  late Animation<double> _avatarsAnimation;
  bool _showBonfirePage = false;
  bool _isAIMode = true; 

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _bonfireAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _featuresAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _avatarsAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 1, curve: Curves.easeInOut),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 2) {
        // Navigate to the Profile Page
        Navigator.pushNamed(context, '/profile');
      } else {
        _showBonfirePage = index == 1;
        if (_showBonfirePage) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      }
    });
  }

  void _showChatOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.volume_off, color: Colors.white),
                title: Text('Mute Chat', style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle mute chat
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.white),
                title: Text('Leave Chat', style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle leave chat
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bonfire',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            top: 150,
            child: FireflyBackground(),
          ),
          AnimatedBuilder(
            animation: _featuresAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _featuresAnimation.value,
                child: Transform.translate(
                  offset: Offset(0, _featuresAnimation.value * 50),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back,',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'How are you feeling today?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Mood Over Time',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 150,
                                child: LineChartSample1(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
  child: GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VRRoomsPage(),
        ),
      );
    },
    child: _buildFeatureButton(
      icon: Icons.video_camera_back,
      label: 'VR Rooms',
      color: Color(0xFF00BFA6),
    ),
  ),
),
                            SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StartPage(),
                                    ),
                                  );
                                },
                                child: _buildFeatureButton(
                                  icon: Icons.book,
                                  label: 'Solace Diary',
                                  color: Color(0xFFF9A825),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 180),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _bonfireAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - _bonfireAnimation.value) * 200),
                  child: Opacity(
                    opacity: 1 - _bonfireAnimation.value,
                    child: Center(
                      child: Image.asset(
                        'assets/bonfire.gif',
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_showBonfirePage)
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedBuilder(
                  animation: _bonfireAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, (1 - _bonfireAnimation.value) * 200),
                      child: Opacity(
                        opacity: _bonfireAnimation.value,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/bonfire.gif',
                              width: 250,
                              height: 250,
                            ),
                            ..._buildAvatars(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          if (_showBonfirePage)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                      Navigator.push(
                        context,
                            MaterialPageRoute(builder: (context) => const Cahc()),
                        );
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Join Chat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          if (_showBonfirePage)
            Positioned(
              top: 10,
              left: -160,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'AI Therapist',
                        style: TextStyle(
                          color: _isAIMode ? Colors.orange : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        value: _isAIMode,
                        onChanged: (value) {
                          setState(() {
                            _isAIMode = value;
                          });
                        },
                        activeColor: Colors.orange,
                      ),
                      Text(
                        'Real Therapist',
                        style: TextStyle(
                          color: !_isAIMode ? Colors.orange : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _showBonfirePage ? 1 : 0,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'BONFIRE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureButton({required IconData icon, required String label, required Color color}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 40),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAvatars() {
    List<String> emojis = ['😊', '😊', '🤗', '😊', '😊', '🤗'];
    double radius = 140;
    double angle = 2 * pi / emojis.length;

    return List.generate(emojis.length, (index) {
      return AnimatedBuilder(
        animation: _avatarsAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              radius * _avatarsAnimation.value * cos(angle * index),
              radius * _avatarsAnimation.value * sin(angle * index),
            ),
            child: Opacity(
              opacity: _showBonfirePage ? _avatarsAnimation.value : 1 - _avatarsAnimation.value,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[800],
                child: Text(
                  emojis[index],
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

class LineChartSample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, interval: 1),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return Text('Mon');
                      case 1:
                        return Text('Tue');
                      case 2:
                        return Text('Wed');
                      case 3:
                        return Text('Thu');
                      case 4:
                        return Text('Fri');
                      case 5:
                        return Text('Sat');
                      case 6:
                        return Text('Sun');
                      default:
                        return Text('');
                    }
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 2),
                  FlSpot(1, 3.5),
                  FlSpot(2, 2.8),
                  FlSpot(3, 4),
                  FlSpot(4, 3),
                  FlSpot(5, 3.7),
                  FlSpot(6, 4.5),
                ],
                isCurved: true,
                barWidth: 4,
                belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FireflyBackground extends StatefulWidget {
  @override
  _FireflyBackgroundState createState() => _FireflyBackgroundState();
}

class _FireflyBackgroundState extends State<FireflyBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Firefly> fireflies = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    )..repeat();

    for (int i = 0; i < 30; i++) {
      fireflies.add(Firefly());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: FireflyPainter(fireflies, _controller.value),
        );
      },
    );
  }
}

class Firefly {
  double x = Random().nextDouble();
  double y = Random().nextDouble();
  double size = Random().nextDouble() * 3 + 1;
  double speed = Random().nextDouble() * 0.5 + 0.2;
  double opacity = Random().nextDouble() * 0.5 + 0.3;
}

class FireflyPainter extends CustomPainter {
  final List<Firefly> fireflies;
  final double animationValue;

  FireflyPainter(this.fireflies, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    for (var firefly in fireflies) {
      firefly.y -= firefly.speed * 0.01;
      if (firefly.y < 0) {
        firefly.y = 1;
        firefly.x = Random().nextDouble();
      }

      canvas.drawCircle(
        Offset(firefly.x * size.width, firefly.y * size.height),
        firefly.size,
        paint..color = Colors.orange.withOpacity(firefly.opacity),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}