import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPickerView extends StatefulWidget {
  const CupertinoPickerView({Key? key}) : super(key: key);

  @override
  _CupertinoPickerViewState createState() => _CupertinoPickerViewState();
}

class _CupertinoPickerViewState extends State<CupertinoPickerView> {
  var selectItem;
  double _kPickerSheetHeight = 216.0;
  DateTime? dateTime;
  Duration initialtimer = new Duration();
  var time;
  int value = 0;
  final items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return _buildBottomPicker(_buildCupertinoPicker());
                    });
              },
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.pinkAccent),
                    child: const Center(
                      child: Text(
                        "Cupertino Picker",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // SizedBox(height: 30,),

                  Container(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      selectItem ?? 'No Item Chosen',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return _buildBottomPicker(_buildDateTimePicker());
                    });
              },
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue),
                    child: const Center(
                      child: Text(
                        "Cupertino Date Picker",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      dateTime == null ? 'No Date Chosen' : ' ${dateTime}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return _buildBottomPicker(timePicker());
                    });
              },
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.orange),
                    child: const Center(
                      child: Text(
                        "Cupertino Time Picker",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      time == null ? 'No Time Chosen' : ' $time',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCupertinoPicker() {
    return CupertinoPicker(
      magnification: 1.5,
      backgroundColor: Colors.white,
      itemExtent: 50,
      looping: true,
      children: items
          .map((item) => Center(
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 32),
                ),
              ))
          .toList(),
      onSelectedItemChanged: (index) {
        setState(() => value = index);
        selectItem = items[index];
        print("Selected Iem: $index");
      },
    );
  }

  Widget _buildDateTimePicker() {
    return CupertinoDatePicker(
        mode: CupertinoDatePickerMode.dateAndTime,
        initialDateTime: dateTime,
        onDateTimeChanged: (DateTime newDataTime) {
          if (mounted) {
            setState(() {
              dateTime = newDataTime;
            });
          }
        });
  }

  Widget timePicker() {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hms,
      minuteInterval: 1,
      secondInterval: 1,
      initialTimerDuration: initialtimer,
      onTimerDurationChanged: (Duration changedtimer) {
        setState(() {
          initialtimer = changedtimer;
          time =
              '${changedtimer.inHours} hrs ${changedtimer.inMinutes % 60} mines ${changedtimer.inSeconds % 60} secs';
        });
      },
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
}
