
# 🔐 LockSafe
LockSafe is a simple and beginner-friendly graphical shell script for Linux that allows you to securely store sensitive files in an encrypted "safe". It uses cryptsetup with LUKS encryption and zenity for graphical dialogs, making it easy to lock and unlock your encrypted vault with just a few clicks.


---

## 🧠 Features

- 🔒 Password-protected LUKS-encrypted safe
- 📁 Mount/unmount GUI with Zenity
- 🧠 Simple and ADHD-friendly UX
- ⚙️ CLI automation or manual control
- 🖼 Custom icon integration

---

## 🚀 Installation

You can choose between:

### ✅ 1. **Automated Setup**

Run this in your terminal:

```bash
bash install_locksafe.sh
```

It will:
- Create the encrypted image
- Mount point and `.desktop` launcher
- Check/install dependencies like `cryptsetup`, `zenity`
- Setup desktop shortcut with a custom icon

---

### 🛠 2. **Manual Setup**

#### a. Clone the repo

```bash
git clone https://github.com/zoecyber001/locksafe.git
cd locksafe
```
### Make sure the following pakages are installed on your system:
##### i. cryptsetup
##### ii. zenity

To install them, run:
#### For Debian/Ubuntu/Parrot Os:

```bash
sudo apt update && sudo apt install cryptsetup zenity
```

#### b. Run the setup script

```bash
bash locksafe.sh
```

---

## 🧷 Add Custom Desktop Icon

> Make your LockSafe launcher look dope with this gold padlock icon. 😎

### 📥 Step 1: Move the icon

```bash
mkdir -p ~/.local/share/icons
cp locksafe.jpeg ~/.local/share/icons/locksafe.jpeg
```

### ✏️ Step 2: Edit the desktop launcher

Open `locksafe.desktop` and add:

```ini
Icon=/home/your-username/.local/share/icons/locksafe.jpeg
```

Replace `your-username` with your actual Linux username.

### 🔄 Step 3: Refresh desktop database

```bash
update-desktop-database ~/.local/share/applications
```

---

## 👨‍💻 Usage

Double-click the `LockSafe` launcher or run:

```bash
bash locksafe.sh
```

Then select `Unlock Safe` or `Lock Safe`.

## 🔑 How It Works

##### Unlock Safe: Prompts for your password, decrypts the .img file, and mounts it.
##### Lock Safe: Unmounts and re-encrypts the container to protect your files.

## 🚀 Contributing

If you'd like to improve this project, feel free to fork and submit a pull request. Ideas for additional features, UI polish, or cross-platform support are welcome!

## Tested on

<ul>Parrot OS</ul>
<ul>Ubuntu 22.04</ul>
<ul>Kali Linux</ul>

<i style="color: blue;">Stay safe, stay encrypted. 🔐</i>
