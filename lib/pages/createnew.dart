import 'package:flutter/material.dart';
import 'package:graphical_model_interface/components/selector.dart';
import 'package:graphical_model_interface/components/stepper.dart' as s;
import 'package:graphical_model_interface/configs.dart';

class CreateNew extends StatefulWidget {
  const CreateNew({super.key});

  @override
  State<CreateNew> createState() => _CreateNewState();
}

class _CreateNewState extends State<CreateNew> {
  int totalSteps = 5;
  int currentStep = 1;

  PageController pageController = PageController();

  String? selectedModel;

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
          const SizedBox(height: 26),
          const Text(
            'Create New',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          s.Stepper(
            totalSteps: totalSteps,
            currentStep: currentStep,
            incrementStep: incrementStep,
            decrementStep: decrementStep,
          ),
          const SizedBox(height: 32),
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                page1(context),
                page2(),
                page3(context, models),
                Container(),
                Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column page3(BuildContext context, List<String> models) {
    return Column(
      children: [
        const Text("Select a model"),
        const SizedBox(height: 16),
        Expanded(
            child: Selector(
          selectors: models,
          defaultSelector: modelConfig["selectedModel"],
          onSelectionChanged: (newSelection) {
            setState(() {
              modelConfig["selectedModel"] = newSelection;
            });
          },
        )),
      ],
    );
  }

  Column page2() {
    return const Column(
      children: [
        Text("Labels"),
      ],
    );
  }

  SingleChildScrollView page1(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Container(
            height: 200,
            width: 400 + MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade500, width: 3),
            ),
            child: Center(
                child: Text(
              "Drag input here",
              style: TextStyle(color: Colors.grey.shade600),
            )),
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
