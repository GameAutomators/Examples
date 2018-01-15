#include <bits/stdc++.h>
#include <unistd.h>
using namespace std;
#define max 9
int width;
struct point {
	int row;
	int col;
	int up;
	int down;
	int left;
	int right;
};

int a[max][max] ={0};

vector<int> path[max];
vector<int> finalpath[max];

void print(int n){
	for(int i=0;i<width;i++)
	{
		for(int j=0;j<width;j++)
			cout<<a[i][j]<<" ";
		cout<<endl;
	}
}

void init(point &p){
	p.up =0;
	p.down =0;
	p.left=0;
	p.right =0;
}

bool checksrc(int src[],int n,int row,int col){
	for(int i=1;i<=n;i++)
	{
		if(src[i]/10 == row && src[i]%10 == col)
			return true;
	}
	return false;
}

void solve(int src[],int dest[],int n){
	stack<point> s;
	vector<int>::iterator it;
	int i=1;
	point p;
	init(p);
	p.row = src[i]/10;
	p.col = src[i]%10;

	map<string,int> m;

	s.push(p);
	int flg =0,fl=0;
	string str="";
	while(i<=n)
	{
		if(s.empty())
			break;
		p = s.top();
		s.pop();
		flg =0;fl=0;
		if(p.up==0)
		{
			p.up=1;
			s.push(p);

			if(p.row!=0 && a[p.row-1][p.col] == 0)
			{
				point temp;
				flg=1;
				init(temp);
			  	temp.row = p.row-1;
			  	temp.col = p.col;
				if(a[temp.row][temp.col] != 0) {
					it = path[a[temp.row][temp.col]].end()-1;
					path[a[temp.row][temp.col]].erase(it);
				}
			  	a[temp.row][temp.col]=i;
				it = path[i].end()-1;
				path[i].insert(it, temp.row*10+temp.col); // add point to path
			  	s.push(temp);
			}
			else if(p.row-1 == dest[i]/10 && p.col == dest[i]%10){
				i++;
				if(i<=n){
					flg=1;
					point temp;
					init(temp);
					temp.row=src[i]/10;
					temp.col = src[i]%10;
					s.push(temp);
				}
			}
		}
		else if(p.down ==0){
			p.down=1;
			s.push(p);
			if(p.row != width-1 && a[p.row+1][p.col]==0) {
				point temp;
				init(temp);
				flg=1;
				temp.row = p.row+1;
				temp.col = p.col;
				if(a[temp.row][temp.col] != 0) {
					it = path[a[temp.row][temp.col]].end()-1;
					path[a[temp.row][temp.col]].erase(it);
				}
				a[temp.row][temp.col] =i;
				it = path[i].end()-1;
				path[i].insert(it, temp.row*10+temp.col); // add point to path
				s.push(temp);
			}
			else if(p.row+1 == dest[i]/10 && p.col == dest[i]%10){
				i++;
				if(i<=n){
					point temp;
					flg=1;
					init(temp);
					temp.row=src[i]/10;
					temp.col = src[i]%10;
					s.push(temp);
				}
			}
		}
		else if(p.left == 0){
			p.left=1;
			s.push(p);
			if(p.col != 0 && a[p.row][p.col-1] == 0){
				point temp;
				flg=1;
				init(temp);
				temp.row = p.row;
				temp.col = p.col-1;
				if(a[temp.row][temp.col] != 0) {
					it = path[a[temp.row][temp.col]].end()-1;
					path[a[temp.row][temp.col]].erase(it);
				}
				a[temp.row][temp.col] =i;
				it = path[i].end()-1;
				path[i].insert(it, temp.row*10+temp.col); // add point to path
				s.push(temp);
			}
			else if(p.row == dest[i]/10 && p.col-1 == dest[i]%10){
				i++;
				if(i<=n){
					point temp;
					init(temp);flg=1;
					temp.row=src[i]/10;
					temp.col = src[i]%10;
					s.push(temp);
				}
			}
		}
		else if(p.right ==0){
			p.right =1;
			s.push(p);
			if(p.col != width-1 && a[p.row][p.col+1]==0)
			{
				point temp;
				init(temp);
				flg=1;
				temp.row = p.row;
				temp.col = p.col+1;
				if(a[temp.row][temp.col] != 0) {
					it = path[a[temp.row][temp.col]].end()-1;
					path[a[temp.row][temp.col]].erase(it);
				}
				a[temp.row][temp.col] =i;

				it = path[i].end()-1;
				path[i].insert(it, temp.row*10+temp.col); // add point to path
				s.push(temp);
			}
			else if((p.row == (dest[i]/10)) && ((p.col+1) == dest[i]%10)){
				i++;
				if(i<=n){
					point temp;
					init(temp);flg=1;
					temp.row=src[i]/10;
					temp.col = src[i]%10;
					s.push(temp);
				}
			}
		}

		if(i<=n && p.up==1 && p.down==1 && p.left ==1 && p.right ==1 && flg==0 && !checksrc(src,n,p.row,p.col)) {
			int _tmp=a[p.row][p.col];
			a[p.row][p.col] = 0;
			if(path[_tmp].size() >= 1){
				it = path[i].end()-2;
				path[_tmp].erase(it);
			}
		}

		if(i>0 && p.up ==1 && p.down==1 && p.left ==1 && p.right ==1 && flg==0 &&(p.row == src[i]/10 && p.col ==src[i]%10))
			i--;
	}
}

