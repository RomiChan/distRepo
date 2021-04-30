#!/bin/bash

cd distUpdater
go build -o ../Updater
cd ..
./Updater
