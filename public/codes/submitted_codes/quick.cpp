#include<iostream>
#include<climits>
#include <chrono>
#include <utility>
#include <iomanip>
#include<bits/stdc++.h>
using namespace std;
 
int partition(int arr[], int l, int r);
 

int kthSmallest(int arr[], int l, int r, int k)
{
    if (k > 0 && k <= r - l + 1)
    {
        int pos = partition(arr, l, r);
 
        if (pos-l == k-1)
            return arr[pos];
        if (pos-l > k-1)  
            return kthSmallest(arr, l, pos-1, k);
 
        return kthSmallest(arr, pos+1, r, k-pos+l-1);
    }
 
    return INT_MAX;
}
 
void swap(int *a, int *b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
}
 
int partition(int arr[], int l, int r)
{
    int x = arr[r], i = l;
    for (int j = l; j <= r - 1; j++)
    {
        if (arr[j] <= x)
        {
            swap(&arr[i], &arr[j]);
            i++;
        }
    }
    swap(&arr[i], &arr[r]);
    return i;
}
 
int main()
{
    int INPUTS;
    int arr[100002];
    int runs = 10;
    float sum = 0;
    int m;
    INPUTS=100000;
    cout<<std::setw(15)<<"INPUTS"<<std::setw(30)<< "Time taken" <<endl;
    while(INPUTS>1)
    {
        runs=10;
        sum=0;
        while(runs--)
        {
            int k = rand()%INPUTS + 1;
            for(int i=0;i<INPUTS;i++)
            {
                arr[i]=rand();
            }
            
            std::chrono::high_resolution_clock::time_point t1 = std::chrono::high_resolution_clock::now();
            int m=kthSmallest(arr, 0, INPUTS-1, k);
            std::chrono::high_resolution_clock::time_point t2 = std::chrono::high_resolution_clock::now();      

            auto duration = std::chrono::duration_cast<std::chrono::microseconds>( t2 - t1 ).count();
            //cout<<"Time taken: "<< duration <<endl;
            sum += duration;
            //cout<<"Sum"<<sum<<endl;
        }
        cout<<std::setw(15)<<INPUTS<<std::setw(30)<< sum/10 <<endl;
        INPUTS-=1000;
    }
    return 0;
}
