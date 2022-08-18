//
//  ContentView.swift
//  LearningApp
//
//  Created by Shamsuddin Refaei on 11/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
                //confirm current module is set
                if model.currentModule != nil {
                    
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                        
                        NavigationLink(destination: {
                            
                            ContentDetailView()
                                .onAppear {
                                    model.beginLesson(lessonIndex: index)
                                }
                        }, label: {
                            
                            ContentViewRow(index: index)
                        })
                    }
                }
            }
            .tint(.black)
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}
