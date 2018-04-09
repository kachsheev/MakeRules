#include <iostream>

#include <TestClass3.hpp>

TestClass3::TestClass3()
{
	std::cout << "TestClass3 constructor" << std::endl;
}

TestClass3::~TestClass3()
{
	std::cout << "TestClass3 destructor" << std::endl;
}
