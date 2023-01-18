Project : BOOT LOADER
Team Name : boot -y loader

To run the project code enter the following command in terminal:
make --always-make run

We don't need any more commands to execute the file as Makefile will take care of it.
System requirements:
for our code to run, the system must have x86 architecture.
NASM for assembly compilation is required.
QEMU emulator must be installed on the system.
follow the below link to install qemu:
https://help.ubuntu.com/community/KVM/Installation


# Bootloader
Bootloader is program usually present in first sector of a disk whose responsibility is to load OS Kernel from disk into main memory and pass over the control to it so that Kernel can execute its tasks.
We have built a sample Kernel and a basic Bootloader which loads the Kernel into memory.

# Inernal Working of our Bootloader & Kernel
- When system is started, BIOS looks through first sector of the disk which contains our Bootloaded (Magic Number AA55 is specfied at end of Sector) and hence BIOS identifies our program as a Bootloader and gives control to our program.
- Now our Bootloader uses BIOS interrupt 0x13 (Disk Read Interrput) by specifying the Disk, Cylinder Number, How Many Sectors of information to read and also the location in Main memory into where the read data is to be copied.
- It is that our Kernel will be present in the disk at the specified Sector. Hence after completion of above point, Kernel is succesfully loaded into Main memory at specified address.
- Bootloaded passes the control to the Kernel which is available at specified location and hence from here on Kernel program is executed.
- Kernel is programmed to display Hello message to User.
- Kernel uses Video memory 0xb8000 (Color Display Array) to display characters on screen.
- Kernel is also programmed to record Key strokes entered by user and display on the screen using Video Memory.
- To record the key stroke, Kernel uses command INB (Input Byte) from Port 0x60 (Keyboard Port) so that the key-in character is recorded from the PORT and is displayed using Video Memory.


This is overview of how our Bootloader and Kernel work. To understand in detail about various internel stages of our application, have a look at "Bootloader_report.pdf"
