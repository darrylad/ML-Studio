import 'package:flutter/material.dart';
import 'package:graphical_model_interface/components/multi_selector.dart';
import 'package:graphical_model_interface/components/selector.dart';
import 'package:graphical_model_interface/components/slider_theme.dart';
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
                inputPage(context),
                labelPage(),
                modelSelectionPage(context, models),
                hyperParamsPage(),
                Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding hyperParamsPage() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 32 + MediaQuery.of(context).size.width * 0.1),
      child: Column(
        children: [
          const Text(
            "Hyperparameters",
          ),
          const SizedBox(height: 32),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Epochs"),
                  Slider3D(
                      min: minEpochs,
                      max: maxEpochs,
                      isInt: true,
                      sliderValue: modelConfig["epochs"].toDouble(),
                      onChanged: (value) {
                        setState(() {
                          modelConfig["epochs"] = value.toInt();
                        });
                      }),
                  const SizedBox(height: 32),
                  const Text("Batch Size"),
                  Slider3D(
                      min: minBatchSize,
                      max: maxBatchSize,
                      isInt: true,
                      sliderValue: modelConfig["batchSize"].toDouble(),
                      onChanged: (value) {
                        setState(() {
                          modelConfig["batchSize"] = value.toInt();
                        });
                      }),
                  const SizedBox(height: 32),
                  const Text("Learning Rate"),
                  Slider3D(
                      min: minLearningRate,
                      max: maxLearningRate,
                      isInt: false,
                      sliderValue: learningRate.toDouble(),
                      label: modelConfig["learningRate"],
                      onChanged: (value) {
                        setState(() {
                          learningRate = value.toInt();
                          modelConfig["learningRate"] =
                              learningRate / maxLearningRate;
                        });
                      }),
                  const SizedBox(height: 32),
                  const Text("Optimizer"),
                  Center(
                    child: Selector(
                      wide: true,
                      selectors: optimizer,
                      defaultSelector: modelConfig["optimizer"],
                      onSelectionChanged: (newSelection) {
                        setState(() {
                          modelConfig["optimizer"] = newSelection;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text("Loss"),
                  Center(
                    child: Selector(
                      wide: true,
                      selectors: loss,
                      defaultSelector: modelConfig["loss"],
                      onSelectionChanged: (newSelection) {
                        setState(() {
                          modelConfig["loss"] = newSelection;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text("Metrics"),
                  Wrap(
                    children: modelConfig["metrics"]
                        .map<Widget>((metric) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Chip(
                                label: Text(metric),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 32),
                  const Text("Augumentation"),
                  Center(
                    child: MultiSelector(
                        options: const ['accuracy', 'precision', 'recall'],
                        initialSelected: const ['accuracy'],
                        onSelectionChanged: (newSelection) {
                          setState(() {});
                        }),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column modelSelectionPage(BuildContext context, List<String> models) {
    return Column(
      children: [
        const Text("Select a model"),
        const SizedBox(height: 16),
        Expanded(
            child: Selector(
          compact: false,
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

  Column labelPage() {
    return const Column(
      children: [
        Text("Labels"),
      ],
    );
  }

  SingleChildScrollView inputPage(BuildContext context) {
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
