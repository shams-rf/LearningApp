//
//  ContentModel.swift
//  LearningApp
//
//  Created by Shamsuddin Refaei on 01/08/2022.
//

import Foundation

class ContentModel: ObservableObject {
    
    //list of modules
    @Published var modules = [Module]()
    
    //current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    //current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    //current lesson explanation
    @Published var lessonDescription = NSAttributedString()
    var styleData: Data?
    
    //current selected content and test
    @Published var currentContentSelected: Int?
    
    init() {
        
        getLocalData()
    }
    
    //MARK: - data methods
    func getLocalData() {
        
        //get url to json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            //read file into data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            //try to decode json into array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            //assign parsed modules to modules property
            self.modules = modules
        }
        catch {
            
            print("Couldn't parse local data")
        }
        
        //parse style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            //read file into data object
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }
        catch {
            
            print("Couldn't parse style data")
        }
    }
    
    //MARK: - module navigation methods
    func beginModule(moduleID: Int) {
        
        //find index of module id
        for index in 0..<modules.count {
            
            if modules[index].id == moduleID {
                
                //found matching module
                currentModuleIndex = index
                break
            }
        }
        
        //set current module
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(lessonIndex: Int) {
        
        //check lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            
            currentLessonIndex = lessonIndex
        }
        else {
            
            currentLessonIndex = 0
        }
        
        //set current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        
        //advance lesson index
        currentLessonIndex += 1
        
        //check if lesson index within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            //set current lesson
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        }
        else {
            
            //reset lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool {
        
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    //MARK: - code styling
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        //add styling data
        if styleData != nil {
            
            data.append(styleData!)
        }
        
        //add html data
        data.append(Data(htmlString.utf8))
        
        //convert to attributed string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            resultString = attributedString
        }
        
        return resultString
    }
}
