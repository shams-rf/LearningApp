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
        
        //only show video if valid url
        if url != nil {
            
            VideoPlayer(player: AVPlayer(url: url!))
        }
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
            .environmentObject(ContentModel())
    }
}
