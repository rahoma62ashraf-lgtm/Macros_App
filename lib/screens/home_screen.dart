import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../data/dummy_data.dart';
import 'meal_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الملخص اليومي - Macros',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'استهلاكك اليومي',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMacroCircle(
                      'السعرات',
                      '1200 / 2000',
                      0.6,
                      Colors.green,
                    ),
                    _buildMacroCircle('بروتين', '60ج / 120ج', 0.5, Colors.red),
                    _buildMacroCircle(
                      'كارب',
                      '150ج / 200ج',
                      0.75,
                      Colors.orange,
                    ),
                    _buildMacroCircle('دهون', '40ج / 70ج', 0.57, Colors.blue),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'آخر الوجبات المضافة',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // قائمة أحدث الوجبات
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dummyMeals.length,
                itemBuilder: (context, index) {
                  final meal = dummyMeals[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          meal.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        meal.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${meal.calories} سعر حراري | ${meal.category}',
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MealDetailsScreen(meal: meal),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroCircle(
    String title,
    String subtitle,
    double percent,
    Color color,
  ) {
    return CircularPercentIndicator(
      radius: 40.0,
      lineWidth: 8.0,
      percent: percent,
      animation: true,
      center: Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      footer: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          subtitle,
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: color,
      backgroundColor: Colors.grey[300]!,
    );
  }
}
