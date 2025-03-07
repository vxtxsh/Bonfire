import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart package

import 'package:provider/provider.dart';

class MoodChart extends StatefulWidget {
  @override
  _MoodChartState createState() => _MoodChartState();
}

class _MoodChartState extends State<MoodChart> {
  @override
  Widget build(BuildContext context) {
    // Example moods data with a dummy list
    List<Map<String, dynamic>> moods = [
      {'label': 'Angry', 'value': 5, 'color': Colors.red},
      {'label': 'Happy', 'value': 4, 'color': Colors.blue},
      {'label': 'Sad', 'value': 3, 'color': Colors.purple},
      {'label': 'Excited', 'value': 6, 'color': Colors.orange},
      {'label': 'Relaxed', 'value': 2, 'color': Colors.green},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Graph'),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        children: <Widget>[
          SizedBox(height: 80),
          Container(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10,
                barGroups: moods.map((mood) {
                  return BarChartGroupData(
                    x: moods.indexOf(mood),
                    barRods: [
                      BarChartRodData(
                        fromY: 0,
                        toY: mood['value'].toDouble(),
                        color: mood['color'],
                        width: 10,
                      ),
                    ],
                  );
                }).toList(),
              ),
              swapAnimationDuration: Duration(milliseconds: 150),
            ),
          ),
          SizedBox(height: 80),
          Container(
            width: double.infinity,
            height: 250,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2, // Space between sections
                centerSpaceRadius: 0, // Space in the middle
                sections: moods.map((mood) {
                  return PieChartSectionData(
                    color: mood['color'],
                    value: mood['value'].toDouble(),
                    title: '${mood['label']} (${mood['value']})',
                    radius: 150, // Radius for the section
                    titleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
