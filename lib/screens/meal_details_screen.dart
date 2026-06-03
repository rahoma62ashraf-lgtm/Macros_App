import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  final Meal meal;

  const MealDetailsScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.title), backgroundColor: Colors.green),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة الطبق
              Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      meal.category,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const Divider(height: 32),

                    const Text(
                      'القيمة الغذائية لكل 100 جرام:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // كروت الماكروز والسعرات
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMacroStat(
                          'السعرات',
                          '${meal.calories}',
                          Colors.green[50]!,
                          Colors.green,
                        ),
                        _buildMacroStat(
                          'بروتين',
                          '${meal.protein}ج',
                          Colors.red[50]!,
                          Colors.red,
                        ),
                        _buildMacroStat(
                          'كارب',
                          '${meal.carbs}ج',
                          Colors.orange[50]!,
                          Colors.orange,
                        ),
                        _buildMacroStat(
                          'دهون',
                          '${meal.fat}ج',
                          Colors.blue[50]!,
                          Colors.blue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // زر إضافة لليوميات عريض
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تم إضافة الوجبة لليوميات بنجاح!'),
                            ),
                          );
                        },
                        child: const Text(
                          'إضافة لليوميات',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroStat(
    String label,
    String value,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      width: 75,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
