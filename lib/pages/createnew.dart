import 'package:flutter/material.dart';
import 'package:graphical_model_interface/components/stepper.dart' as s;

class CreateNew extends StatefulWidget {
  const CreateNew({super.key});

  @override
  State<CreateNew> createState() => _CreateNewState();
}

class _CreateNewState extends State<CreateNew> {
  int totalSteps = 5;
  int currentStep = 1;

  PageController pageController = PageController();

  void incrementStep() {
    if (currentStep > totalSteps) {
      return;
    } else if (currentStep == totalSteps) {
      setState(() {
        ++currentStep;
      });
      return;
    }
    setState(() {
      ++currentStep;
      pageController.jumpToPage(currentStep - 1);
    });
  }

  void decrementStep() {
    if (currentStep <= 1) {
      return;
    }
    setState(() {
      --currentStep;
      pageController.jumpToPage(currentStep - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            abortDialog(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          const Text(
            'Create New',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          s.Stepper(
            totalSteps: totalSteps,
            currentStep: currentStep,
            incrementStep: incrementStep,
            decrementStep: decrementStep,
          ),
          const SizedBox(height: 32),
          Text('Step $currentStep'),
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.green,
                ),
                Container(
                  color: Colors.yellow,
                ),
                Container(
                  color: Colors.purple,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> abortDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Abort?'),
              content: const Text('You will lose all progress.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Abort',
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
              ],
            ));
  }
}
