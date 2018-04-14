#include <iostream>

#include <some/TestClass3.hpp>

some::TestClass3::TestClass3()
{
	std::cout << "TestClass3 constructor" << std::endl;
}

some::TestClass3::~TestClass3()
{
	std::cout << "TestClass3 destructor" << std::endl;
}
