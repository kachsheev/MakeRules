#include <iostream>

#include <TestClass.hpp>
#include <TestClass2.hpp>
#include <TestClass3.hpp>
#include <TestClass4.hpp>

#include <some/TestClass.hpp>
#include <some/TestClass2.hpp>
#include <some/TestClass3.hpp>
#include <some/TestClass4.hpp>

int main()
{
	TestClass testClass;
	TestClass2 testClass2;
	TestClass3 testClass3;
	TestClass4 testClass4;

	some::TestClass someTestClass;
	some::TestClass2 someTestestClass2;
	some::TestClass3 someTestestClass3;
	some::TestClass4 someTestestClass4;

	return 0;
}
