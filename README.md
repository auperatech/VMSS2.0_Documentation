# What is VMSS 2.0?

VMSS is a software application that functions as a video machine-learning streaming server. Its primary purpose is to provide video analytic services to multiple video streams while efficiently utilizing multiple FPGA resources on a server system.

The latest version, VMSS 2.0, offers several features to create flexible ML pipelines. Instead of plugins, VMSS 2.0 has graph nodes that can have arbitrary types, back edges, and side packets. This allows for arbitrary (and even cyclical) graphs instead of just linear graphs. The graphical user interface of VMSS 2.0 helps users build, configure, and run ML pipelines easily. Customers can use Aupera's node toolkit or create their nodes with the aid of Aupera's node creation framework.

VMSS 2.0 allows packets to be synchronized across multiple streams, enabling stream-aware processing. Users can try any of the models on Xilinx Model Zoo (currently box detector and classifier models) with just a few mouse clicks. Additionally, VMSS 2.0 provides hardware abstraction to run ML pipelines on different platforms, allowing for quick adoption of new hardware. A web-application serves as the visual GUI for the server.

## How to access VMSS 2.0?

You can access VMSS 2.0 immediately by signing up for a demo account via our partner VMAccel by visiting our Web site and clicking on [VMSS2.0 here](https://www.example.com/vmss2.0).

You can also request the latest versions of our VMSS 2.0 through our website.

## How to evaluate VMSS 2.0?

This repository provides you with various examples to get you started. We can split the examples into 4 different categories:

- Web Client Examples
- Command Line Examples
- Predefined Graphs
- Custom Examples

The examples are orgazined as shown below:
```
.
├── commandline_examples
│   ├── u30_v205
│   │   ├── box_detector_car
│   │   ├── box_detector_classifier_cascade
│   │   ├── box_detector_retail
│   │   └── custom_pipelines
│   └── vck5000
│       ├── custom_pipelines
│       ├── to_run_on_both_crowd_and_retail_videos
│       ├── to_run_on_crowd_videos
│       └── to_run_on_retail_videos
├── web_client_examples
│   ├── to_run_on_crowd_videos
│   │   ├── apl_crowd_flow
│   │   └── box_detector
│   └── to_run_on_retail_videos
│       ├── box_detector
│       └── box_detector_classifier_cascade
└── examples
    ├── Web Client Examples
    │   ├── to_run_on_crowd_videos
    │   │   ├── apl_crowd_flow
    │   │   └── box_detector
    │   └── to_run_on_retail_videos
    │       ├── box_detector
    │       └── box_detector_classifier_cascade
    ├── Command Line Examples
    │   ├── u30_v205
    │   │   ├── box_detector_car
    │   │   ├── box_detector_classifier_cascade
    │   │   ├── box_detector_retail
    │   │   └── custom_pipelines
```

### Web Client Examples

This a set of examples of predefined graphs that contain different examples showcasing the capabilities of combining different nodes from the Nodes Toolkit to run by simply inserting the provided pbtxt file in our Web Client application.

Note that given our web client has a restriction of having one input and one output to display, we have separated the examples for this section. You can find these examples for supported devices in the structure shown below:

### Command Line Examples

... [Content of Command Line Examples section goes here]
