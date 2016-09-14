/*
*-------------------------------------------------------------------
* Clustering Program (Clustering.cpp)
* -----------------------------------
* This program performs the main clustering task using kMeans
* algorithm as given by Lloyd. Initial points are chosen based on the
* theory of polar coordinates by giving random angle values to choose
* points from throughout the space.
*
* Input :  Number of clusters (int), Number of iterations for
*          kMeans (int)
* Output:  kmeans_input.txt created in Results folder
*
* Program Structure:
*
* Class        : KMeansClustering
* Data Members : vector<int> x (private)
                        Stores the x coordinates of data points
                 vector<int> y (private)
                        Stores the x coordinates of data points
                 vector<int> clusters (public)
                        Stores the clusters that data points belong to
                 vector<int> count (public)
                        Stores the number of points in each cluster
* Constructors : KMeansClustering
                        Reads the data from the preprocessing output
                        file kmeans_input.txt and assigns it to the
                        data members x and y
* Methods      : initialSelection
                        Makes the initial selection of mean points
                 assignClusters
                        Assigns clusters to all the data points
                 calculateMeans
                        Calculates mean points for each of the
                        clusters
                 showClusterCount
                        Shows the number of data points in each
                        cluster
                 kMeans
                        Performs the kMeans clustering on a dataset
                        stored in x and y
*-------------------------------------------------------------------
*/

#include<iostream>
#include<vector>
#include<algorithm>
#include<fstream>
#include<cmath>
#include<stdlib.h>
#include<time.h>
#define PI 3.141592653589793238462643383279502884L

using namespace std;

class KMeansClustering{
private:
    vector<int> x;
    vector<int> y;

    void initialSelection(int k, vector<long double> &meanxaxis, vector<long double> &meanyaxis){
        srand(time(nullptr));
        for(int i = 0; i < k; i++) {
            double alpha = 2.0d *PI*((double) rand() / RAND_MAX);
            meanxaxis[i] = abs(50000*cos(alpha));
            meanyaxis[i] = abs(50000*sin(alpha));
        }
    }

    inline void assignClusters(int k, vector<long double> &meanxaxis, vector<long double> &meanyaxis){
        float distMin, dist = 0;
        for(int i = 0; i < x.size(); i++){
            distMin = 9999999;
            for(int j = 0; j < k; j++){
                dist = sqrt(pow((meanxaxis[j] - x[i]),2) + pow((meanyaxis[j] - y[i]),2));
                if(dist <  distMin){
                    distMin = dist;
                    clusters[i] = (j+1);
                }
            }
        }
    }

    inline void calculateMeans(int k, vector<long double> &meanxaxis, vector<long double> &meanyaxis){
        int clust;
        meanxaxis.assign(k, 0);
        meanyaxis.assign(k, 0);
        count.assign(k, 0);

        for(int i = 0; i < x.size(); i++){
            clust = clusters[i] - 1;
            meanxaxis[clust] =  meanxaxis[clust] + x[i];
            meanyaxis[clust] =  meanyaxis[clust] + y[i];
            count[clust] += 1;
        }

        for(int i = 0; i < k; i++){
            meanxaxis[i] = meanxaxis[i] / (float) count[i];
            meanyaxis[i] = meanyaxis[i] / (float) count[i];
        }
    }

public:
    vector<int> clusters;
    vector<int> count;

    KMeansClustering(){
        ifstream file;
        file.open("~/Assignment 1(Clustering)/Data/kmeans_input.txt");
        while(!file.eof()){
            int a, b;
            file >> a >> b;
            x.push_back(a);
            y.push_back(b);
        }
        file.close();
    }

    void showClusterCount(){
        cout << "Count array: " << endl;
        for(int i = 0; i < count.size(); i++){
            cout << count[i] << " ";
        }
        cout << endl;
    }

    void kMeans(int k, int iteration){
        clusters.resize(x.size());
        count.resize(k);
        vector<long double> meanxaxis(k);
        vector<long double> meanyaxis(k);

        initialSelection(k, meanxaxis, meanyaxis);
        for(int z = 0; z < iteration; z++){
            assignClusters(k, meanxaxis, meanyaxis);
            calculateMeans(k, meanxaxis, meanyaxis);
        }
    }

};

int main(int argc, char *argv[]){
    if(argc == 1){
        cout << "No command line arguments given!" << endl;
        exit(1);
    }
    int k = atoi(argv[1]);
    int iteration = atoi(argv[2]);
    ofstream file ("~/Assignment 1(Clustering)/Data/kmeans_output.txt");
    KMeansClustering data;
    data.kMeans(k, iteration);
    for(int i = 0; i < data.clusters.size(); i++){
        file << data.clusters[i] << endl;
    }
    file.close();

}
