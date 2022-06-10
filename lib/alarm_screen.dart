// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:alarm_app/shapes_painter.dart';
import 'package:alarm_app/widgets/alarmItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late String _timeString;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    _timeString = _formatDateTime(DateTime.now());

    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);

    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime time) {
    return DateFormat('hh:mm').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            bottom: TabBar(
                controller: _tabController,
                indicatorColor: Theme.of(context).accentColor,
                indicatorWeight: 4.0,
                tabs: [
                  Tab(
                    icon: Icon(Icons.access_time),
                    text: 'Clock',
                  ),
                  Tab(
                    icon: Icon(Icons.alarm),
                    text: 'Alarm',
                  ),
                  Tab(
                    icon: Icon(Icons.hourglass_empty),
                    text: 'Stopwatch',
                  ),
                  Tab(
                    icon: Icon(Icons.timer),
                    text: 'Timer',
                  ),
                ]),
          ),
          body: Container(
            color: Theme.of(context).primaryColor,
            child: TabBarView(controller: _tabController, children: [
              Container(
                  child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CustomPaint(
                      painter: ShapesPainter(),
                      child: Container(
                        height: 500.0,
                      ),
                    ),
                  ),
                  Text(
                    _timeString.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
              Container(
                  child: ListView(
                children: [
                  AlarmItem(hour: _timeString),
                  AlarmItem(hour: _timeString),
                  AlarmItem(hour: _timeString),
                  AlarmItem(hour: _timeString),
                ],
              )),
              timer(),
              StopWatch(),
            ]),
          ),
          floatingActionButton: _bottomButtons(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }

  FloatingActionButton? _bottomButtons() {
    switch (_tabController.index) {
      case 1:
        return FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/add-alarm'),
          backgroundColor: Color(0xff65d1ba),
          child: Icon(Icons.add, size: 20.0),
        );

      default:
    }
    return null;
  }
}

class StopWatch extends StatefulWidget {
  const StopWatch({
    Key? key,
  }) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  TimeOfDay? timeOfDay = TimeOfDay.now();
  bool play = false;
  int minutes = 1;
  int seconds = 0;
  int progresIndicator = 60;
  String time = "";

  Timer? timer;

  @override
  void initState() {
    time = "0${minutes.toString()}:00";

    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (((timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
          progresIndicator = seconds;
        }
        if (seconds == 0) {
          if (minutes > 0) {
            seconds = 59;

            minutes = minutes - 1;
          } else {
            stopTimer();
            minutes = 1;
            seconds = 0;
            progresIndicator = 60;
            play = false;
            time = "00:00";
          }
        }

        if (minutes.toString().length == 2) {
          time = "${minutes}:${seconds}";
        } else if (seconds.toString().length == 2 &&
            minutes.toString().length == 1) {
          time = "0${minutes}:${seconds}";
        } else {
          time = "0${minutes}:0${seconds}";
        }
      });
    })));
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: Stack(fit: StackFit.expand, children: [
              CircularProgressIndicator(
                color: Color(0xff65d1ba),
                value: progresIndicator / 60,
                strokeWidth: 10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    TimeOfDay? newTime = await showTimePicker(
                        context: context, initialTime: timeOfDay!);
                    if (newTime != null) {
                      setState(() {
                        timeOfDay = newTime;
                        minutes = newTime.minute;
                        seconds = 0;
                        time = "0${minutes.toString()}:00";
                      });
                    }
                  },
                  child: Text(
                    '${time.toString()}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 140,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        stopTimer();
                        play = false;
                        progresIndicator = 60;
                        minutes = 1;
                        seconds = 0;
                        time = "01:00";
                      });
                    },
                    icon: Icon(
                      Icons.stop_circle,
                      size: 40,
                      color: Color(0xff65d1ba),
                    )),
              ),
              IconButton(
                  onPressed: () {
                    if (play) {
                      stopTimer();
                    } else {
                      startTimer();
                    }
                    setState(() {
                      play = !play;
                    });
                  },
                  icon: Icon(
                    play ? Icons.pause_circle : Icons.play_circle,
                    size: 60,
                    color: Color(0xff65d1ba),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

class timer extends StatefulWidget {
  const timer({
    Key? key,
  }) : super(key: key);

  @override
  State<timer> createState() => _timerState();
}

class _timerState extends State<timer> {
  String time = "00:00";
  bool play = false;
  int minutes = 0;
  int seconds = 0;

  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (((timer) {
      setState(() {
        seconds++;
        if (seconds == 60) {
          minutes = minutes + 1;
          seconds = 0;
        }
        if (minutes.toString().length == 2) {
          time = "${minutes}:${seconds}";
        } else if (seconds.toString().length == 2 &&
            minutes.toString().length == 1) {
          time = "0${minutes}:${seconds}";
        } else {
          time = "0${minutes}:0${seconds}";
        }
      });
    })));
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: Stack(fit: StackFit.expand, children: [
              CircularProgressIndicator(
                color: Color(0xff65d1ba),
                value: seconds / 60,
                strokeWidth: 10,
              ),
              Center(
                child: Text(
                  '${time.toString()}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 140,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        stopTimer();
                        play = false;
                        minutes = 0;
                        seconds = 0;
                        time = "00:00";
                      });
                    },
                    icon: Icon(
                      Icons.stop_circle,
                      size: 40,
                      color: Color(0xff65d1ba),
                    )),
              ),
              IconButton(
                  onPressed: () {
                    if (play) {
                      stopTimer();
                    } else {
                      startTimer();
                    }
                    setState(() {
                      play = !play;
                    });
                  },
                  icon: Icon(
                    play ? Icons.pause_circle : Icons.play_circle,
                    size: 60,
                    color: Color(0xff65d1ba),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
