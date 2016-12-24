/*
  -------------------------------------------------------------------
  Mapper program (Mapper.java)
  ------------------------------------------------------
  This program takes input data in form of key-value 
  pairs and uses hash map to maintain count of the words
  it traverses through.A thread is created and called 
  from the main class to simulate mapper classes used in 
  hadoop systems.

  Input :  String array from main class
  Output:  word and word count in key value pairs

  Program Structure:

  Class        : Mapper
  Data Members : String[] data (private)
                        Contains the set of words to be 
                        analysed
                 HashMap<String,Integer> wordCount (private)
                        Maintains the word frequency for
                        the words set in the current thread
                 int index (private)
                        Used to associate mapper and the final 
                        hashmap which is in the reducer class
  Constructors : Mapper(int index) 
  Methods      : void postExecute (private)
                        perofrms the task post thread execution
                        ie. sending hashmap data to the reducer
                 void setData(String[] data) (private)
                        sets the data which have to processed 
                        in the mapping stage
                 void run (private)
                        handles the events in thread execution
   -------------------------------------------------------------------
*/

import java.util.HashMap;

public class Mapper extends Thread {
    private String[] data;
    private HashMap<String,Integer> wordCount;
    private int index;

    public Mapper(int index) {
        this.index = index;
        wordCount = new HashMap<>();
    }

    public void setData(String[] data) {
        this.data = data;
    }

    @Override
    public void run() {
        for (int i = 0; i < data.length; i++) {
            if (!wordCount.containsKey(data[i]))
                wordCount.put(data[i],1);
            else
                wordCount.put(data[i],wordCount.get(data[i])+1);
        }

        postExecute();
    }

    private void postExecute() {
        Reducer.setMap(index,wordCount);
    }
}
