<b><h1>Lock Safe Script</h1></b>

This script provides an easy way to securely lock and unlock a folder using LUKS encryption on Linux. The folder acts as a "lock safe" for your sensitive files. This script has been tested on Linux.

<h2>Features</h2>

<ul>Lock Safe: Encrypt and secure your files in a virtual safe.</ul>
<ul>Unlock Safe: Access your encrypted files by unlocking the safe with a password.</ul>
<ul>User-Friendly: Uses Zenity for graphical password prompts and notifications.</ul>
<ul>Error Handling: Provides detailed error messages to ensure smooth operation.</ul>
<h4>Prerequisites</h4>
<ul>Linux operating system, make others might work</ul>
<ul>cryptsetup installed</ul>
<ul>zenity installed</ul>


<h2>Installation and Setup</h2>
Follow these steps to set up and use the Lock Safe script:

<h3>Step 1: Install Required Tools</h3>
<ul>Install cryptsetup and zenity.</ul>
<h3>Open a terminal and run the following commands:</h3>
<ul><i>sudo apt-get update</i></ul>
<ul><i>sudo apt-get install cryptsetup zenity</i></ul>

<h3>Step 2: Create and Initialize the Encrypted Container</h3>
<ul>Create a container file (only needed once).</ul>
<ul>Run the command: <i>dd if=/dev/zero of=~/locksafe.img bs=1M count=100</i></ul>
<ul>Set up LUKS encryption on the container.</ul>

Run the command: 
<ul><i>sudo cryptsetup luksFormat ~/locksafe.img</i></ul>
<ul>Open and format the encrypted container.</ul>

Run the following commands:
<ul><i>sudo cryptsetup luksOpen ~/locksafe.img locksafe</i></ul>
<ul><i>sudo mkfs.ext4 /dev/mapper/locksafe</i></ul>
<ul><i>sudo cryptsetup luksClose locksafe</i></ul>

<h3>Step 3: Using the Script</h3>
<ul>Unlock the Safe</ul>
<ul>Run the script to unlock the safe.</ul>

Run the command: <i>./locksafe.sh</i>
<ul>Select "Unlock Safe" and enter your password when prompted.</ul>

Follow the graphical prompts provided by Zenity.
<ul>Your encrypted container will be mounted at ~/locksafe_mount.</ul>

You can now add files to this directory.
<ul>Lock the Safe</ul>
<ul>Run the script to lock the safe.</ul>

Run the command: <i>./locksafe.sh</i>
<ul>Select "Lock Safe" to unmount and lock the encrypted container.</ul>

Follow the graphical prompts provided by Zenity.
<ul>Adding Files to the Safe</ul>
<ul>Unlock the safe.</ul>

Run the command: <i>./locksafe.sh</i>
<ul>Move or copy files to ~/locksafe_mount as you would with any other directory.</ul>

For example, run the command:<i> cp /path/to/your/files/* ~/locksafe_mount</i>
<ul>Lock the safe.</ul>

Run the command:<h4><i>./locksafe.sh</i></h4>

<h2>Troubleshooting</h2>
<ul>Error: "Failed to unmount": Ensure the safe is not already locked.</ul>
<ul>Error: "Failed to close LUKS device": Ensure the device is not already closed.</ul>
<ul>Error: "Lock safe image does not exist": Ensure the image file ~/locksafe.img exists.</ul>
<ul>Error: "Failed to open LUKS device with provided password": Ensure you are entering the correct password.</ul>
    
If you encounter any other issues or need further assistance, please refer to the error messages provided by the script for guidance.
