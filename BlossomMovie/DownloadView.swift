//
//  DownloadView.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 20/03/26.
//

import SwiftUI
import SwiftData

struct DownloadView : View {
    @Query var savedTitles: [Title]
    
    var body: some View {
        NavigationStack {
            if savedTitles.isEmpty {
                Text("No downloads")
                    .padding()
                    .font(.title3)
                    .bold()
            } else {
                VerticalListView(titles: savedTitles, canDelete: true)
            }
        }
    }
}
