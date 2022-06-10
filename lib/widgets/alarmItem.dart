import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmItem extends StatefulWidget {
  AlarmItem({Key? key, required this.hour}) : super(key: key);

  final String hour;

  @override
  State<AlarmItem> createState() => _AlarmItemState();
}

class _AlarmItemState extends State<AlarmItem> {
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(17),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hour,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          'Sun',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          'Mon',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          'Tue',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Switch.adaptive(
                  value: enabled,
                  onChanged: (bool val) {
                    setState(() {
                      enabled = !enabled;
                    });
                  })
            ],
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            height: 1.0,
            child: Container(color: Colors.white30),
          )
        ],
      ),
    );
  }
}
