# Bayesian Hyperparameter Optimization for LiDAR Object Detection

## Table of Contents
1. [Introduction](#introduction)
   - Object Detection and Localization
   - Hyperparameter Optimization
2. [Background](#background)
   - LiDAR Object Detection
   - Bayesian Optimization in Deep Learning
3. [Proposed Framework](#proposed-framework)
   - Datasets
   - PointPillar Object Detector
   - Bayesian Optimization
4. [Experiment Design](#experiment-design)
   - LiDAR based Object Detection and Localization
   - Bayesian Optimization using Deep Learning in MATLAB
5. [Performance of the Proposed Work](#performance-of-the-proposed-work)
   - Evaluation Metrics
   - Performance of Grid Search HPO
   - Performance of Bayesian HPO
6. [Conclusion and Future Scope](#conclusion-and-future-scope)
7. [References](#references)
8. [Contributors](#contributors)

## Introduction

This repository contains the implementation of **Bayesian Hyperparameter Optimization for LiDAR Object Detection**. The goal is to optimize the hyperparameters of a LiDAR-based object detection model, specifically using the PointPillar architecture. We explore Bayesian Optimization as an effective tool for hyperparameter tuning, offering a more strategic approach compared to traditional methods like Grid Search.

### Abstract
Deep Learning models serve as powerful tools for tasks such as 3D Object Detection. The success of these models highly depends on the optimal choice of hyperparameters, which are traditionally selected through tedious and time-consuming methods. Our work leverages Bayesian Optimization to automate this process, focusing on the PointPillar architecture for LiDAR data. We validate our approach using the PANDASET and FLASH datasets, demonstrating improved model performance by around 6% compared to traditional techniques.

## Background

### LiDAR Object Detection
LiDAR technology is essential in autonomous vehicles for object detection and localization. It captures the environment with a higher level of detail than camera systems. However, traditional 3D CNN architectures cannot directly process LiDAR data due to its sparse and 3D nature. The PointPillar architecture is selected for this project due to its computational efficiency and suitability for processing LiDAR data.

### Bayesian Optimization in Deep Learning
Bayesian Optimization has gained popularity for hyperparameter tuning in deep learning due to its ability to efficiently explore the hyperparameter space. This project applies Bayesian Optimization to the PointPillar model, using the ARD 5/2 Gaussian Kernel and an acquisition function tailored for this task.

## Proposed Framework

### Datasets
- **Training and Validation Set**: [PANDASET](https://scale.com/open-datasets/pandaset) - A comprehensive dataset with 3D bounding boxes and point cloud segmentation for autonomous driving.
- **Evaluation Set**: FLASH - A multimodal dataset from GENESYS Lab, used for evaluating the model's domain adaptation capabilities.

### PointPillar Object Detector
The PointPillar architecture is composed of:
1. **Point Pillar Encoder**: Converts point cloud data into a 2D pseudo-image.
2. **2D CNN Backbone**: Processes the pseudo-image to capture spatial relationships.
3. **SSD Architecture**: Generates 3D bounding box proposals.

### Bayesian Optimization
Bayesian Optimization using Gaussian processes iteratively selects hyperparameters to evaluate, balancing exploration and exploitation. The Expected Improvement per second plus acquisition function is used, considering both the time and accuracy of evaluations.

## Experiment Design

### LiDAR based Object Detection and Localization
The PANDASET data is cropped to focus on front-view point clouds, optimizing the model's ability to detect nearby objects. The PointPillar model is fine-tuned using data augmentation techniques and validated against the FLASH dataset.

### Bayesian Optimization using Deep Learning in MATLAB
MATLAB's Bayesian Optimization tools are integrated with the PointPillar model. Hyperparameters such as learning rate and L2 regularization strength are optimized, improving model performance on the validation set.

## Performance of the Proposed Work

### Evaluation Metrics
The model is evaluated using metrics such as Average Precision (AP) and Recall. Comparisons are made between traditional Grid Search and Bayesian Optimization.

### Performance of Grid Search HPO
Initial experiments using Grid Search on the FLASH dataset yielded a baseline Recall of 73.463%.

### Performance of Bayesian HPO
Bayesian Optimization significantly improved the model's performance, achieving a final Recall of 81.6% on the FLASH dataset.

## Conclusion and Future Scope

Bayesian Optimization proved to be a valuable tool for enhancing LiDAR-based object detection models. Future work could include extending the model to detect additional object classes and experimenting with different acquisition functions.

## References
- [PointPillars: Fast Encoders for Object Detection From Point Clouds](https://arxiv.org/abs/1812.05784)
- [Practical Bayesian optimization of machine learning algorithms](https://arxiv.org/abs/1206.2944)
- [PANDASET](https://scale.com/open-datasets/pandaset)
- [MATLAB's Bayesian Optimization Documentation](https://www.mathworks.com/help/deeplearning/ug/deep-learning-using-bayesian-optimization.html)
- [FLASH Dataset](https://genesys-lab.com/flash-dataset)

## Contributors
1. **Suyash Pradhan** – Independently explored PointPillar model for vehicle object detection and Bayesian HPO Algorithm. Validated results on FLASH dataset and compared with baseline benchmarks.
2. **Saicharan Thirandas** - Implemented the GPU-based training pipeline of coupled Bayesian Optimization with PointPillar model and explored hyperparameters of the Bayesian framework such as kernels and acquisition functions in MATLAB.

---

This README provides an overview of the repository's purpose, the methods used, and the results obtained. For more detailed instructions on how to run the code and experiments, please refer to the individual MATLAB script files in this repository.
