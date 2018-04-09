#include <iostream>

#include <TestClass.hpp>

TestClass::TestClass()
{
	std::cout << "TestClass constructor" << std::endl;
}

TestClass::~TestClass()
{
	std::cout << "TestClass destructor" << std::endl;
}
