import 'package:Budget_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarChart extends StatefulWidget {
  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Weekly Spending',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
              color: Colors.black,
              onPressed: () {},
            ),
            Text(
              'Nov 10,2019 - Nov 16, 2019',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              iconSize: 30,
              color: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Bar(
              label: 'Su',
              amountSpent: Provider.of<Data>(context).weeklySpending[0],
              mostExpensive: 200,
            ),
            Bar(
              label: 'Mo',
              amountSpent: Provider.of<Data>(context).weeklySpending[1],
              mostExpensive: 200,
            ),
            Bar(
              label: 'Tu',
              amountSpent: Provider.of<Data>(context).weeklySpending[2],
              mostExpensive: 200,
            ),
            Bar(
              label: 'We',
              amountSpent: Provider.of<Data>(context).weeklySpending[3],
              mostExpensive: 200,
            ),
            Bar(
              label: 'Th',
              amountSpent: Provider.of<Data>(context).weeklySpending[4],
              mostExpensive: 200,
            ),
            Bar(
              label: 'Fr',
              amountSpent: Provider.of<Data>(context).weeklySpending[5],
              mostExpensive: 200,
            ),
              Bar(
              label: 'Sa',
              amountSpent: Provider.of<Data>(context).weeklySpending[6],
              mostExpensive: 200,
            ),
          ],
        )
      ],
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;
  Bar({this.label, this.amountSpent, this.mostExpensive});
  final double _maxBarHeight = 150;
  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;
    return Column(
      children: <Widget>[
        Text(
          '\$${amountSpent.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          height: barHeight,
          width: 15,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        Text(
          label.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
