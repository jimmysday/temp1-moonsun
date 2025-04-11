//
//  temp1_moonsunUITests.swift
//  temp1-moonsunUITests
//
//  Created by ICS 224 on 2025-04-11.
//

import XCTest

final class temp1_moonsunUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

// lab3 sample ui tests
// import XCTest

// final class MemoryGame2025UITests: XCTestCase {
    
//     override func setUpWithError() throws {
//         // Put setup code here. This method is called before the invocation of each test method in the class.
        
//         // In UI tests it is usually best to stop immediately when a failure occurs.
//         continueAfterFailure = false
        
//         // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//     }
    
//     override func tearDownWithError() throws {
//         // Put teardown code here. This method is called after the invocation of each test method in the class.
//     }
    
//     @MainActor
//     func testSteppers() throws {
//         let app = XCUIApplication()
//         app.launch()
        
//         let toolbarButton = app.buttons["SettingsButton"]
//         toolbarButton.tap()
        
//         let rowcolStepper = app.steppers["NumRowsColsStepper"]
//         let rowColStepperDown = rowcolStepper.buttons["NumRowsColsStepper-Decrement"]
//         let rowColStepperUp = rowcolStepper.buttons["NumRowsColsStepper-Increment"]
        
//         let treasureStepper = app.steppers["NumTreasuresStepper"]
//         let treasureStepperDown = treasureStepper.buttons["NumTreasuresStepper-Decrement"]
//         let treasureStepperUp = treasureStepper.buttons["NumTreasuresStepper-Increment"]
        
//         XCTAssertEqual(rowcolStepper.label, "2 Rows/Columns")
//         for i in 3...11 {
//             rowColStepperUp.tap()
//             XCTAssertEqual(rowcolStepper.label, "\(min(i, 10)) Rows/Columns")
//             XCTAssertEqual(treasureStepper.label, "2 Treasures")
//         }
//         for i in stride(from: 9, to: 1, by: -1) {
//             rowColStepperDown.tap()
//             XCTAssertEqual(rowcolStepper.label, "\(max(i, 1)) Rows/Columns")
//             XCTAssertEqual(treasureStepper.label, "2 Treasures")
//         }
        
//         XCTAssertEqual(treasureStepper.label, "2 Treasures")
//         for i in 3...11 {
//             treasureStepperUp.tap()
//             XCTAssertEqual(rowcolStepper.label, "2 Rows/Columns")
//             XCTAssertEqual(treasureStepper.label, "\(min(i, 10)) Treasures")
//         }
//         for i in stride(from: 9, to: 1, by: -1) {
//             treasureStepperDown.tap()
//             XCTAssertEqual(rowcolStepper.label, "2 Rows/Columns")
//             XCTAssertEqual(treasureStepper.label, "\(max(i, 1)) Treasures")
//         }
//     }
    
//     @MainActor
//     func testImagePicker() throws {
//         let app = XCUIApplication()
//         app.launch()
        
//         let gameImage = app.images["GameViewImage"]
        
//         let toolbarButton = app.buttons["SettingsButton"]
//         toolbarButton.tap()
        
//         let leftButton = app.images["LeftArrowImage"]
//         let rightButton = app.images["RightArrowImage"]
//         let image = app.images["SelectedImage"]
        
//         XCTAssertEqual(image.label, "Brightness Higher")
//         for i in ["Partly Cloudy", "Mostly Cloudy", "Rain", "Brightness Higher"] {
//             rightButton.tap()
//             XCTAssertEqual(image.label, i)
//         }
        
//         leftButton.tap()
//         XCTAssertEqual(image.label, "Rain")
        
//         toolbarButton.tap()
//         XCTAssertEqual(gameImage.label, "Rain")
        
//         toolbarButton.tap()
//         rightButton.tap()
//         XCTAssertEqual(image.label, "Brightness Higher")
//     }
    
    
//     @MainActor
//     func testSaveLoad() throws {
//         let app = XCUIApplication()
//         app.launch()
        
//         let gameImage = app.images["GameViewImage"]
//         XCTAssertEqual(gameImage.label, "Brightness Higher")
        
//         let toolbarButton = app.buttons["SettingsButton"]
//         toolbarButton.tap()
        
//         let image = app.images["SelectedImage"]
//         let leftButton = app.images["LeftArrowImage"]
//         let rightButton = app.images["RightArrowImage"]
//         XCTAssertEqual(image.label, "Brightness Higher")
        
//         let rowcolStepper = app.steppers["NumRowsColsStepper"]
//         let rowColStepperDown = rowcolStepper.buttons["NumRowsColsStepper-Decrement"]
//         let rowColStepperUp = rowcolStepper.buttons["NumRowsColsStepper-Increment"]
//         XCTAssertEqual(rowcolStepper.label, "2 Rows/Columns")
        
//         let treasureStepper = app.steppers["NumTreasuresStepper"]
//         let treasureStepperDown = treasureStepper.buttons["NumTreasuresStepper-Decrement"]
//         let treasureStepperUp = treasureStepper.buttons["NumTreasuresStepper-Increment"]
//         XCTAssertEqual(treasureStepper.label, "2 Treasures")
        
//         rightButton.tap()
//         rowColStepperUp.tap()
//         treasureStepperUp.tap()
        
//         app.terminate()
//         app.launch()
        
//         XCTAssertEqual(gameImage.label, "Partly Cloudy")
        
//         toolbarButton.tap()
//         XCTAssertEqual(image.label, "Partly Cloudy")
//         XCTAssertEqual(rowcolStepper.label, "3 Rows/Columns")
//         XCTAssertEqual(treasureStepper.label, "3 Treasures")
        
//         leftButton.tap()
//         rowColStepperDown.tap()
//         treasureStepperDown.tap()
//     }
    
//     //    @MainActor
//     //    func testExample() throws {
//     //        // UI tests must launch the application that they test.
//     //        let app = XCUIApplication()
//     //        app.launch()
//     //    }
//     //
//     //    @MainActor
//     //    func testLaunchPerformance() throws {
//     //        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//     //            // This measures how long it takes to launch your application.
//     //            measure(metrics: [XCTApplicationLaunchMetric()]) {
//     //                XCUIApplication().launch()
//     //            }
//     //        }
//     //    }
// }
