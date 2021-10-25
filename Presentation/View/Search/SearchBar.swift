//
//  SearchBar.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/25.
//

import SwiftUI
import UIKit

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var onCommit: () -> Void
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        var onCommit: () -> Void
        
        init(text: Binding<String>, onCommit: @escaping () -> Void) {
            _text = text
            self.onCommit = onCommit
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
            self.onCommit()
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, onCommit: self.onCommit)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
