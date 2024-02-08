#!/bin/bash

echo "Updating app 2394010"
steamcmd +login anonymous +app_update 2394010 validate +quit

echo "Starting server"
./Steam/steamapps/common/PalServer/PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS
