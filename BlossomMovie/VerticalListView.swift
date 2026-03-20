//
//  VerticalListView.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 20/03/26.
//


import SwiftUI

struct VerticalListView : View {
    
    var titles: [Title]
    
    var body: some View {
        
        List(titles) { title in
            NavigationLink {
                TitleView(title: title)
            } label: {
                AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
                    HStack (spacing: 20) {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(3)
                            .frame(width: 150)
                        
                        Text(title.name ?? title.title ?? "")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                    }
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 250)
            }
        }
    }
}

#Preview {
    VerticalListView(titles: Title.previewTitles)
}
