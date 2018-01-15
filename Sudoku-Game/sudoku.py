#!/usr/bin/python
'''
	Sudoku Solver using BackTrack
	Accepts cmd line argument 1 as length of string 81 from row wise
	and print solved sudoku of length string 81
	
	Author: Rajmani Arya
	Date: 17th March 2016
'''
class sudoku:
	def __init__(self):
		self.row = 0
		self.col = 0

	def find_blank_cell(self, grid):
		for i in range(0, 9):
			for j in range(0, 9):
				if grid[i][j] == 0:
					self.row = i
					self.col = j
					return True
		return False

	def is_safe_row(self, grid, row, value):
		for i in range(0, 9):
			if grid[row][i] == value:
				return False
		return True

	def is_safe_col(self, grid, col, value):
		for i in range(0, 9):
			if grid[i][col] == value:
				return False
		return True

	def is_safe_box(self, grid, srow, scol, value):
		for i in range(0, 3):
			for j in range(0, 3):
				if grid[srow+i][scol+j] == value:
					return False
		return True

	def is_safe(self, grid, row, col, value):
		return self.is_safe_row(grid, row, value) and self.is_safe_col(grid, col, value) and self.is_safe_box(grid, row-row%3, col-col%3, value)

	def solve(self, grid):
		if self.find_blank_cell(grid) == False:
			return True
		for value in range(1, 10):
			row = self.row
			col = self.col
			if self.is_safe(grid, row, col, value):
				grid[row][col] = value
				if self.solve(grid):
					return True
				grid[row][col] = 0
		return False


grid = [[0 for i in range(9)] for j in range(9)]

import sys

if sys.argv[1] == None or len(sys.argv[1]) != 81:
	print 'error'
	sys.exit(0)
else:
	for i in range(0, 81):
		grid[int(i/9)][i%9] = int(sys.argv[1][i])

s = sudoku()

if s.solve(grid):
	st = ''
	for i in range(0, 9):
		st += ''.join(map(str,grid[i]))
	print st
else:
	print 'error'
