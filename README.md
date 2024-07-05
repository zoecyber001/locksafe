Lock Safe Script
This script provides an easy way to securely lock and unlock a folder using LUKS encryption on Linux. The folder acts as a "lock safe" for your sensitive files. This script has been tested on Linux.

Features
Lock Safe: Encrypt and secure your files in a virtual safe.
Unlock Safe: Access your encrypted files by unlocking the safe with a password.
User-Friendly: Uses Zenity for graphical password prompts and notifications.
Error Handling: Provides detailed error messages to ensure smooth operation.
Prerequisites
Linux operating system
cryptsetup installed
zenity installed
Installation and Setup
Follow these steps to set up and use the Lock Safe script:

Step 1: Install Required Tools
Install cryptsetup and zenity.
Open a terminal and run the following commands:
sudo apt-get update
sudo apt-get install cryptsetup zenity

Step 2: Create and Initialize the Encrypted Container
Create a container file (only needed once).

Run the command: dd if=/dev/zero of=~/locksafe.img bs=1M count=100
Set up LUKS encryption on the container.

Run the command: sudo cryptsetup luksFormat ~/locksafe.img
Open and format the encrypted container.

Run the following commands:
sudo cryptsetup luksOpen ~/locksafe.img locksafe
sudo mkfs.ext4 /dev/mapper/locksafe
sudo cryptsetup luksClose locksafe

Step 3: Using the Script
Unlock the Safe
Run the script to unlock the safe.

Run the command: ./locksafe.sh
Select "Unlock Safe" and enter your password when prompted.

Follow the graphical prompts provided by Zenity.
Your encrypted container will be mounted at ~/locksafe_mount.

You can now add files to this directory.
Lock the Safe
Run the script to lock the safe.

Run the command: ./locksafe.sh
Select "Lock Safe" to unmount and lock the encrypted container.

Follow the graphical prompts provided by Zenity.
Adding Files to the Safe
Unlock the safe.

Run the command: ./locksafe.sh
Move or copy files to ~/locksafe_mount as you would with any other directory.

For example, run the command: cp /path/to/your/files/* ~/locksafe_mount
Lock the safe.

Run the command: ./locksafe.sh
Troubleshooting
Error: "Failed to unmount": Ensure the safe is not already locked.
Error: "Failed to close LUKS device": Ensure the device is not already closed.
Error: "Lock safe image does not exist": Ensure the image file ~/locksafe.img exists.
Error: "Failed to open LUKS device with provided password": Ensure you are entering the correct password.
If you encounter any other issues or need further assistance, please refer to the error messages provided by the script for guidance.
