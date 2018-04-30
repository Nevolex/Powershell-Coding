#include <iostream>
using namespace std;

int main()
{
	setlocale(0, "");
	/*7*/ int a, b; // 2 variables declaration of integer type
	cout << "Enter first numer: ";
	cin >> a; // user gives some value to variable
	cout << "Enter second number: ";
	cin >> b;
	/*12*/ int c = a + b; // for new variable give value of sum of entered data with user
	cout << "Sum of figures = " << c << endl; // answer output
	system("pause");
	return 0;
}