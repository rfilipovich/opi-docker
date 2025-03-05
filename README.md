TODO: need add build instruction

# get sources
git clone git@github.com:rfilipovich/opi-docker.git -b pico_pressure_sniffer pico_pressure_sniffer
cd pico_pressure_sniffer
git clone git@github.com:rfilipovich/luckfox-pico.git -b pico_pressure_sniffer
 
# create and start docker container
make docker
make sh


cd ~/pico/luckfox-pico/

# original link with manual
https://wiki.luckfox.com/Luckfox-Pico/Luckfox-Pico-RV1103/Luckfox-Pico-SDK

1. configure
/////////////////////////////////////////////
cd ~/pico/luckfox-pico
docker@ws-337:~/pico/luckfox-pico$ ./build.sh lunch
ls: cannot access 'BoardConfig*.mk': No such file or directory
You're building on Linux
  Lunch menu...pick the Luckfox Pico hardware version:
  选择 Luckfox Pico 硬件版本:
                [0] RV1103_Luckfox_Pico
                [1] RV1103_Luckfox_Pico_Mini_A
                [2] RV1103_Luckfox_Pico_Mini_B
                [3] RV1103_Luckfox_Pico_Plus
                [4] RV1103_Luckfox_Pico_WebBee
                [5] RV1106_Luckfox_Pico_Pro
                [6] RV1106_Luckfox_Pico_Max
                [7] RV1106_Luckfox_Pico_Ultra
                [8] RV1106_Luckfox_Pico_Ultra_W
                [9] custom
Which would you like? [0~9][default:0]: 2
  Lunch menu...pick the boot medium:
  选择启动媒介:
                [0] SD_CARD
                [1] SPI_NAND
Which would you like? [0~1][default:0]: 1
  Lunch menu...pick the system version:
  选择系统版本:
                [0] Buildroot(Support Rockchip official features) 
Which would you like? [0~1][default:0]: 0
[build.sh:info] Lunching for Default BoardConfig_IPC/BoardConfig-SPI_NAND-Buildroot-RV1103_Luckfox_Pico_Mini_B-IPC.mk boards...
[build.sh:info] switching to board: /home/docker/pico/luckfox-pico/project/cfg/BoardConfig_IPC/BoardConfig-SPI_NAND-Buildroot-RV1103_Luckfox_Pico_Mini_B-IPC.mk
[build.sh:info] Running build_select_board succeeded.
docker@ws-337:~/pico/luckfox-pico$ 
////////////////////////////////////////////


2. set tools
cd ~/pico/luckfox-pico/tools/linux/toolchain/arm-rockchip830-linux-uclibcgnueabihf/
source env_install_toolchain.sh

3. compile
cd ~/pico/luckfox-pico
./build.sh


# 4. flashing device
sudo ./rkflash.sh update

# 5. 
Login: root
Password: luckfox
Static IP: 172.32.0.93

telnet 172.32.0.93

#################################
# rebuild buildroot
./build.sh clean rootfs ??
./build.sh rootfs

# rebuil kernel
./build.sh kernel


# rebuild firmware packages
./build.sh firmware

