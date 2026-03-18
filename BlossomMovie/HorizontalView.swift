//
//  HorizontalView.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 13/03/26.
//

import SwiftUI

struct HorizontalView: View {
    
    let header: String
    var titles : [Title]
    
    let viewModel = ViewModal()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header).font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(titles) { title in
                        AsyncImage(url: URL(string: title.posterPath ?? "")){ image in
                            image.resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 12))
                        } placeholder: {
                            ProgressView()
                        }.frame(width: 130, height: 230)
                    }
                }
            }
        }.frame(height: 250).padding()
    }
}

#Preview {
    HorizontalView(header: "Trending Movies", titles: Title.previewTitles)
}
