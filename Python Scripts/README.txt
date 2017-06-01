PREREQUISITES: 
-To run either of the scripts, you must have access to a terminal emulator (e.g. Terminal on Mac OS X or Command Prompt on Windows). 
-You will also need to make sure that Python is installed on the computer you’re using. If you’re using Terminal, can check this by typing “which python” in the command line. This will show the path to the folder where Python is installed if you do have it. I wrote the scripts under Python version 2.7.10, so I can’t guarantee that they will work with earlier or later versions. You can check your Python version by typing “python -V” in the command line. 
-You’ll need to know how to navigate in the command line to get to the files and run them. There are a number of good tutorials that explain how to do this, e.g. http://www.macworld.com/article/2042378/master-the-command-line-navigating-files-and-folders.html, http://www.westwind.com/reference/os-x/commandline/navigation.html, etc. (you can also Google “UNIX command line tutorial” and see a number of other options). The most important commands you’ll need are cd (change directory), pwd (present working directory), and ls (list). I’ve included an example of how I navigate to the directory where I have these scripts saved on my machine, but this will be somewhat different for yours (one important thing to note below is that I put the name of the “EP&P Seminar” directory in quotes because it is more than one word long): 

    Benjamins-MacBook-Pro:~ benjamingittelson$ cd Documents
    Benjamins-MacBook-Pro:Documents benjamingittelson$ cd "EP&P Seminar"
    Benjamins-MacBook-Pro:EP&P Seminar benjamingittelson$ cd Presentation


HOW TO RUN FILEMAKER.PY: 
-Before running this script: Make sure you have the metadata file stored in the same directory as the script itself. It’s also a good idea to save the metadata file as a Windows csv in Excel, as the default Mac csv format seems to cause problems on some computers. You can do this by choosing “Save As…” in Excel and then picking the Windows comma-separated (.csv) option. 
-Running this script: Navigate to the directory where the script is stored, and then type in “python FileMaker.py.” If you’ve renamed the script, type in the new name in place of “FileMaker.py.” Once the script has started running, you’ll be prompted to answer a series of questions about where and how your data is stored. Please note that the script currently assumes that the identifiers are written in the format “recordings/[identifier].wav” (e.g. recordings/95c6f70a-58ea-4c34-b159-2f8ba8bd1ed1.wav). If your identifiers aren’t formatted in that way, either change them so that they are in Excel, R, STATA, etc., or contact me so that I can change the script to work for your particular format. 
-The output: The script will create a new folder in a user-specified location that contains all of the recordings and the corresponding .txt files with the chosen sentence. As it is currently written, the script will move the .wav files from their original location into the new folder to avoid taking up too much memory on your machine. If you don’t want this to happen, please contact me so that I can modify the script accordingly. 

HOW TO RUN DATAMERGE.PY: 
-Before running this script: Check that you have your metadata and VoiceSauce output files stored in the same directory as the script, and save both as Windows csvs in Excel, as described above. 
-Running this script: Follow the same process as above, but type “python DataMerge.py” instead of “python FileMaker.py.” This script also assumes that your metadata file has the identifiers in the “recordings/[identifier].wav” format. If that’s not the case, you will run into problems. 
-The output: This script will output a new csv file with added columns for the VoiceSauce information. If a given recording/line in the metadata file does not have VoiceSauce data associated with it, these columns will be filled with “NA” strings. 

A PARTING NOTE: These scripts are works in progress, so feel free to email me (Ben Gittelson) at bwg22@cam.ac.uk if you have any questions. 
