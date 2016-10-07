/*
  -------------------------------------------------------------------
  Association Rule Mining Program (AssociationRules.cpp)
  ------------------------------------------------------
  This program performs the main association rule mining task by
  first generating frequent itemsets using Apriori algorithm (using
  minimum support threshold) and then displays the valid association
  rules for all those falling under the minimum confidence threshold
  range. The program additionally prints the total memory used through
  the execution (only for Linux systems).

  Input :  Minimum Support Count (int), Minimum Confidence Threshold
           (float)
  Output:  arm_freqitems.txt and arm_arules.txt created in Results folder

  Program Structure:

  Class        : Association Rules
  Data Members : int numItems (private)
                        Stores the number of items
                 int numTrans (private)
                        Stores the number of transactions
                 float minsupport (private)
                        Stores the minimum support threshold
                 int supportcount (private)
                        Stores the minimum support count
                 float minconfidence (private)
                        Stores the minimum confidence threshold
                 vector<int> items (private)
                        Stores the items indexed from 0 to numItems
                 map<int, string> actualitems (private)
                        Stores a map with name as key and index as
                        value
                 vector<vector<int>> transmat (private)
                        Stores the transaction matrix read from the
                        preprocessing script
                 vector< map<vector<int>,int> > freqItems (private)
                        Stores the final k-frequent itemsets
  Constructors : AssociationRules (public)
                        Reads the data from the preprocessing output
                        files using readCSV() function and assigns
                        relevant values to all the data members
  Methods      : readCSV (private)
                        Reads the preprocessing output file arm_input.csv
                 generateCombinations (private)
                        Generates nCr combinations from a vector of n items
                        for a given r
                 createMap (private)
                        Utitity function for generateAssociationRules
                 getPairVector (private)
                        Utitity function for generateAssociationRules
                 displayTransactionMatrix
                        Displays the transaction matrix
                 displayItems (public)
                        Displays a set of items given as input in form
                        of index vector
                 displayAllItems (public)
                        Displays all the items with name and index
                 displayItemsetMap (public)
                        Utility function for displayKFrequentItemsets
                 findFrequentItemset (private)
                        Finds frequent itemsets from the candidates for
                        a specific value. Utitity function for
                        generateKFrequentItemsets
                 generateKFrequentItemsets (public)
                        Generates all the possible k-frequent itemsets
                 displayKFrequentItemsets (public)
                        Displays the generated k-frequent itemsets
                 writeFrequentItemsets (public)
                        Writes the k-frequent itemset information to
                        output file arm_freqitems.txt stored in
                        Results folder
                 generateAssociationRules (public)
                        Generates and write to an output file all the
                        valid association rules

  Class        : SystemInfo
  Methods      : parseLine (private)
                        Helper function for parsing text lines
                 getMemoryUsed (public)
                        Returns memory used by current process in Kb
 -------------------------------------------------------------------
*/

#include<bits/stdc++.h>

using namespace std;

class SystemInfo{
private:
    int parseLine(char* line){
        int i = strlen(line);
        const char* p = line;
        while (*p <'0' || *p > '9')
            p++;
        line[i-3] = '\0';
        i = atoi(p);
        return i;
    }

public:
    int getMemoryUsed(){
        FILE* file = fopen("/proc/self/status", "r");
        int result = -1;
        char line[128];

        while (fgets(line, 128, file) != NULL){
            if (strncmp(line, "VmRSS:", 6) == 0){
                result = parseLine(line);
                break;
            }
        }
        fclose(file);
        return result;
    }

};

class AssociationRules{
private:
    int numTrans;
    int numItems;
    float minsupport;
    int supportcount;
    float minconfidence;
    vector<int> items;
    map<int, string> actualitems;
    vector<vector<int>> transmat;
    vector< map<vector<int>,int> > freqItems;

