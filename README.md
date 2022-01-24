# Jetson-TL-WN823N-drivers
A script to automatically download and install the drivers for the tp-link TL-WN823N USB WiFi Dongle on a Jetson device. Makes use of the drivers obtained from https://github.com/Mange/rtl8192eu-linux-driver.

### Steps for Automated Driver Installation

* Download the installer script by cloning this repository;

    ```shell
    git clone https://github.com/SmartCowAi/Jetson-WifiDongle-Drivers.git
    ```
* Or downloading the script on its own;
    ```shell
    wget https://raw.githubusercontent.com/SmartCowAi/Jetson-WifiDongle-Drivers/main/install_script.sh

* Run the script

    ```shell
    cd Jetson-TL-WN823N-drivers
    sudo chmod +x install_script.sh
    sudo ./install_script.sh
    ```
 * Reboot the Jetson
    ```shell
    systemctl reboot -i
    ```
 * Verify driver installation
    ```shell
    sudo lshw -c network
    ```
    
    If the driver was installed correctly, the above command will list the usb device, with the parameter _driver=rtl8192eu_
