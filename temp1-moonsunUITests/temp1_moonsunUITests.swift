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
    func testAddAndEditTemperature() throws {
        let app = XCUIApplication()
        app.launch()
        // Tap "+" to add a new temperature
        app.buttons["plus"].tap()
        
        // Find the new cell and tap to navigate
        let newCell = app.cells.element(boundBy: 0)
        XCTAssertTrue(newCell.waitForExistence(timeout: 2))
        newCell.tap()

        // Tap the Keyboard button to activate the TextField
        let keyboardButton = app.buttons["Keyboard"]
        XCTAssertTrue(keyboardButton.exists)
        keyboardButton.tap()

        // Find the TextField
        let tempTextField = app.textFields.element(boundBy: 0)
        XCTAssertTrue(tempTextField.waitForExistence(timeout: 2))
        tempTextField.tap()

        // Replace the value
        tempTextField.clearAndEnterText(text: "25")
        app.keyboards.buttons["return"].tap()

        // Optionally go back
        app.navigationBars.buttons.element(boundBy: 0).tap()

        // Verify the updated temperature in the list
        XCTAssertTrue(app.staticTexts["25 *C"].exists)
    }

    @MainActor
    func testDeleteTemperature() throws {
        let app = XCUIApplication()
        app.launch()
        // Add a temperature
        app.buttons["plus"].tap()
        
        let cellCountBefore = app.cells.count
        XCTAssertTrue(cellCountBefore > 0)
        
        // Tap Edit and delete first cell
        app.buttons["Edit"].tap()
        let firstCell = app.cells.element(boundBy: 0)
        firstCell.swipeLeft()
        firstCell.buttons["Delete"].tap()

        let cellCountAfter = app.cells.count
        XCTAssertTrue(cellCountAfter == cellCountBefore - 1)
    }

    @MainActor
    func testTemperatureSaveAndLoad() throws {
        let app = XCUIApplication()
        app.launch()

        // Tap "+" to add a temperature
        app.buttons["plus"].tap()

        // Get the label of the newly added item
        let newCell = app.cells.element(boundBy: 0)
        XCTAssertTrue(newCell.waitForExistence(timeout: 2))

        let temperatureLabel = newCell.staticTexts.element.label
        print("Saved temperature: \(temperatureLabel)")

        // Simulate app relaunch (terminate and relaunch)
        app.terminate()
        app.launch()

        // After relaunch, verify the same temperature is still in the list
        let firstCellAfterRelaunch = app.cells.element(boundBy: 0)
        XCTAssertTrue(firstCellAfterRelaunch.waitForExistence(timeout: 2))

        let labelAfterRelaunch = firstCellAfterRelaunch.staticTexts.element.label
        XCTAssertEqual(temperatureLabel, labelAfterRelaunch, "Loaded temperature should match saved temperature")
    }

    @MainActor
    func testModifyTemperatureView() throws {
        let app = XCUIApplication()
        app.launch()

        // Tap '+' to add a temperature
        app.buttons["plus"].tap()

        // Tap the newly added cell to go to ModifyTempView
        let newCell = app.cells.element(boundBy: 0)
        XCTAssertTrue(newCell.waitForExistence(timeout: 2))
        newCell.tap()

        // Test TextField input
        let textField = app.textFields["TempTextField"]
        XCTAssertTrue(textField.waitForExistence(timeout: 2))

        app.buttons["ShowKeyboardButton"].tap()
        textField.clearAndEnterText(text: "37")
        app.keyboards.buttons["return"].tap()
        XCTAssertEqual(textField.value as? String, "37")

        // Test Slider - swipe to change
        let slider = app.sliders["TempSlider"]
        XCTAssertTrue(slider.exists)
        slider.adjust(toNormalizedSliderPosition: 0.9) // moves close to 50
        // (No direct way to assert the value from slider, but you could assert later via the list)

        // Test Stepper - tap stepper + twice
        let stepper = app.steppers["TempStepper"]
        XCTAssertTrue(stepper.exists)
        stepper.buttons["Increment"].tap()
        stepper.buttons["Increment"].tap()

        // Navigate back and verify the updated value appears
        app.navigationBars.buttons.element(boundBy: 0).tap()
        let updatedText = app.staticTexts.containing(NSPredicate(format: "label CONTAINS 'C'")).firstMatch
        XCTAssertTrue(updatedText.exists)
    }


//    @MainActor
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    @MainActor
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
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
