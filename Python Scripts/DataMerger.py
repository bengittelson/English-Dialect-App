#Ben Gittelson
#Data cleaning for British English app corpus
#March 2, 2016

import csv
import re

def main(): 
    print "Welcome to DataMerger. Press CTRL + C to exit this program at any \
time."

    #read in the metadata file path
    my_metadata = raw_input("Please input the name of your metadata file.") 
    #read in the output file path
    my_output = raw_input("Please input the name of your VoiceSauce output \
file.")
    file_to_make = raw_input("Please input the name of the file you want this \
script to create. You should include a .csv extension at the end; otherwise, \
you will not be able to open the file in programs such as Microsoft Excel.") 

    dataMerge(my_metadata, my_output, file_to_make) 

#takes in the metadata and output files and creates a new merged file
def dataMerge(metadata, output, new_file): 
    my_dictionary = {}
    
    again = True
    while again: 
        try: 
            #open the output file for reading
            with open(output, 'r') as file: 
                reader = csv.reader(file) 
                first_line = reader.next()
                line_width =  + len(first_line)
                
                for row in reader: 
                    #save the name as raw_name
                    name = row[0]
                            
                    #correct the name using a name_correct method
                    name = nameCorrect(name) 
                    
                    #create a list to store the output values for each recording
                    my_list = []
                    
                    #retrieve every value in the given row and add to a list
                    for value in row: 
                        my_list.append(value)
                    my_dictionary[name] = my_list     
                    
            #close the output file
            file.close()     
            again = False  
    
        except IOError: 
            output = raw_input("Sorry, I couldn't find your VoiceSauce output \
file. Please try typing in its name again.")
        
    
    again2 = True
    while again2: 
        try: 
            #open the metadata file for writing and reading
            with open(metadata, 'r') as file: 
                reader2 = csv.reader(file)
                
                with open(new_file, 'w') as csvoutput: 
                    writer = csv.writer(csvoutput)   
                    
                    #manually add in the headers from the VoiceSauce output
                    writer.writerow(reader2.next() + first_line)
                                        
                    for row in reader2:

                        #if you have VoiceSauce measurements for a given 
                        # recording
                        if row[0] in my_dictionary: 
                            #print row[0]
                            #NOTE: I used line_width - 1 here because VoiceSauce
                            # seemed to be inserting an empty column into its 
                            #output files. If we can fix that, this should be 
                            #changed to range(0, line_width). 
                            for i in range(0, line_width-1): 
                                row.append(my_dictionary[row[0]][i])
                            writer.writerow(row)
        
                        #if you don't
                        else: 
                            for i in range(0, line_width-1): 
                                row.append("NA")
                            writer.writerow(row)
                            
                    csvoutput.close()
                file.close()
                again2 = False
                
        except IOError: 
            metadata = raw_input("Sorry, I couldn't find your metadata file. \
Please try typing in its name again.")

    print "I finished creating your output file." 
                    

def nameCorrect(in_name): 
    out_name = re.sub('.mat', '', in_name)
    out_name = out_name[6:]
    out_name = "recordings/" + out_name + ".wav" 
    return out_name

main()