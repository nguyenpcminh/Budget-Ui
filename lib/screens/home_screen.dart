import 'package:Budget_app/data/data.dart';
import 'package:Budget_app/helper/color_helper.dart';
import 'package:Budget_app/models/category_model.dart';
import 'package:Budget_app/screens/category_screen.dart';
import 'package:Budget_app/widget/bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (_, data, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: IconButton(
                    icon: Icon(Icons.settings),
                    color: Colors.white,
                    iconSize: 30,
                    onPressed: () {}),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Simple Budget'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    iconSize: 30,
                    onPressed: () {},
                  )
                ],
                expandedHeight: 100,
                floating: true,
                // pinned: true,
                forceElevated: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, int index) {
                    if (index == 0) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 6,
                              color: Colors.black38,
                            )
                          ],
                        ),
                        child: BarChart(),
                      );
                    } else {
                      Category category = data.categories[index - 1];
                      double totalAmountSpent = 0;
                      category.expenses.forEach((expense) {
                        totalAmountSpent += expense.cost;
                      });
                      return BuildCategory(
                          category: category,
                          totalAmountSpent: totalAmountSpent);
                    }
                  },
                  childCount: 1 + data.categories.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BuildCategory extends StatelessWidget {
  BuildCategory({@required this.category, this.totalAmountSpent});
  final double totalAmountSpent;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CategoryScreen(category: category),
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 6.0,
              color: Colors.black38,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double maxBarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - totalAmountSpent) /
                    category.maxAmount;
                double barWidth = percent * maxBarWidth;
                return Stack(
                  children: <Widget>[
                    Container(
                      height: 20,
                      width: maxBarWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Container(
                      width: barWidth,
                      height: 20,
                      decoration: BoxDecoration(
                        color: getColor(context, percent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
