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
class LinearRegression
{
private:
    int row, col;
    Type** trainX;
    Type* trainY;
    Type* theta;
    float learnRate;
    float precision;
public:
    //__host__ __device__ LinearRegression() { trainX = { {} }; trainY = {}; learnRate = 0.0; precision = 0.0; }
    LinearRegression(vector<vector<Type> > & featureX, vector<Type> & featureY, float convergenceRate, float convergencePrecision);
    __host__ __device__ int Row() const { return row; };
    __host__ __device__ int Col() const { return col; };
    __host__ __device__ Type hypothesis(Type* x);
    __host__ __device__ Type costFunction();
    __host__ __device__ Type partialDerivation(int index);
    __host__ __device__ void updateTheta();
    __host__ __device__ void train();
    ~LinearRegression();
};

template<class Type>
LinearRegression<Type>::LinearRegression(vector<vector<Type> > & featureX, vector<Type> & featureY, float convergenceRate, float convergencePrecision)
{
    row = featureX.size(); col = featureX[0].size();

    // initialize trainX
    trainX = new Type*[col];
    for (size_t i = 0; i < col; i++)
    {
        trainX[i] = new Type[row];
    }
    for (size_t i = 0; i < row; i++)
    {
        for (size_t j = 0; j < col; j++)
        {
            trainX[i][j] = featureX[i][j];
        }
    }

    trainY = new Type[row];
    for (size_t i = 0; i < row; i++)
    {
        trainY[i] = featureY[i];
    }

    theta = new Type[col];
    for (size_t i = 0; i < col; i++)
    {
        theta[i] = (Type)0;
    }
    
    learnRate = convergenceRate;
    precision = convergencePrecision;
}

template <class Type>
__host__ __device__ Type LinearRegression<Type>::hypothesis(Type* x)
{
    Type hypo = 0;
    for (size_t i = 0; i < col; i++)
    {
        hypo += x[i] * theta[i];
    }
    return hypo;
}

template <class Type>
__host__ __device__ Type LinearRegression<Type>::costFunction()
{
    Type cost = 0;
    for (size_t i = 0; i < row; i++)
    {
        Type t = hypothesis(trainX[i]) - trainY[i];
        cost += powf(t, 2);
    }
    return 0.5*cost / row;
}

template <class Type>
__host__ __device__ Type LinearRegression<Type>::partialDerivation(int index)
{
    Type partial = 0;
    for (size_t i = 0; i < row; i++)
    {
        Type t = hypothesis(trainX[i]) - trainY[i];
        partial += t*trainX[i][index];
    }
    return partial / row;
}

template <class Type>
__host__ __device__ void LinearRegression<Type>::updateTheta()
{
    for (size_t i = 0; i < col; i++)
    {
        theta[i] -= learnRate*partialDerivation(i);
    }
}

template <class Type>
__host__ __device__ void LinearRegression<Type>::train()
{
    Type lastCostValue = costFunction();
    int epoch = 0;
    for (;;)
    {
        epoch += 1;
        // update theta
        updateTheta();
        if (fabsf(costFunction() - lastCostValue) <= precision)break;
        else lastCostValue = costFunction();
    }
    printf("%f, %f\n", theta[0], theta[1]);
}

template <class Type>
__host__ __device__ LinearRegression<Type>::~LinearRegression()
{
    // delete trainX
    for (size_t i = 0; i < row; i++)
    {
        delete[] trainX[i];
    }
    delete[] trainX;
    // deelte trainY
    delete[] trainY;
    // delete theta
    delete[] theta;
}

int main()
{
    vector<vector<float> > x = { {1,1},{1,2},{1,3} };
    vector<float> y = { 6,10,14 };
    float lr = 0.3;
    float error = 1e-4;

    LinearRegression<float> ln(x, y, lr, error);
    ln.train();

    system("pause");
    return 0;
}