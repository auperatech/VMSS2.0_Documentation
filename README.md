# What is VMSS 2.0?

VMSS is a software application that functions as a video machine-learning streaming server. Its primary purpose is to provide video analytic services to multiple video streams while efficiently utilizing multiple FPGA resources on a server system.

The latest version, VMSS 2.0, offers several features to create flexible ML pipelines. Instead of plugins, VMSS 2.0 has graph nodes that can have arbitrary types, back edges, and side packets. This allows for arbitrary (and even cyclical) graphs instead of just linear graphs. The graphical user interface of VMSS 2.0 helps users build, configure, and run ML pipelines easily. Customers can use Aupera's node toolkit or create their nodes with the aid of Aupera's node creation framework.

VMSS 2.0 allows packets to be synchronized across multiple streams, enabling stream-aware processing. Users can try any of the models on Xilinx Model Zoo (currently box detector and classifier models) with just a few mouse clicks. Additionally, VMSS 2.0 provides hardware abstraction to run ML pipelines on different platforms, allowing for quick adoption of new hardware. A web-application serves as the visual GUI for the server.

## How to access VMSS 2.0?

You can access VMSS 2.0 immediately by signing up for a demo account via our partner VMAccel by visiting our Web site and clicking on [VMSS2.0 here](https://vmaccel.com/vmssdemo/).

You can also request the latest versions of our VMSS 2.0 through our [website](https://auperatechnologies.com/).

## How to evaluate VMSS 2.0?

This repository provides you with various examples to get you started. We can split the examples into 4 different categories:

- Web Client Examples
- Command Line Examples
    - Predefined Graphs
    - Custom Buildable Applications

The examples are orgazined as shown below:
```
├── commandline_examples
│   ├── u30_v205
│   │   ├── box_detector_car
│   │   │   ├── 1input_1output.pbtxt
│   │   │   ├── input.pbtxt
│   │   │   └── output.pbtxt
│   │   ├── box_detector_classifier_cascade
│   │   │   ├── 1input_1output.pbtxt
│   │   │   ├── input.pbtxt
│   │   │   ├── input-vid.pbtxt
│   │   │   ├── output.pbtxt
│   │   │   └── output-vid.pbtxt
│   │   ├── box_detector_retail
│   │   │   ├── 1input_1output.pbtxt
│   │   │   ├── input.pbtxt
│   │   │   └── output.pbtxt
│   │   └── custom_pipelines
│   │       ├── extern
│   │       └── vehicle_classificaiton
│   └── vck5000
│       ├── custom_pipelines
│       │   ├── extern
│       │   └── vehicle_access_control
│       ├── to_run_on_both_crowd_and_retail_videos
│       │   └── box_detector_parallel
│       ├── to_run_on_crowd_videos
│       │   ├── apl_crowd_flow
│       │   └── box_detector
│       └── to_run_on_retail_videos
│           ├── box_detector_classifier_cascade
│           └── smart_retail
└── web_client_examples
    ├── to_run_on_crowd_videos
    │   ├── apl_crowd_flow
    │   │   ├── input.pbtxt
    │   │   ├── output.pbtxt
    │   │   └── using_rtsp.pbtxt
    │   └── box_detector
    │       ├── input.pbtxt
    │       ├── output.pbtxt
    │       └── using_rtsp_1output.pbtxt
    └── to_run_on_retail_videos
        ├── box_detector
        │   ├── input.pbtxt
        │   ├── output.pbtxt
        │   └── using_rtsp_1output.pbtxt
        └── box_detector_classifier_cascade
            ├── input.pbtxt
            ├── output.pbtxt
            └── using_rtsp_1output.pbtxt
```

### Web Client Examples

This a set of examples of predefined graphs that contain different examples showcasing the capabilities of combining different nodes from the Nodes Toolkit to run by simply inserting the provided pbtxt file in our Web Client application.

For each example we have provided under a suggested video. For instance, you can find examples that are suitable to run on a video containing people. Those examples are provided under the directory called `to_run_crowd_video`.

Note that given our web client has a restriction of having one input and one output to display, we have separated the examples for this section. You can find these examples for supported devices in the structure shown below:

### Command Line Examples

The command line examples consists of two categories of examples:

- Predefined Graphs
- Custom Buildable Applications

#### Predefined Graphs

These set of examples are exactly similar to what we have provided for Web Client examples. However, these examples don't have the restriction imposed by the Web Client. In order to run these examples the user needs to launce our AVAF_AVAS Docker container:

```
docker container exec -it aupera_server bash
```

Once you start the container, inside the docker you can run any of the provided examples by running `avaser` as shown below:

```
avaser -i [input.pbtxt] -o [output.pbtxt] -c [config_graph.pbtxt]
```

The input argument `-i` expects a pbtxt file where all the input rtsp streams are listed.
The output argumet `-o` exepcts a pbtxt file where all the output rtsp streams are listed.
The config argumet `-c` expects a pbtxt file where the entire pipeline is defined.


#### Custom Buildable Applications

This category of examples are provided to illustrate how to build a custom application by creating your own node.

To add a new node, you need to create a folder under custom_pipelines with the source code and .proto (message definition) files of your node. 
To build your node you run:
```
make clean; make -j6; make install
```
Inside the docker you can find them at /opt/aupera/avas/examples/custom_pipelines

This make file will copy the .proto file from your node folder into extern/protos folder. 
Then, it will build and install avap (which registers your proto with the framework).
Finally, it will build and install your node. 
**For U30 nodes the install command of make file will also ssh your node over to the U30 device.
At this point, you can run your node. 

Note:
The extern folder inside of the custom_pipelines folder contains the following:
1. avaf binary. This must not have versions. So if you just built avaf and created libavaf.so.3.0.0, then you need to rename this to libavaf.so and place it inside the extern folder. 

2. avaser binary. This is just called avaser. So if you just built avaser you need to copy the generated binary in this folder. 

3. calculator related headers. Any headers that are calculator (and not framework) specific are placed here. These include library headers (detector.hpp, multitracker.hpp, etc), and calculator specific packets (detect_track_packet.h, etc). You need to update this folder if you generated new packet types, or updated the header for one of the cv libraries that you expect the customer to require for their own nodes. 

4. aup/avaf folder containers the framework related headers and packets. If the framework level headers or packets types change, you need to copy the updated file into this folder

5. protos folder. This contains all the .proto files that the framework recognizes and requires to build avap. This also includes the avap make file. The content of this folder must be identical to the corresponding protos folder in the framework. If you add a new node to the framework, you place the new .proto file here. 


