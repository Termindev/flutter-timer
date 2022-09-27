import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  const Timer({super.key, required this.time});
  final Map time;
  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  late Map time = widget.time;
  int secs = 0;
  int hrs = 0;
  int mins = 0;
  bool isRunning = false;
  Future<void> playSound(src) async {
    final player = AudioPlayer();
    await player.setVolume(1.3);
    await player.play(
      AssetSource('$src'),
    );
  }

  @override
  void dispose() {
    secs = hrs = mins = 0;
    isRunning = false;
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    secs = time["Seconds"];
    hrs = time["Hours"];
    mins = time["Minutes"];
  }

  pause() {
    setState(() {
      isRunning = false;
    });
  }

  Future<void> count() async {
    main:
    while (true) {
      while (secs >= 0) {
        if (!isRunning) {
          secs++;
          return;
        }
        await playSound("tick.mp3");
        setState(() {
          secs -= 1;
        });
        await Future.delayed(const Duration(seconds: 1));
      }
      if (mins >= 1) {
        setState(() {
          secs = 60;
          mins -= 1;
        });
      } else if (hrs >= 1) {
        setState(() {
          secs = 59;
          hrs -= 1;
        });
      } else {
        await playSound("Ding.mp3");
        break main;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text("Hours"),
                  Text(
                    '$hrs',
                    style: const TextStyle(fontSize: 40),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const Text("Minutes"),
                  Text(
                    '$mins',
                    style: const TextStyle(fontSize: 40),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const Text("Seconds"),
                  Text(
                    '$secs',
                    style: const TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          isRunning
              ? MaterialButton(
                  onPressed: pause,
                  color: Colors.blue,
                  child: const Text("Pause",
                      style: TextStyle(color: Colors.white)),
                )
              : MaterialButton(
                  onPressed: () {
                    isRunning = true;
                    count();
                  },
                  color: Colors.blue,
                  child: const Text("Start",
                      style: TextStyle(color: Colors.white)),
                )
        ],
      ),
    );
  }
}