    void readCSV(){
        ifstream file("~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Data/arm_input.csv");
        for(auto i = 0; i < numTrans; i++){
            string line;
            getline(file, line);
            if(!file.good())
                break;
            stringstream iss(line);
            for(auto j = 0; j < numItems; j++){
                string val;
                getline(iss, val, ',');
                stringstream convertor(val);
                convertor >> transmat[i][j];
            }
        }
        file.close();
        for(auto i = 0; i < numItems; i++)
            items.push_back(i);
    }

    vector< vector<int> > generateCombinations(vector<int> items, int r){
        vector< vector<int> > result;
        vector<bool> comb(items.size());
        fill(comb.begin(), comb.begin() + r, true);
        do{
            vector<int> x;
            for(auto i = 0; i < items.size(); i++)
                if(comb[i])
                    x.push_back(items[i]);
            result.push_back(x);
        } while (prev_permutation(comb.begin(), comb.end()));
        return result;
    }

    map<vector<int>, int> findFrequentItemset(int k){
        int count = 0, flag = 0;
        map<vector<int>, int> freqItemset;
        vector< vector<int> > combMatrix = generateCombinations(items, k);
        for(auto i = 0; i < combMatrix.size(); i++){
            count = 0; flag = 0;
            for(auto j = 0; j < numTrans; j++){
                for(auto k = 0; k < combMatrix[i].size(); k++){
                    flag = 0;
                    if(transmat[j][combMatrix[i][k]] == 0){
                        flag = 1;
                        break;
                    }
                }
                if(!flag)
                    count++;
            }
        if(count >= supportcount)
            freqItemset.insert(make_pair(combMatrix[i], count));
        }
        return freqItemset;
    }

    map< vector<int>,int > createMap(vector< vector<int> > result, map< vector<int>,int > m){
        for(auto i = 0; i < result.size(); i++){
            auto sup = freqItems[result[i].size() - 1].find(result[i]);
            m.insert(make_pair(result[i], (*sup).second));
        }
        return m;
    }

    vector<int> getPairVector(vector<int> u, vector<int> p){
        vector<int> result;
        for(auto i = 0; i < u.size(); i++){
            if(!binary_search(p.begin(), p.end(), u[i]))
                result.push_back(u[i]);
        }
        return result;
    }

public:
    AssociationRules(int sup, float conf){
        ifstream file;
        file.open("~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Data/data_size.txt");
        while(!file.eof()){
            file >> numTrans >> numItems;
        }
        file.close();

        transmat.resize(numTrans);
        for(int i = 0; i < numTrans; i++)
            transmat[i].resize(numItems);

        string name;
        file.open("~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Data/items.txt");
        int i = 0;
        while(!file.eof()){
            file >> name;
            name = name.substr(1,name.length()-2);
            actualitems.insert(make_pair(i, name));
            i++;
        }

        readCSV();
        supportcount = sup;
        minsupport = sup /(float)numItems;
        minconfidence = conf / 100;
        cout << "Minimum Support Threshold: " << minsupport << endl;
        cout << "Minimum Confidence Threshold: " << minconfidence << endl;
        cout << "Minimum Support Count: " << supportcount << endl;
    }

    void displayTransactionMatrix(){
        cout << "Transaction Matrix: " << endl;
        for(auto i = 0; i < numTrans; i++){
            for(auto j = 0; j < numItems; j++)
                cout << transmat[i][j] << " ";
            cout << endl;
        }
    }

    void displayAllItems(){
        cout << "Items: " << endl;
        for(auto i = actualitems.begin(); i != actualitems.end(); i++)
            cout << (*i).first << " - " << (*i).second << endl;
        cout << endl;
    }

    void displayItems(vector<int> s){
        cout << "{";
        for(auto i = 0; i < s.size(); i++){
            auto x = actualitems.find(s[i]);
            cout << (*x).second;
            if(i == s.size() - 1)
                cout << "}";
            else
                cout << ",";
        }
    }

