//
//  Test_AusCityList_Kishor_iOSTests.swift
//  Test_AusCityList_Kishor_iOSTests
//
//  Created by Shiv on 18/02/25.
//

import XCTest
@testable import Test_AusCityList_Kishor_iOS

class MockCityRepository: CityRepositoryProtocol {
    func fetchCities() async throws -> [City] {
        return [City(city: "Sydney", admin_name: "New South Wales", population: "0", iso2: "AU")]
    }
}

final class Test_AusCityList_Kishor_iOSTests: XCTestCase {
    func testLoadCities() async {
        let mockRepo = MockCityRepository()
        let viewModel = await CityViewModel(repository: mockRepo)
        
        await viewModel.refreshData()
        
        // Access citiesByState inside MainActor.run
        await MainActor.run {
            XCTAssertFalse(viewModel.citiesByState.isEmpty)
            XCTAssertEqual(viewModel.citiesByState["New South Wales"]?.first?.city, "Sydney")
            
            /*------ Cross check with city name... for failed the test cases.------------*/
           // XCTAssertEqual(viewModel.citiesByState["New South Wales"]?.first?.city, "Surat", "This test should fail because Sydney is expected.")
            /*------------------------------------- End ---------------------------------*/
        }
    }
}

/*final class Test_AusCityList_Kishor_iOSTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}*/
