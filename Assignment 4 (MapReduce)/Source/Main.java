/*
  -------------------------------------------------------------------
  MapReduce Program (Main.java)
  ------------------------------------------------------
  This program handles the execution and data flow for 
  the map and reduce jobs and also calls methods from 
  Util class to read/write and handle the text data.

  Input :  input.txt file from res folder
  Output:  output.txt and barplot image in output folder

  Program Structure:

  Class        : Main
  Data Members : String file (private)
                        Stores the location fo text file
  Constructors : runs statically via main method
  Methods      : void main (private)
                        Main driver function of the module
   -------------------------------------------------------------------
*/
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Main {

    static String file = "../Data/The_Adventures_of_Sherlock_Holmes.txt";
    public static void main(String[] args) {

        File f = new File(file);
        String fileData = null;
        try {
            fileData = Util.read(f);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Mapper[] mappers = new Mapper[10];
        HashMap<String,Integer>[] maps = new HashMap[10];
        Reducer reducer = new Reducer(maps);

        for (int i = 0; i < 10; i++) {
            mappers[i] = new Mapper(i);
        }

        Util.assignData(mappers,fileData);
        for (int i = 0; i < 10; i++) {
            mappers[i].start();
        }

        for (int i = 0; i < 10; i++) {
            try {
                mappers[i].join();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        reducer.mergeMaps();

        ArrayList<Map.Entry<String,Integer>> finalList = reducer.getFinalList();

        try {
            Util.write(finalList);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