int main(int argc,char *argv[]){
	int src[10],dest[10];
	if(argc < 3) {
		printf("usage: ./flow <size> <input_string>\n");
		exit(1);
	}

	width = atoi(argv[1]);
	int flg[width+1]={0};
	int n=0;

	for(int i=0;i<strlen(argv[2]);i++)
	{
		a[i/width][i%width] = argv[2][i]-'0';
		if(a[i/width][i%width] != 0 && flg[a[i/width][i%width]]==0)
		{
		 	n++;
		 	src[a[i/width][i%width]] = (i/width)*10+(i%width);
		 	path[(int)(argv[2][i]-'0')].push_back((i/width)*10+(i%width)); // src for a color (x,y) => (i/10, i%10)
		 	for(int k=0;k<strlen(argv[2]);k++){
		 		if(i!=k && a[i/width][i%width] == (argv[2][k]-'0'))
		 		{
		 			dest[a[i/width][i%width]]=((k/width)*10+(k%width));
					path[(int)(argv[2][k]-'0')].push_back((k/width)*10+(k%width)); // dest for a color (x,y) => (k/10, k%10)
		 			flg[a[i/width][i%width]]=1;
		 			break;
		 		}
		 	}
		 }
	}
	solve(src,dest,n);
	// print(n);
	int i,j,prev; bool vert, horz;
	for(i=1; i<=n ; i++) {
		prev = path[i][0];
		finalpath[i].push_back(prev);
		vert = horz = false;
		for (j=1; j < path[i].size()-1; j++) {
			if(prev%10 == path[i][j]%10 && path[i][j]%10 != path[i][j+1]%10) {
				prev = path[i][j];
				finalpath[i].push_back(prev);
			} else if(prev/10 == path[i][j]/10 && path[i][j]/10 != path[i][j+1]/10) {
				prev = path[i][j];
				finalpath[i].push_back(prev);
			}
		}
		finalpath[i].push_back(path[i][j]);
	}

	for(int i=1; i<=n ; i++) {
		for (int j=0; j < finalpath[i].size(); j++) {
			cout << finalpath[i][j] << " ";
		}
		cout << endl;
	}

	int _x = 0, _y=204;
	int _size = 720/width;
	int _x1, _y1, _x2, _y2; char buf[128];
	for (i = 1; i <= n; ++i)
	{
		for (j = 0; j < finalpath[i].size()-1; ++j)
		{
			//cout<<vec[i][j]<<" ";
			_x1 = _size*(finalpath[i][j]%10)+(_size/2);
			_y1 = _size*(finalpath[i][j]/10)+(_size/2)+204;
			_x2 = _size*(finalpath[i][j+1]%10)+(_size/2);
			_y2 = _size*(finalpath[i][j+1]/10)+(_size/2)+204;
			sprintf(buf, "adb shell input swipe %d %d %d %d 100", _x1, _y1, _x2, _y2);
			// printf("%s\n", buf);
			system(buf);
		}
	}
}
