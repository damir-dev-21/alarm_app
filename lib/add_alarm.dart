import 'package:alarm_app/widgets/circleDat.dart';
import 'package:flutter/material.dart';

class AddAlarm extends StatefulWidget {
  const AddAlarm({Key? key}) : super(key: key);

  @override
  State<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  late TimeOfDay _selectedTime;
  late ValueChanged<TimeOfDay> selectTime;

  @override
  void initState() {
    _selectedTime = const TimeOfDay(hour: 12, minute: 30);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b2c57),
      appBar: AppBar(
        backgroundColor: const Color(0xff1b2c57),
        title: Column(
          children: const [
            Icon(
              Icons.alarm_add,
              color: Color(0xff65d1ba),
            ),
            Text(
              'Add alarm',
              style: TextStyle(color: Color(0xff65d1ba), fontSize: 25),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () {
                _selectTime(context);
              },
              child: Text(
                _selectedTime.format(context),
                style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                circleDay('Mon', context, false),
                circleDay('Tue', context, true),
                circleDay('Wed', context, true),
                circleDay('Thu', context, true),
                circleDay('Fri', context, false),
                circleDay('Sat', context, true),
                circleDay('Sun', context, false),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 2,
              child: Container(color: Colors.white30),
            ),
            const ListTile(
              leading: Icon(Icons.notifications_none, color: Colors.white),
              title: Text(
                'Alarm Notification',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 2,
              child: Container(color: Colors.white30),
            ),
            const ListTile(
              leading: Icon(Icons.check_box, color: Colors.white),
              title: Text(
                'Vibrate',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 2,
              child: Container(color: Colors.white30),
            ),
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                color: Theme.of(context).accentColor,
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        backgroundColor: Colors.white,
        child: Icon(Icons.delete,
            size: 20.0, color: Theme.of(context).accentColor),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _selectedTime);

    setState(() {
      _selectedTime = picked!;
    });
  }
}
