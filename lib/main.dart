import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: MainApp(),
        ),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Controllers for text fields
  TextEditingController item1 = TextEditingController();

  TextEditingController item2 = TextEditingController();

  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
          // title
          children: [
            const SizedBox(height: 20),

            const Text(
              'Simple calculator',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),
            // first text field
            TextField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              controller: item1,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),

            const SizedBox(height: 20),
            // second text field
            TextField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              controller: item2,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),

            const SizedBox(height: 20),
            // operation buttons (+, -, *, /, %)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // parse the text from the controllers
                    double a = double.parse(item1.text);
                    double b = double.parse(item2.text);
                    setState(() {
                      result = a + b;
                    });
                  },
                  child: MyButtonLabel(label: '+'),
                ),
                ElevatedButton(
                  onPressed: () {
                    double a = double.parse(item1.text);
                    double b = double.parse(item2.text);
                    setState(() {
                      result = a - b;
                    });
                  },
                  child: MyButtonLabel(label: '-'),
                ),
                ElevatedButton(
                  onPressed: () {
                    double a = double.parse(item1.text);
                    double b = double.parse(item2.text);
                    setState(() {
                      result = a * b;
                    });
                  },
                  child: MyButtonLabel(label: '*'),
                ),
                ElevatedButton(
                  onPressed: () {
                    double a = double.parse(item1.text);
                    double b = double.parse(item2.text);
                    if (b == 0.0) {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                                title: const Text('Whoopsie!'),
                                content: const Text(" You can't divide by 0  "),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () =>
                                        Navigator.pop(dialogContext),
                                  )
                                ]);
                          });
                    }
                    setState(() {
                      result = a / b;
                    });
                  },
                  child: MyButtonLabel(label: '/'),
                ),
                ElevatedButton(
                  onPressed: () {
                    double a = double.parse(item1.text);
                    double b = double.parse(item2.text);
                    setState(() {
                      result = a % b;
                    });
                  },
                  child: MyButtonLabel(label: '%'),
                ),
              ],
            ),

            const SizedBox(height: 20),
            // result text
            Text(
              'Result: $result',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
    );
  }
}

class MyButtonLabel extends StatelessWidget {
  MyButtonLabel({
    super.key,
    required this.label,
  });

  late String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
