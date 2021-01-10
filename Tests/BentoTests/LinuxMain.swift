import XCTest

import bentoTests

var tests = [XCTestCaseEntry]()
tests += bentoTests.allTests()
XCTMain(tests)
