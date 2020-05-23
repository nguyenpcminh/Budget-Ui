import 'package:Budget_app/helper/color_helper.dart';
import 'package:Budget_app/models/category_model.dart';
import 'package:Budget_app/widget/radial_painter.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  CategoryScreen({this.category});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  _buildExpense(){
    List<Widget> expenses = [];
    widget.category.expenses.forEach((element) {
      expenses.add(Container(
        margin: EdgeInsets.all(20),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color:Colors.white,
          boxShadow: [BoxShadow(
            offset:Offset(0,2),
            blurRadius: 6,
            color: Colors.black38,
          )]
        ),
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(element.name,style: TextStyle(fontSize:20,fontWeight:FontWeight.w600,),),
              Text('-\$${element.cost.toStringAsFixed(2)}',style: TextStyle(fontSize:20,fontWeight:FontWeight.w400,),),
            ],
          ),
        ),
      ));
    });
    return Column(children: expenses,);
  }
  @override
  Widget build(BuildContext context) {
    double totalAmountSpent = 0;
    widget.category.expenses.forEach((element) {
      totalAmountSpent += element.cost;
    });
    final double amountLeft = widget.category.maxAmount - totalAmountSpent;
    final percent = amountLeft / widget.category.maxAmount;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name.toString()),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  )
                ],
              ),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: Colors.grey[200],
                  lineColor: getColor(context, percent),
                  percent: percent,
                  width: 15.0,
                ),
                child: Center(
                  child: Text(
                    '\$${amountLeft.toStringAsFixed(2)} / \$${widget.category.maxAmount}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            _buildExpense(),
          ],
        ),
      ),
    );
  }
}
