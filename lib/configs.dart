final List<String> models = [
  "ResNet",
  "MobileNetV2",
  "InceptionV3",
  "MobileNetV3",
  "EfficientNet",
  "InceptionV2"
];

Map<String, dynamic> modelConfig = {
  "models": models,
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
