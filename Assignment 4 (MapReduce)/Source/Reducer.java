/*
  -------------------------------------------------------------------
  Reducer program (Reducer.java)
  ------------------------------------------------------
  This program takes input data in form of hashmaps 
  and uses hash map to maintain count of the words 
  in a final sorted treemap. 

  Input :  HashMaps from  Mapper classes
  Output:  word and word count in key value pairs

  Program Structure:

  Class        : Reducer
  Data Members : HashMap<String,Integer>[] maps (private)
                        Maintains the hashMaps sent by the 
                        Mapper class.
                TreeMap<String,Integer> finalMap (private)
                        Maintains the final word and word
                        count data.
  Constructors : Reducer(HashMap<> []) 
  Methods      : void postExecute (private)
                        perofrms the task post thread execution
                        ie. sending hashmap data to the reducer
                 void setMap(int map,HashMap map)
                        sets the data which has been processed 
                        in the mapping stage
                 void mergeMaps (private)
                        merge aa the hashmaps into a tree map
                 TreeMap getFinalMap() (public)
                        returns sorted key value data in 
                        a hash map
   -------------------------------------------------------------------
*/
import java.util.*;

public class Reducer extends Thread {

    private static HashMap<String, Integer>[] maps;
    private ArrayList<Map.Entry<String,Integer>> finalList;

    public Reducer(HashMap<String, Integer>[] maps) {
        this.maps = maps;
        finalList = new ArrayList<>();
    }

    public static void setMap(int index,HashMap<String,Integer> map){
        maps[index] = map;
    }

    public ArrayList<Map.Entry<String, Integer>> getFinalList() {
        return finalList;
    }

    public void mergeMaps() {
        TreeSet<String> keys = new TreeSet<>();
        for (int i = 0; i < maps.length; i++) {
            keys.addAll(maps[i].keySet());
        }

        Iterator<String> keyIterator = keys.iterator();
        while (keyIterator.hasNext()){
            int c = 0;
            String k = keyIterator.next();
            for (int i = 0; i < maps.length; i++) {
                if (maps[i].containsKey(k))
                    c = c + maps[i].get(k);
            }
            finalList.add(new AbstractMap.SimpleEntry<String,Integer>(k,c));
        }

        Collections.sort(finalList,new ValueComparator());
    }


    class ValueComparator implements Comparator<Map.Entry<String,Integer>> {


        @Override
        public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
            if (o1.getValue()>o2.getValue())
                return -1;
            else if (o2.getValue()>o1.getValue())
                return 1;
            else
                return 0;
        }
    }
}