    void displayItemsetMap(map<vector<int>,int> m){
        for(auto i = m.begin(); i != m.end(); i++){
            cout << "{";
            for(auto j = 0; j < (*i).first.size(); j++){
                auto k = actualitems.find((*i).first[j]);
                cout << (*k).second;
                if(j != (*i).first.size()-1 )
                    cout << ", ";
            }
            cout << "} : ";
            cout << (*i).second << endl;
        }
    }

    void displayKFrequentItemsets(){
        for(auto i = 0; i < freqItems.size(); i++){
            cout << i+1 << "-Frequent Itemset" << endl;
            displayItemsetMap(freqItems[i]);
            cout << endl;
        }
    }

    void writeFrequentItemsets(){
        ofstream file;
        file.open("~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Results/arm_freqitems.txt");
        for(auto x = 0; x < freqItems.size(); x++){
            file << endl;
            for(auto i = freqItems[x].begin(); i != freqItems[x].end(); i++){
                file << "{";
                for(auto j = 0; j < (*i).first.size(); j++){
                    auto k = actualitems.find((*i).first[j]);
                    file << (*k).second;
                    if(j == (*i).first.size()-1)
                        file << "}";
                    else
                        file << ",";
                }
                file << " : ";
                file << (*i).second << endl;
            }
        }
        file.close();
    }

    void generateKFrequentItemsets(){
        map<vector<int>,int> m;
        int k = 1;
        do{
            m = findFrequentItemset(k);
            if(!m.empty())
                freqItems.push_back(m);
            k++;
        }while(!m.empty());
        displayKFrequentItemsets();
        writeFrequentItemsets();
    }

    void generateAssociationRules(){
        ofstream file;
        file.open("~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Results/arm_arules.txt");
        auto m = freqItems[freqItems.size() - 1];
        for(auto i = m.begin(); i != m.end(); i++){
            map< vector<int>,int > m;
            int usup = (*i).second;
            for(auto j = (*i).first.size() - 1 ; j > 0; j--){
                vector< vector<int> > result = generateCombinations((*i).first, j);
                m = createMap(result, m);
            }
            for(auto k = m.begin(); k != m.end(); k++){
                vector<int> result = getPairVector((*i).first, (*k).first);
                auto sup = m.find((*k).first);
                if((usup / (float) (*sup).second) >= minconfidence){
                    displayItems((*k).first);
                    cout << " -> ";
                    displayItems(result);
                    cout << "\t[Support = " << (usup)/(float)numItems;
                    cout <<  ", Confidence = " << (usup /(float)(*sup).second) << "]";
                    cout << endl;

                    file << "{";
                    for(auto l = 0; l < (*k).first.size(); l++){
                        auto x = actualitems.find((*k).first[l]);
                        file << (*x).second;
                        if(l == (*k).first.size() - 1)
                            file << "}";
                        else
                            file << ",";
                    }
                    file << " -> ";
                    file << "{";
                    for(auto l = 0; l < result.size(); l++){
                        auto x = actualitems.find(result[l]);
                        file << (*x).second;
                        if(l == result.size() - 1)
                            file << "}";
                        else
                            file << ",";
                    }
                    file << "\t[Support = " << (usup)/(float)numItems;
                    file <<  ", Confidence = " << (usup /(float)(*sup).second) << "]";
                    file << endl;
                }
            }
        }
        file.close();
    }

};

int main(int argc, char *argv[])){
    if(argc == 1){
        cout << "No command line arguments given!" << endl;
        exit(1);
    }
    int sup = atoi(argv[1]);
    float conf = atof(argv[2]);
    int sup = 2;
    float conf = 50;
    AssociationRules arm(sup, conf);
    SystemInfo sys;
    cout << endl << "Frequent Itemsets: " << endl << endl;
    arm.generateKFrequentItemsets();
    cout << "Association Rules: " << endl << endl;
    arm.generateAssociationRules();
    cout << endl << endl;
    cout << "Total Memory Usage For Association Rule Mining: " << sys.getMemoryUsed() / 1024 << "Mb" << endl;
    return 0;
}
