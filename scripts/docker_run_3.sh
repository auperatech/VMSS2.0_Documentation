#!/bin/bash 

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: $0 <image name> <container name>"
    exit 2
fi

HERE=$(pwd -P) # Absolute path of current directory
echo "Current directory '${HERE}' will be used as NFS workspace"

user=`whoami`
uid=`id -u`
gid=`id -g`

if [ -z "$1" ];then
  echo "Please input docker image name"
  echo "Usage: $0 <image name> <container name>"
  exit 1
fi
IMAGE_NAME="$1"

if [ -z "$2" ];then
  echo "Please input docker container name"
  echo "Usage: $0 <image name> <container name>"
  exit 1
fi
CONTAINER_NAME="$2"

DEFAULT_COMMAND="bash"

DETACHED="-dit"

xclmgmt_driver="$(find /dev -name xclmgmt\*)"
docker_devices=""
for i in ${xclmgmt_driver} ;
do
  docker_devices+="--device=$i "
done

render_driver="$(find /dev/dri -name renderD\*)"
for i in ${render_driver} ;
do
  docker_devices+="--device=$i "
done

INJECTED_COMMAND_FILE=/var/run/aupera_docker_command

docker_run_params=$(cat <<-END
    -v /dev/shm:/dev/shm \
    -v $INJECTED_COMMAND_FILE:/aupera_docker_command \
    -v /opt/xilinx/dsa:/opt/xilinx/dsa \
    -v /opt/xilinx/overlaybins:/opt/xilinx/overlaybins \
    -v /etc/xbutler:/etc/xbutler \
    -v /opt/aupera/avas/etc/key:/opt/aupera/avas/etc/key \
    -v /opt/aupera/avas/examples/videos:/opt/aupera/avas/examples/videos \
    -v ${HERE}:${HERE} \
    -e USER=${user} -e UID=${uid} -e GID=${gid} \
    -e NFS_ABS_PATH=${HERE} \
    -w ${HERE} \
    --privileged=true \
    --network=host \
    --hostname=general \
    --log-opt max-size=10m --log-opt max-file=3 \
    ${DETACHED} \
    --name ${CONTAINER_NAME} \
    ${IMAGE_NAME} \
    ${DEFAULT_COMMAND}
END
)

##############################

## attempt to install inotify-wait

# apt install inotify-tools -y

## before running the docker, reset the command file
echo "" > $INJECTED_COMMAND_FILE

docker run ${docker_devices} ${docker_run_params}

## after docker is started, monitir command file for commands
# for ATTEMPT_IDX in {1..300}
# do
#   inotifywait -t 1 -e close_write $INJECTED_COMMAND_FILE &&
#   INJECTED_COMMAND=$(cat $INJECTED_COMMAND_FILE)
#   if [ -z $INJECTED_COMMAND ]
#   then
#     continue
#   fi
#   echo "" > $INJECTED_COMMAND_FILE
#   eval $INJECTED_COMMAND
