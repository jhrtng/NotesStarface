//
//  NotesStarfaceTests.swift
//  NotesStarfaceTests
//
//  Created by Johanna Reiting on 14.02.25.
//

import XCTest
@testable import NotesStarface
import CoreData


class TestCoreDataStack {
    static let shared = TestCoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NotesStarface")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType // Use in-memory store to not save objects permanently
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error loading test Core Data stack: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

class MockNotesViewModelDelegate: NSObject, NotesViewModelDelegate {
    var notes: [NoteEntity]?
    var viewModel: (any NotesStarface.NotesViewModel)!

    func notesDidUpdate(notes: [NoteEntity]) {
        self.notes = notes
    }
}

class NotesViewModelSearchTests: XCTestCase {
    var viewModel: NotesViewModel!
    var mockDelegate: MockNotesViewModelDelegate!
    var testContext: NSManagedObjectContext!
    
    override func setUp() {
        testContext = TestCoreDataStack.shared.context
        mockDelegate = MockNotesViewModelDelegate()
        viewModel = NotesViewModelImpl(delegate: mockDelegate, context: testContext)
        
        let notes = [
            createNote(title: "Shopping List", content: "Milk, Eggs, Bread.", context: testContext),
            createNote(title: "Workout Plan", content: "Cardio and Strength training.", context: testContext),
            createNote(title: "iOS Development", content: "Learn Combine and SwiftUI!", context: testContext),
            createNote(title: "After Work TODOs", content: "Call Sarah, Dinner with Brad, Buy groceries", context: testContext)
        ]
        
        viewModel.notes = notes
    }
    
    func createNote(title: String, content: String, context: NSManagedObjectContext) -> NoteEntity {
        
        let entity = NSEntityDescription.entity(forEntityName: "NoteEntity", in: testContext)!
        let note = NoteEntity(entity: entity, insertInto: testContext)
        note.title = title
        note.content = content
        
        return note
    }
    
    func testSearchForNotes_TitleMatch() {
        viewModel.searchForNotes(with: "Work")
            
        XCTAssertEqual(mockDelegate.notes!.count, 2)
        XCTAssertEqual(mockDelegate.notes![0].title, "Workout Plan")
        XCTAssertEqual(mockDelegate.notes![1].title, "After Work TODOs")
    }
        
    func testSearchForNotes_ContentMatch() {
        viewModel.searchForNotes(with: "Milk")
        
        XCTAssertEqual(mockDelegate.notes!.count, 1)
        XCTAssertEqual(mockDelegate.notes![0].title, "Shopping List")
    }

    func testSearchForNotes_NoMatch() {
        viewModel.searchForNotes(with: "Tuesday")
            
        XCTAssertEqual(mockDelegate.notes!.count, 0)
    }
    
    override func tearDown() {
        testContext = nil
        mockDelegate = nil
        viewModel = nil
        super.tearDown()
    }
}



final class NotesStarfaceTests: XCTestCase {

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

}
