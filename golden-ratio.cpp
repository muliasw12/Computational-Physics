#include<iostream>
#include<math.h>

using namespace std;

#define f(x) x*2+x*3 //define a function 

int main()
{
	//Declare variable
	double a, b, R, h, p, f, f1, f2, x1, x2, e, x;
	int step = 1;
	
	
	//input value a, b, and error (e)
	up :
	cout << "lower index : " ;
	cin >> a;
	cout << "upper index : ";
	cin >> b;
	cout << "Tolerence error : ";
	cin >> e;
	
	// Optimation lower index and upper index
	R = 0.618;
	x1 = b - R*h;
	x2 = a + R*h;
	h = a + b;
	p = R*h;
	f1 = f(x1);
	f2 = f(x2);
	
	//Evaluation telescopic
	if (f1 > f2)
	{
		x1 = a;
		x2 = a + R*p;
		
	}
	
	
	//Menampilkan hasil nilai minimum dan maksimum 
	cout << "Minimum value : " << x1 << endl;
	cout << "Maximum value : " << x2  << endl;
	
	return 0;
	
	
}
