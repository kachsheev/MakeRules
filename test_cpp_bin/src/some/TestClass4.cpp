#include <iostream>

#include <some/TestClass4.hpp>

some::TestClass4::TestClass4()
{
	std::cout << "TestClass4 constructor" << std::endl;
}

some::TestClass4::~TestClass4()
{
	std::cout << "TestClass4 destructor" << std::endl;
}
