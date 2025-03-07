import 'package:flutter/material.dart';
import 'package:mhealth2/diary/helpers/db_helper.dart';
import 'package:mhealth2/diary/helpers/mooddata.dart';
import 'package:mhealth2/diary/models/moodcard.dart';
import 'package:mhealth2/diary/widgets/mooddaycard.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart package

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loader = false;

  @override
  Widget build(BuildContext context) {
    loader = Provider.of<MoodCard>(context, listen: true).isloading;

    return loader
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.black, // Dark background color
            appBar: AppBar(
              title: Text('Your Moods', style: TextStyle(color: Colors.white)), // White text in AppBar
              backgroundColor: Colors.red,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.show_chart, color: Colors.white), // White icon
                    onPressed: () => Navigator.of(context).pushNamed('/chart'))
              ],
            ),
            body: FutureBuilder<List<Map<String, dynamic>>>(  
              future: DBHelper.getData('user_moods'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error loading data", style: TextStyle(color: Colors.white)));
                }

                List<Map<String, dynamic>> data = snapshot.data ?? [];

                if (data.isEmpty) {
                  return Center(child: Text("No moods recorded yet", style: TextStyle(color: Colors.white)));
                }

                return ListView.builder(
                  
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, int position) {
                    var item = data[position];

                    var imagestring = item['actimage'] ?? '';
                    List<String> img = imagestring.split('_');
                    List<String> name = (item['actname'] ?? '').split("_");

                    Provider.of<MoodCard>(context, listen: false)
                        .actiname
                        .addAll(name);

                    Provider.of<MoodCard>(context, listen: false).data.add(
                      MoodData(
                        _getMoodValue(item['mood']),
                        item['date'] ?? '',
                        _getMoodColor(item['mood']),
                      ),
                    );

                    return MoodDay(
                      item['image'] ?? '',
                      item['datetime'] ?? '',
                      item['mood'] ?? 'Unknown',
                      img,
                      name,
                    );
                  },
                );
              },
            ),
          );
  }

  int _getMoodValue(String? mood) {
    switch (mood) {
      case 'Angry':
        return 1;
      case 'Happy':
        return 2;
      case 'Sad':
        return 3;
      case 'Surprised':
        return 4;
      case 'Loving':
        return 5;
      case 'Scared':
        return 6;
      default:
        return 7;
    }
  }

  Color _getMoodColor(String? mood) {
    switch (mood) {
      case 'Angry':
        return Colors.red;
      case 'Happy':
        return Colors.blue;
      case 'Sad':
        return Colors.green;
      case 'Surprised':
        return Colors.pink;
      case 'Loving':
        return Colors.purple;
      case 'Scared':
        return Colors.black;
      default:
        return const Color.fromARGB(255, 27, 27, 27);
    }
  }
}
