//
//  CryptoCoinViewModelTest.swift
//  AssignmentTests
//
//  Created by Neha Jain on 18/11/24.
//

import XCTest

final class CryptoCoinViewModelTest: XCTestCase {
    
    var viewModel: CryptoCoinViewModel?
    var filters = [
        FilterOptionStruct(name: "Active Coins", isActive: true, isNew: false, type: "coin"),
        FilterOptionStruct(name: "Inactive Coins", isActive: false, isNew: false, type: "coin"),
        FilterOptionStruct(name: "Only Tokens", isActive: false, isNew: false, type: "token"),
        FilterOptionStruct(name: "Only Coins", isActive: false, isNew: false, type: "coin"),
        FilterOptionStruct(name: "New Coins", isActive: false, isNew: true, type: "coin")
    ]
    
    override func setUp() {
        super.setUp()
        viewModel = CryptoCoinViewModel()
        guard let response: [CryptoCoinModel] = ReadJsonDataFromMockFiles.shared.getJsonToModel(fileName: "MockResponse") else {
            return
        }
        viewModel?.filteredCoinsArray = response
        viewModel?.coinsArray = response
    }

    func test_CryptoCoinApiTesting() {
        let expectations = self.expectation(description: "API Testing")
        viewModel?.getCryptoCoin { isData in
            if isData {
                XCTAssertTrue(self.viewModel?.filteredCoinsArray.count ?? 0 > 0)
            }
            expectations.fulfill()
        }
        wait(for: [expectations])
    }
    
    func test_Search() {
        viewModel?.searchText = "Bit"
        viewModel?.searchCoin()
        XCTAssertTrue(self.viewModel?.filteredCoinsArray.count ?? 0 > 0)
    }
    
    func test_Filter() {
        viewModel?.selectedFilters = [
            FilterOptionStruct(name: "Active Coins", isActive: true, isNew: false, type: "coin"),
            FilterOptionStruct(name: "Inactive Coins", isActive: false, isNew: false, type: "coin")
        ]
        viewModel?.filterCoins()
        XCTAssertTrue(self.viewModel?.filteredCoinsArray.count ?? 0 > 0)
    }
}
