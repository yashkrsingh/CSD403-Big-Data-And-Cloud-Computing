/*
  -------------------------------------------------------------------
  Utility program (Util.java)
  ------------------------------------------------------
  This program contains various static methods to 
  read, write the I/O files, clean the string data
  and assign tasks
  
  Program Structure:

  Class        : Util
  Data Members : String exclude (default)
                    Handles the delimters in cleaning data
  Constructors : no constrcutor 
  Methods      : String read (public)
                        reds the file and outputs it into 
                        a text file,
                 void write (public)
                        writes final output to text file
                 void assignData(String[] data,Mapper[] mappers) (public)
                        sets the data which have to processed 
                        in the mapping stage
                 void clean(private)
                        removes unnecersary delimiters from the text
   -------------------------------------------------------------------
*/

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

public class Util {


    public static String read(File inputFile) throws FileNotFoundException {
        String stringToFile ="";
        Scanner sc = new Scanner(inputFile);
        while (sc.hasNext())
            stringToFile=stringToFile+sc.nextLine();
        stringToFile =  clean(stringToFile);
        return stringToFile;
    }

    public static String clean(String stringToFile) {
        return stringToFile.replaceAll(Omit.exclude," ");
    }

    public static void write(String read) throws IOException {
        File out = new File("../Results/output.txt");
        FileWriter writer = new FileWriter(out);
        writer.write(read);
        writer.flush();
        writer.close();
    }

    public static void assignData(Mapper[] mappers,String data){
        String[] words = data.split(" | \\n");
        for (int i = 0; i < words.length; i++) {
            words[i]=words[i].trim();
            words[i]=words[i].toLowerCase();
        }
        int size = mappers.length;
        int numWords = words.length;
        int wordsPerMapper = numWords/size;

        for (int i = 0; i < size-1; i++) {
            mappers[i].setData(Arrays.copyOfRange(words,wordsPerMapper*i,wordsPerMapper*(i+1)));
        }
        mappers[size-1].setData(Arrays.copyOfRange(words,wordsPerMapper*(size-1),numWords-1));
    }

    public static void write(ArrayList<Map.Entry<String, Integer>> finalMap) throws IOException {
        File out = new File("../Results/output.txt");
        FileWriter writer = new FileWriter(out);
        Iterator<Map.Entry<String,Integer>> iterator = finalMap.iterator();
        iterator.next();
        int count = 0;
        while (iterator.hasNext()){
            if(count==1257)
                break;
            Map.Entry<String,Integer> val = iterator.next();
            writer.write(val.getKey()+" : "+val.getValue()+"\n");
            count++;
        }
        writer.flush();
        writer.close();

    }
}
