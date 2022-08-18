//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Shamsuddin Refaei on 12/08/2022.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            
            //only show video if valid url
            if url != nil {
                
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            //description
            
            //show next lesson button if next lesson exists
            if model.hasNextLesson() {
                
                Button(action: {
                    
                    //advance the lesson
                    model.nextLesson()
                }, label: {
                    
                    ZStack {
                        
                        Rectangle()
                            .frame(height: 48)
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex].title)")
                            .foregroundColor(.white)
                            .bold()
                    }
                })
            }
        }
        .padding()
    }
}
