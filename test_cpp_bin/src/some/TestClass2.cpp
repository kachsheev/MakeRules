#include <iostream>

#include <some/TestClass2.hpp>

some::TestClass2::TestClass2()
{
	std::cout << "TestClass2 constructor" << std::endl;
}

some::TestClass2::~TestClass2()
{
	std::cout << "TestClass2 destructor" << std::endl;
}
