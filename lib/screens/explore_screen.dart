import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import 'meal_details_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String selectedCategory = 'الكل';

  @override
  Widget build(BuildContext context) {
    // فلترة الأكلات بناءً على التصنيف المختار
    final filteredMeals = selectedCategory == 'الكل'
        ? dummyMeals
        : dummyMeals
              .where((meal) => meal.category == selectedCategory)
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'استكشاف الأطعمة',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // شريط البحث
              TextField(
                decoration: InputDecoration(
                  hintText: 'ابحث عن وجبة مصري أو سعودي...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 16),

              // أزرار التصنيفات (Chips)
              Row(
                children: ["الكل", "أكلات مصرية", "أكلات سعودية"].map((
                  category,
                ) {
                  final isSelected = selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ChoiceChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: Colors.green,
                      onSelected: (val) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: filteredMeals.length,
                  itemBuilder: (context, index) {
                    final meal = filteredMeals[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MealDetailsScreen(meal: meal),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.network(
                                  meal.imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meal.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${meal.calories} سعر حراري',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
