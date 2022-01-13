# Emulate Dualsense as a 360 controller on Linux

The purpose of this fork is to allow this repo to run under root in order to bypass permission issues accessing /dev/uinput.

## Pre-requirements

- Have a recent kernel (5.12+) that includes the latest official drivers (hid-playstation)
- Install xboxdrv (https://xboxdrv.gitlab.io)
- Basic dev tools like `g++` or `make`
- Make sure you are using this repo under ROOT. If you are using this as a user, please use the original repo. 

## How to compile
```
git clone https://github.com/Valcyclovir/ds360
cd ds360
make
```
## Usage
#### Starting the process in terminal, press CTRL+C to stop
```
./ds360
```
#### Starting ds360.service manually, controller must be connected
```
systemctl start ds360.service
```
#### Automatically start ds360.service via udev rule when controller connects
```
./add-udev-rule.sh
```
## How to install
```
git clone https://github.com/Valcyclovir/ds360
cd ds360
make install
```

## How to uninstall

```
make uninstall
```

## Troubleshooting

The script should work fine if the Dualsense controller is connected through USB or via Bluetooth, but if you still get the "VID not found" error, please check your `/proc/bus/input/devices` file and see if your controller is there.

If it's not recheck if your kernel includes the `hid-playstation` driver and try to use `xboxdrv` manually with `dualsense.xboxdrv` config (edit the commented `evdev=...` line).


Hint: you can find the value to use for evdev with this command (thanks to /u/QushAes)
```sh
    for sysdevpath in $(find /sys/bus/usb/devices/usb*/ -name dev); do
    (
        syspath="${sysdevpath%/dev}"
        devname="$(udevadm info -q name -p $syspath)"
        [[ "$devname" == "bus/"* ]] && exit
        eval "$(udevadm info -q property --export -p $syspath)"
        [[ -z "$ID_SERIAL" ]] && exit
        echo "/dev/$devname - $ID_SERIAL"
    )
    done
```