//Differemtial equations using Finite Difference Methods

#include <iostream>
#include <cmath>

using namespace std;

int main()
{
int sum_node, i, iter, itermax, convergence;
float interval_x, h, early_guess, y0, yN, a1, a2, a3, a4, error;
float x[21], y_old[21], y_new[21];
	
itermax = 1;
interval_x = 1; //domain calculation
sum_node = 21;
h = interval_x/(sum_node-1);
x[0] = 0;
x[sum_node-1] = interval_x - x[0];
y0 = 0; yN = 100; //boundary
	
//initialization
early_guess = 6.5;
for(i=1; i<sum_node-1;i++) {
x[i] = x[i-1] + h;
y_old[i] = early_guess;
}
	
//boundary conditions
y_old[0] = y0; y_old[sum_node-1] = yN;
y_new[0] = y0; y_new[sum_node-1] = yN;
	
//differential equations
a1 = 1/(2-10*h*h);
a2 = 1-2.5*h;
a3 = 1+2.5*h;
a4 = 10*h*h;
	
//looping the calculation
iter=0;
do{
iter++;
convergence=1;
	for(i=1;i<sum_node-1;i++){
	y_new[i] = a1*(a2 * y_old[i+1]+a3*y_old[i-1]-a4*x[i]); //Jacobi
	//y_new[i] = a1*(a2 * y_old[i+1]+a3*y_new[i-1]-a4*x[i]); //Seidel
	error = abs((y_new[i]-y_old[i])/y_old[i]);
	if(error>1e-3){convergence=0;}	
	}
				
	//updating value
	for(i=1;i<sum_node-1;i++) {
	y_old[i] = y_new[i];
	}
cout << "Iteration" <<iter<<"\n";
}while((convergence==0) && (iter<itermax));
	
for(i=0;i<sum_node;i++) {
cout<<x[i]<<","<<y_new[i]<<"\n";
}
return 0;
}
	
