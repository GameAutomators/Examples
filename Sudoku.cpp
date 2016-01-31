#include <iostream>
#include <stdio.h>

#define UNASSIGNED 0
#define N 9

using namespace std;
int Solution(int mtr[N][N]);
int Find(int mtr[N][N], int &row, int &col);
int RowCheck(int mtr[N][N], int row, int num);
int ColCheck(int mtr[N][N], int col, int num);
int BoxCheck(int mtr[N][N], int boxStartRow, int boxStartCol, int num);
int Check(int mtr[N][N], int row, int col, int num);
void Display(int mtr[N][N]);


int Solution(int mtr[N][N])
{
    int row, col;
 
    if (!Find(mtr, row, col))
    {
       return 1;
    }
 
    for (int num = 1; num <= 9; num++)
    {
        if (Check(mtr, row, col, num))
        {

            mtr[row][col] = num;

            if (Solution(mtr))
            {
                return 1;
            }
 
            mtr[row][col] = UNASSIGNED;
        }
    }
    return 0;
}

int Find(int mtr[N][N], int &row, int &col)
{
    for (row = 0; row < N; row++)
    {
        for (col = 0; col < N; col++)
        {
            if (mtr[row][col] == UNASSIGNED)
            {
                return 1;
            }
        }
    }
    return 0;
}

int RowCheck(int mtr[N][N], int row, int num)
{
    for (int col = 0; col < N; col++)
    {
        if (mtr[row][col] == num)
        {
            return 1;
        }
    }
    return 0;
}
int ColCheck(int mtr[N][N], int col, int num)
{
    for (int row = 0; row < N; row++)
    {
        if (mtr[row][col] == num)
        {
            return 1;
        }
    }
    return 0;
}

int BoxCheck(int mtr[N][N], int boxStartRow, int boxStartCol, int num)
{
    for (int row = 0; row < 3; row++)
    {
        for (int col = 0; col < 3; col++)
        {
            if (mtr[row+boxStartRow][col+boxStartCol] == num)
            {
                return 1;
            }
        }
    }
    return 0;
}

int Check(int mtr[N][N], int row, int col, int num)
{
    return !RowCheck(mtr, row, num) && !ColCheck(mtr, col, num) && !BoxCheck(mtr, row - row%3 , col - col%3, num);
}

void Display(int mtr[N][N])
{
    for (int row = 0; row < N; row++)
    {
       for (int col = 0; col < N; col++)
    	{
    		cout<<mtr[row][col];
		}
		cout<<"\n";
    }
}

int main()
{
    int mtr[N][N];
    cout<<"Enter the matrix:\n";
	for(int i=0;i<N;i++)
	{
		for(int j=0;j<N;j++)
		{
			cin>>mtr[i][j];
		}
	}
	
	if (Solution(mtr) == 1)
    {
		Display(mtr);
	}
    else
	{
		cout<<"No solution exists";
	}
 
    return 0;
}
