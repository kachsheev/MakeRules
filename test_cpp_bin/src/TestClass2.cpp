#include <iostream>

#include <TestClass2.hpp>

TestClass2::TestClass2()
{
	std::cout << "TestClass2 constructor" << std::endl;
}

TestClass2::~TestClass2()
{
	std::cout << "TestClass2 destructor" << std::endl;
}
