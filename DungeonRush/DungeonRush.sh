#!/bin/bash

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt

get_controls

$ESUDO chmod 666 /dev/tty1
$ESUDO chmod 666 /dev/uinput

export SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig"

GAMEDIR="/$directory/ports/dungeonrush"
cd $GAMEDIR
$GPTOKEYB "dungeon_rush" -c "$GAMEDIR/dungeon_rush.gptk" &
./dungeon_rush 2>&1 | tee $GAMEDIR/log.txt
unset SDL_GAMECONTROLLERCONFIG
$ESUDO kill -9 $(pidof gptokeyb)
$ESUDO systemctl restart oga_events &
printf "\033c" > /dev/tty1