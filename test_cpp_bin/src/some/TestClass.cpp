#include <iostream>

#include <some/TestClass.hpp>

some::TestClass::TestClass()
{
	std::cout << "TestClass constructor" << std::endl;
}

some::TestClass::~TestClass()
{
	std::cout << "TestClass destructor" << std::endl;
}
