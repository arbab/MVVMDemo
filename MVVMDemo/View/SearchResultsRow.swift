//
//  SearchResultsRow.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/16/24.
//

import Foundation
import SwiftUI

//Create View for Search Results Row
struct SearchResultsRow: View {
    var result: SearchResultsRowViewModel
    var body: some View {
        HStack {
            AsyncImage (url: result.imageURL) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "photo")
            }
            .frame(width: 100, height: 100)
            .cornerRadius(8.0)
            .background()
            .shadow(radius: 8.0)
            VStack(alignment: .leading) {
                Text(result.trackName)
                Text(result.artistName)
                Text(result.primaryGenreName)
                Text(result.releaseDate)
            }
        }
        
    }
}

struct SearchResultsRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsRow(result: SearchResultsRowViewModel(model: SearchResult.mockSearchResult))
            .previewLayout(.fixed(width: 320, height: 120))
    }
}

//#Preview {
//    SearchResultsRow(result: SearchResultsRowViewModel(model: SearchResult.mockSearchResult))
//    
//}
