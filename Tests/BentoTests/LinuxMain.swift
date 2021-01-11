import XCTest

import bentoTests

/** refer to the test suite */
var tests = [XCTestCaseEntry]()
tests += bentoTests.allTests()
XCTMain(tests)
