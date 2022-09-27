import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timer/screens/timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController hours = TextEditingController();
    TextEditingController minutes = TextEditingController();
    TextEditingController seconds = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sports Timer'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      "Hours",
                      style: TextStyle(fontSize: 23),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3 - 40,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 40),
                        keyboardType: TextInputType.number,
                        controller: hours,
                        maxLength: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Minutes",
                      style: TextStyle(fontSize: 23),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3 - 40,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 40),
                        keyboardType: TextInputType.number,
                        controller: minutes,
                        maxLength: 2,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("^([0-5]?[0-9]|60)")),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Seconds",
                      style: TextStyle(fontSize: 23),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3 - 40,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 40),
                        keyboardType: TextInputType.number,
                        controller: seconds,
                        maxLength: 2,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("^([0-5]?[0-9]|60)")),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            MaterialButton(
              onPressed: () {
                Map<String, dynamic> textValues = {
                  'Hours': hours.value.text,
                  'Minutes': minutes.value.text,
                  'Seconds': seconds.value.text
                };
                // Checking if all values are ""
                if (textValues["Hours"].isEmpty &&
                    textValues["Minutes"].isEmpty &&
                    textValues["Seconds"].isEmpty) return;
                textValues.forEach((key, value) {
                  // Turning strings if empty to nums, otherwise the parse method won't work
                  if (textValues[key] == "") {
                    textValues[key] = 0;
                  } else {
                    textValues[key] = num.parse(value);
                  }
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Timer(
                      time: textValues,
                    ),
                  ),
                );
              },
              color: Colors.blue,
              child: const Text("Start Timer",
                  style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
