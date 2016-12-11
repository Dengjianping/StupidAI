#include <iostream>
#include <vector>
#include <stdio.h>
#include <cmath>

#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <thrust\host_vector.h>
#include <thrust\device_vector.h>

using namespace std;

template <class Type>
class Array
{
private:
    Type* array;
    unsigned int size;
public:
    Array() {};
    Array(const int length);
    int Size() const { return size; };
    void changeValue(int index, Type newValue);
    ~Array() { delete[] array; };
};

template <class Type>
Array<Type>::Array(const int length)
{
    size = length;
    array = new Type[lengt];
    for (size_t i = 0; i < size; i++)
    {
        a[i] = rand() % 10;
    }
}

template <class Type>
void Array<Type>::changeValue(int index, Type newValue)
{
    if (index > size)
    {
        cout << "out of range" << endl;
        return;
    }
    a[index] = newValue;
}

template <class Type>
class Matrix
{
private:
    Type** matrix;
    int row, col;
public:
    //Matrix();
    Matrix(const int r, const int c);
    void changeValue(int i, int j, Type newValue);
    int Row() const { return row; };
    int Col() const { return col; };
    ~Matrix();
};

template <class Type>
Matrix<Type>::Matrix(const int r, const int c)
{
    row = r, col = c;
    matrix = new Type *[col];
    for (size_t i = 0; i < col; i++)
    {
        matrix[i] = new Type[row];
    }

    for (size_t i = 0; i < row; i++)
    {
        for (size_t j = 0; j < col; j++)
        {
            matrix[i][j] = rand() % 10;
        }
    }
}

template <class Type>
void Matrix<Type>::changeValue(int i, int j, Type newValue)
{
    if (i > row || j > col)
    {
        cout << "out of range" << endl;
        return;
    }
    matrix[i][j] = newValue;
}

template <class Type>
Matrix<Type>::~Matrix()
{
    for (size_t i = 0; i < col; i++)
    {
        delete[] matrix[i];
    }
    delete[] matrix;
}

template <class Type>
class LinearRegression
{
private:
    vector<vector<Type> > trainX;
    vector<Type> trainY;
    Type learnRate;
    Type precision;
public:
    LinearRegression() { trainX = { {} }; trainY = {}; learnRate = (Type)0; precision = (Type)0; }
    LinearRegression(vector<vector<Type> > & featureX, vector<Type> & featureY, Type convergenceRate, Type convergencePrecision);
    __host__ __device__ Type hypothesis();
    __host__ __device__ Type costFunction();
    __host__ __device__ Type partialDerivation();
    __host__ __device__ void train();
    ~LinearRegression() {};
};

template<class Type>
LinearRegression<Type>::LinearRegression(vector<vector<Type> > & featureX, vector<Type> & featureY, Type convergenceRate, Type convergencePrecision)
{
    trainX = featureX;
    trainY = featureY;
    learnRate = convergenceRate;
    precision = convergencePrecision;
}

template <class Type>
__host__ __device__ Type LinearRegression<Type>::hypothesis()
{

}

template <class Type>
__host__ __device__ Type LinearRegression<Type>::costFunction()
{

}

int main()
{
    const int N = 3;
    vector<int> k = { 1,2,4 };
    thrust::host_vector<int> h_m = k;
    thrust::host_vector<int> h_n = k;

    thrust::device_vector<int> d_m = h_m;
    thrust::device_vector<int> d_n = h_n; 
    thrust::device_vector<int> d_c;

    int f[N] = { h_m.data };


    cout << f[0] << endl;
    cout << f[1] << endl;
    cout << f[2] << endl;
    system("pause");
    return 0;
}