# Generating Manifest files




To Agree on:
  1. GUID is a unique reference to either a node pbtxt or graph pbtxt
  with the combination of "version" and GUID a pbtxt can be identified. This combo is used either as QueryParams of a GET REST API or to simply construct a path to a file in a github repo.

The valid format for a GUID is {XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX} where X is a hex digit (0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F). Note that utilities such as GUIDGEN can generate GUIDs containing lowercase letters.Jan 7, 2021

  Format of GUID(s) must be agreed on

  2. the format of donwload_link(s) should be agreed on 

    for pbtxts:
      public github for now:
      // scratch this https://github.com/auperatech/examplepbtxts/blob/%s/%s.pbtxt, version, guid
      https://github.com/auperatech/VMSS2.0_Documentation/blob/3.0.0/pbtxts/2ba440fa-079e-4d07-93d0-10e1488124ad.pbtxt

  3. The version used for pbtxt and nodes are the avaf version.  



{
  "version": (make sure it matches branch name)<TYPE:STRING, MANDATORY>,
  #model zoo information
  "models": [
    {
      "guid": <TYPE:STRING, MANDATORY, FORMAT:GUID>
      "model_zoo_name" <TYPE:STRING, MANDATORY>
      "kernel" <TYPE:STRING, MANDATORY>
      "ml_task": <TYPE:STRING, MANDATORY, FORMAT:GUID>
      "hardware_type": <TYPE:STRING, MANDATORY, FORMAT:GUID>
      "hardware_arch": <TYPE:STRING, MANDATORY, FORMAT:GUID>
      "hardware_dpu_config": <TYPE:STRING, MANDATORY, FORMAT:GUID>
      "model_format": <TYPE:STRING, OPTIONAL, FORMAT:GUID>
      "ml_lib": <TYPE:STRING, OPTIONAL, FORMAT:GUID>
      "inference_lib": <TYPE:STRING, OPTIONAL, FORMAT:GUID>
      "checksum": <TYPE:STRING, MANDATORY>
      "download_link": <TYPE:STRING, MANDATORY>
      "ops": <TYPE:float, OPTIONAL>
      "input_size": <TYPE:STRING, OPTIONAL>
      "dataset":  <TYPE:STRING, OPTIONAL>
      "node_pbtxt": <TYPE:STRING, MANDATORY, FORMAT:GUID>
      "pipeline_pbtxt": <TYPE:STRING, MANDATORY, FORMAT:GUID>
    },
  ],

  #node toolkit information
  "nodes": [
    {
      "guid": <TYPE:STRING, MANDATORY, FORMAT:GUID>
      "type": <TYPE:STRING, MANDATORY>
      "name": <TYPE:STRING, MANDATORY>,
      "vendor": <TYPE:STRING, OPTIONAL, DEFAULT:"Aupera">
      "pbtxt": <TYPE:STRING, OPTIONAL, FORMAT:GUID>, ...
      "hardware_types": [<TYPE:STRING, OPTIONAL>]
      "hardware_archs": [<TYPE:STRING, OPTIONAL>]
      "hardware_dpu_config": [<TYPE:STRING, OPTIONAL>]
    },
    ...
  ],

  "enums": {
    "hardware_types": [<TYPE:STRING, MANDATORY>, ...],
    "hardware_archs": [<TYPE:STRING, MANDATORY>, ...],
    "hardware_dpu_configs": [<TYPE:STRING, MANDATORY>, ...],
    "ml_tasks": [<TYPE:STRING, MANDATORY>, ...],
    "model_formats": [<TYPE:STRING, MANDATORY>, ...],
    "ml_libs": [<TYPE:STRING, MANDATORY>, ...],
    "inference_libs": [<TYPE:STRING, MANDATORY>, ...],
  },

  "examples": [
    {
      "guid": <TYPE:STRING, MANDATORY, FORMAT:GUID>,
      "name": <TYPE:STRING, OPTIONAL>,
      "description": <TYPE:STRING, OPTIONAL>,
      "models": [<TYPE:STRING, MANDATORY, FORMAT:GUID>, ...],
      "nodes": [<TYPE:STRING, MANDATORY, FORMAT:GUID>, ...]
    }
    ...
  ],
}



EXAMPLE:

{
  "version": "1.0.0",

  //used to create model zoo by avac
  "models": [
    {
      "guid": 8018d2e5-0d26-4468-8402-98ef880adf96
      "model_zoo_name": "tf_SSD_mobilenetv1_0.25_imagenet_128_128_27M_2.5.zip"
      "kernel" "RefineDet-Medical_EDD_tf"
      "ml_task": "detection", //validate against ml_tasks enum
      "hardware_type": "VCK5000"
      "hardware_arch": "DPUCVDX8H"
      "hardware_dpu_config": "6pe" 
      "model_format": "xmodel"
      "ml_lib": "tensorflow1.0"
      "inference_lib": "vitis1.4.1"
      "checksum": "93a8a19cbea8340055f04f8a9dd25db5"
      "download_link": "https://www.xilinx.com/bin/public/openDownload?filename=plate_detect-vck5000-DPUCVDX8H-4pe-r2.5.0.tar.gz" 
      "ops": "0.54G"
      "input_size": "412x120"
      "dataset": "coco"
      "node_pbtxt": "551b0bdc-66ed-4f37-b3db-1078b16cf1a9" 
      "pipeline_pbtxt": "2d77256a-7077-4132-b8da-1ebaca1768a4"
    }
  ],

  //used to create nodetooklit by avac
  "nodes": [
    {
      "guid": "2ba440fa-079e-4d07-93d0-10e1488124ad"
      "type": "aupera_free" //can be checked against node_types enum
      "name": "box_detector",
      "vendor": "Aupera"
      "pbtxt": "76376ec4-f2e4-4e8a-b375-94f8d37ebfe2"
      "hardware_types": ["VCK5000", "U50"]
      "hardware_archs": ["DPUCVDX8H", "DPUCVD3k1R"]
      "hardware_engines": ["6pe", "4pe"]
    }
  ],

  "enums":{
    "hardware_types": ["VCK5000", "U50"]
    "hardware_archs": ["DPUCVDX8H", "DPUCVD3k1R"]
    "hardware_engines": ["6pe", "4pe"]
    "ml_tasks": ["detection", "classification", "encoding", "segmentation"],
    "model_formats": ["xmodel", "tf", "pt"],
    "ml_libs": ["tensorflow1.0", "tensorflow2.0", "pytorch1.1", "pytorch2.1"],
    "inference_libs": ["vitis1.4.1", "vitis2.0.0", "ZenDNN1.1.0"],
  },

  "examples": [
    {
      "guid": "e2e664a2-c8d8-4598-a98c-e041da477aa7",
      "name": "retain throughput matching",
      "description": "measures the throughput of detections and classifications",
      "models": [8018d2e5-0d26-4468-8402-98ef880adf96, b61d1657-5f37-4679-9e10-0001f686d312],
      "nodes": ["2ba440fa-079e-4d07-93d0-10e1488124ad", "e2e664a2-c8d8-4598-a98c-e041da477aa7", "b61d1657-5f37-4679-9e10-0001f686d312"]
    }
  ],
}








