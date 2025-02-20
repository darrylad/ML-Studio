final List<String> models = [
  "ResNet",
  "MobileNetV2",
  "InceptionV3",
  "MobileNetV3",
  "EfficientNet",
];

final List<String> loss = [
  "sparse_categorical_crossentropy",
  "categorical_crossentropy",
  "binary_crossentropy",
  "mean_squared_error",
  "mean_absolute_error"
];

final List<String> optimizer = [
  "adam",
  "sgd",
  "rmsprop",
  "adagrad",
  "adadelta"
];

double minEpochs = 1;
double maxEpochs = 64;

double minBatchSize = 1;
double maxBatchSize = 64;

int learningRate = 100;
double minLearningRate = 1;
double maxLearningRate = 1000;

Map<String, dynamic> modelConfig = {
  "models": models.map((model) => {"name": model}).toList(),
  "selectedModel": models[0],
  "epochs": 10,
  "batchSize": 32,
  "learningRate": 0.001,
  "optimizer": "adam",
  "loss": "sparse_categorical_crossentropy",
  "metrics": ["accuracy"],
  "validationSplit": 0.2,
  "imageSize": 224,
  "augmentation": false,
  "augmentationOptions": {
    "rotation": 0.1,
    "widthShift": 0.1,
    "heightShift": 0.1,
    "shear": 0.1,
    "zoom": 0.1,
    "horizontalFlip": false,
    "verticalFlip": false,
    "randomBrightness": false,
    "randomContrast": false,
    "randomSaturation": false,
    "randomHue": false
  }
};
