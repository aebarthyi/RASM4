# RASM4
Alex and Andrew's CS3B ARM assembly project
A simple text editor built to target the Raspberry Pi.

Features:
  -Doubly-linked list for memory management.
  -Usage of Linux syscalls for the permanent storage of the document. (writing to a file)
  -Malloc and Free function calls for reserving memory space and freeing it when not needed.
  -Search algorithm to find where a word or phrase is located.
  -Updating byte count that shows how big the linked list is getting.
  
Run Instructions (Linux on ARM32 processor or equivalent emulator):
  -Clone the repository
  -Navigae to the /build folder in a command prompt window
  -Run the program with "./RASM4"
  -The contents are saved to "output.txt", and the file that is read is "input.txt"
