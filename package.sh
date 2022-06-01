#!/bin/bash
cp ./build/bin/* ./DungeonRush/dungeonrush/
cd ./DungeonRush
zip ../DungeonRush.zip -r *
