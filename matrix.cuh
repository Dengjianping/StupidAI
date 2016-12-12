#include <iostream>

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
